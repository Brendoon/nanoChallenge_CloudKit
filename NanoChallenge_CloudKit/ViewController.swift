//
//  ViewController.swift
//  NanoChallenge_CloudKit
//
//  Created by Brendoon Ryos on 03/10/17.
//  Copyright © 2017 Brendoon Ryos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let types = ["Coffee", "Tea"]
    @IBOutlet weak var tipo: UIPickerView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var recipeTextField: UITextField!
    @IBOutlet weak var descriptTextField: UITextField!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    @IBAction func Save(_ sender: Any) {
        
        
        
        if let name = nameTextField.text, !name.isEmpty, let descript = descriptTextField.text, !descript.isEmpty, let recipe = recipeTextField.text, !recipe.isEmpty {
            
             let type = types[tipo.selectedRow(inComponent: 0)]
            
            var drinkType = DrinkType.coffee
            if type == "Coffee" {
                drinkType = .coffee
            } else {
                drinkType = .tea
            }
            
            CloudKitManager.shared.save(drink: Drink(name: name, descript: descript, recipe: recipe, drinkType: drinkType), user: CloudKitManager.shared.user)
            
        }
   
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.setBottomBorder()
        recipeTextField.setBottomBorder()
        descriptTextField.setBottomBorder()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

