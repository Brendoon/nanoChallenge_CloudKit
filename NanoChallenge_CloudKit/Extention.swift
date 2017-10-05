//
//  Extention.swift
//  NanoChallenge_CloudKit
//
//  Created by Gustavo Rodrigues on 05/10/17.
//  Copyright © 2017 Brendoon Ryos. All rights reserved.
//

import UIKit

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 255.0/255.0, alpha: 1).cgColor
        //self.layer.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 247.0/255.0, alpha: 1).cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 211.0/255.0, green: 215.0/255.0, blue: 219.0/255.0, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
