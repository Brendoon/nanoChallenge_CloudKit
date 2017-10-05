//
//  User.swift
//  NanoChallenge_CloudKit
//
//  Created by Brendoon Ryos on 04/10/17.
//  Copyright © 2017 Brendoon Ryos. All rights reserved.
//

import Foundation
import CloudKit

enum UserKey: String {
    case fullName
    case drinks
    case record
}

struct User {
    let fullName: String
    var drinks: [String]
    var record: CKRecord?
    
    init() {
        fullName = ""
        drinks = []
        record = nil
    }
    
    init(fullName: String, drinks: [String]) {
        self.fullName = fullName
        self.drinks = drinks
        self.record = nil
    }
    
    init(fullName: String, drinks: [String], record: CKRecord) {
        self.fullName = fullName
        self.drinks = drinks
        self.record = record
    }
    
    func string() -> String {
        return "\(fullName) - \(drinks) - \(String(describing: record))"
    }
}
