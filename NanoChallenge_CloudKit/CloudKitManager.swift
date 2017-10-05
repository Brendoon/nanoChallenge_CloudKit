//
//  CloudKitManager.swift
//  NanoChallenge_CloudKit
//
//  Created by Brendoon Ryos on 04/10/17.
//  Copyright © 2017 Brendoon Ryos. All rights reserved.
//

import UIKit
import CloudKit
import UserNotifications


class CloudKitManager {
    static let shared = CloudKitManager()
    
    // Represents the default container specified in the iCloud section of the Capabilities tab for the project.
    let container: CKContainer
    let publicDB: CKDatabase    
    
    // MARK: - Initializers
    init() {
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
    }
    
    func save(drink: Drink, user: User) {
        
        let record2 = CKRecord(recordType: "Drinks")
        
        record2[.name] = drink.name
        record2[.descript] = drink.descript
        record2[.recipe] = drink.recipe
        record2[.drinkType] = drink.drinkType.rawValue
        
        guard let record = user.record else {
            print("User record is nil.")
            return
        }
        
        var drinks: [String] = []
        if !user.drinks.isEmpty {
            drinks = user.drinks
            drinks.append(record2.recordID.recordName)
        } else {
            drinks.append(record2.recordID.recordName)
        }
        
        self.updateUserRecord(record, drinks: drinks)
        
        publicDB.save(record2) { (record, error) in
            guard error == nil else {
                print("Problema ao tentar salvar o registro no Drinks")
                return
            }
            
            print("Registro do Drink salvo com sucesso")
        }
        
    }
    
    private func updateUserRecord(_ userRecord: CKRecord, drinks: [String]) {
        userRecord["drinks"] = drinks as CKRecordValue
        container.publicCloudDatabase.save(userRecord) { _, error in
            guard error == nil else {
                // top-notch error handling
                print("Error saving drinks", error?.localizedDescription)
                return
            }
            
            print("Successfully updated user record with new drink")
        }
    }
    
    private func updateUserRecord(_ userRecord: CKRecord, fullName: String) {
        userRecord["fullName"] = fullName as CKRecordValue
        container.publicCloudDatabase.save(userRecord) { _, error in
            guard error == nil else {
                // top-notch error handling
                return
            }
            
            print("Successfully updated user record with a fullname")
        }
    }
    
    func fetchUser(callback: @escaping (User?, Error?)-> Void){
        
        container.fetchUserRecordID { (recordID, error) in
            
            guard let recordID = recordID, error == nil else {
                // error handling magic
                callback(nil, error)
                return
            }
            print("Got user record ID \(recordID.recordName).")
            
            self.container.publicCloudDatabase.fetch(withRecordID: recordID) { record, error in
                guard let record = record, error == nil else {
                    // show off your error handling skills
                    callback(nil, error)
                    return
                }
                print("The user record is: \(record)")
                
                self.container.requestApplicationPermission(.userDiscoverability) { status, error in
                    guard status == .granted, error == nil else {
                        // error handling voodoo
                        return
                    }
                    
                    self.container.discoverUserIdentity(withUserRecordID: recordID) { identity, error in
                        guard let components = identity?.nameComponents, error == nil else {
                            // more error handling magic
                            return
                        }
                        
                        DispatchQueue.main.async {
                            let fullName = PersonNameComponentsFormatter().string(from: components)
                            let drinks = record[.drinks] as? [String] ?? []
                            
                            self.updateUserRecord(record, fullName: fullName)
                            
                            callback(User(fullName: fullName, drinks: drinks, record: record), nil)
                            print("The user's full name is \(fullName)")
                            
                        }
                    }
                }
                
            }
            
        }
        
        
    }
    
    func fetchDrink(callback: @escaping ([Drink]?, Error?)->Void) {
        // 1
        let predicate = NSPredicate(value: true)
        
        // 2
        let query = CKQuery(recordType: "Drinks", predicate: predicate)
        
        //3
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            guard error == nil else {
                callback(nil, error)
                return
            }
            
            guard let drinkRecords = records else {
                let e = NSError(domain: "", code: 500, userInfo: nil)
                callback(nil, e)
                return
            }
            
            let drinks = drinkRecords.map({ (record) -> Drink in
                let name = record.value(forKey: "name") as? String ?? ""
                let descript = record.value(forKey: "descript") as? String ?? ""
                let recipe = record.value(forKey: "recipe") as? String ?? ""
                let drinkType = record.value(forKey: "drinkType") as? String ?? ""
                let recordName = record.recordID.recordName
                
                
                return Drink(name: name, descript: descript, recipe: recipe, drinkType: DrinkType(rawValue: drinkType)!, recordName: recordName)
            })
            
            callback(drinks, nil)
        }
    }
    
//    func startObservingChanges() {
//        
//        if let sid = UserDefaults.standard.value(forKey: "subscriptionID") as? String {
//            print("Notificação já registrada \(sid)")
//            //            return
//        }
//        
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (authorized, error) in
//            guard error == nil, authorized else {
//                return
//            }
//            
//            self.getNotificationSettings()
//            
//            let subscription = CKQuerySubscription(recordType: self.MackStudentType, predicate: NSPredicate(value: true), options: [.firesOnRecordCreation])
//            
//            let info = CKNotificationInfo()
//            info.alertLocalizationKey = "mackstudents_updated_alert"
//            info.alertLocalizationArgs = ["name"]
//            info.soundName = "default"
//            info.desiredKeys = ["name"]
//            subscription.notificationInfo = info
//            
//            self.publicDB.save(subscription, completionHandler: { (savedSubscription, error) in
//                guard let savedSubscription = savedSubscription, error == nil else {
//                    print("Problema na Subscription \(error!)")
//                    return
//                }
//                
//                UserDefaults.standard.set(savedSubscription.subscriptionID, forKey: "subscriptionID")
//            })
//        }
//    }
//    
//    func getNotificationSettings() {
//        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
//            print("Notification settings: \(settings)")
//        }
//    }
}

