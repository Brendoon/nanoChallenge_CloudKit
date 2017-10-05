//
//  Drink.swift
//  NanoChallenge_CloudKit
//
//  Created by Brendoon Ryos on 04/10/17.
//  Copyright © 2017 Brendoon Ryos. All rights reserved.
//

import Foundation

enum DrinkKey: String {
    case name
    case descript
    case recipe
    case drinkType
    case recordName
    case shared
}

enum DrinkType: String {
    case coffee
    case tea
}

struct Drink {
    
    let name: String
    let descript: String
    let recipe: String
    let drinkType: DrinkType
    let recordName: String?
    var shared: Bool
    
    init(name: String, descript: String, recipe: String, drinkType: DrinkType, recordName: String) {
        self.name = name
        self.descript = descript
        self.recipe = recipe
        self.drinkType = drinkType
        self.recordName = recordName
        self.shared = false
    }
    
    init(name: String, descript: String, recipe: String, drinkType: DrinkType) {
        self.name = name
        self.descript = descript
        self.recipe = recipe
        self.drinkType = drinkType
        self.recordName = nil
        self.shared = false
    }
    
    func string() -> String {
        return "\(name) - \(descript) - \(recipe) - \(drinkType.rawValue) - \(String(describing: recordName))"
    }
    
}
