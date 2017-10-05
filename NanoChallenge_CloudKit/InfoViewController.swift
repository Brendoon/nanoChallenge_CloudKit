//
//  InfoViewController.swift
//  NanoChallenge_CloudKit
//
//  Created by Gustavo Rodrigues on 04/10/17.
//  Copyright © 2017 Brendoon Ryos. All rights reserved.
//

import UIKit
import CloudKit

class InfoViewController: UIViewController {

    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var receita: UILabel!
    @IBOutlet weak var tipo: UILabel!
    
    @IBOutlet weak var shareBtn: UIButton!
    var drink: Drink!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.tabBarController?.selectedIndex == 1 {
            self.shareBtn.isHidden = true
        } else {
            self.shareBtn.isHidden = false
        }
        
        if self.drink.shared {
            self.shareBtn.isEnabled = false
            self.shareBtn.setTitle("Shared", for: .disabled)
        }
        
        self.nome.text = drink.name
        self.descricao.text = drink.descript
        self.receita.text = drink.recipe
        self.tipo.text = drink.drinkType.rawValue
        
    }
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        CloudKitManager.shared.updateDrinkRecord(drink.record!, shared: "true")
        self.shareBtn.isEnabled = false
        self.shareBtn.setTitle("Shared", for: .disabled)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
