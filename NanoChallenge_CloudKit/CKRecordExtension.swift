//
//  CKRecordExtension.swift
//  CloudKitTutorial
//
//  Created by Joaquim Pessoa Filho on 02/10/17.
//  Copyright © 2017 Joaquim Pessoa Filho. All rights reserved.
//

import Foundation
import CloudKit

extension CKRecord {
    
    subscript(key: UserKey) -> Any? {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue as? CKRecordValue
        }
    }
    
    subscript(key: DrinkKey) -> Any? {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue as? CKRecordValue
        }
    }
    
    subscript(key: DrinkType) -> Any? {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue as? CKRecordValue
        }
    }
    
}
