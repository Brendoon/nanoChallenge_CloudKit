//
//  SharedDrinksViewController.swift
//  NanoChallenge_CloudKit
//
//  Created by Gustavo Rodrigues on 04/10/17.
//  Copyright © 2017 Brendoon Ryos. All rights reserved.
//

import UIKit

class SharedDrinksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var drinksFiltered: [Drink] = []
    fileprivate var sharedDrinks: [Drink] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadSections([0], with: .automatic)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shared Drinks"
//        sharedDrinks.append("Chá de camomila")
//        sharedDrinks.append("Chá de alecrim")
//        sharedDrinks.append("Chá verde")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        
        
        
    }
    
    func getDrinks() {
        CloudKitManager.shared.fetchDrink { (drinks, error) in
            guard error == nil else {
                print("Ocorreu um erro na primeira busca")
                print(error!)
                return
            }
            
            guard let drinks = drinks else {
                return
            }
            
            var control = false
            
            for drk in drinks {
                for i in self.sharedDrinks {
                    if drk.record?.recordID.recordName == i.record?.recordID.recordName && !self.sharedDrinks.isEmpty{
                        control = true
                    }
                }
                if control == false && drk.shared {
                    self.drinksFiltered.append(drk)
                }
            }
            
            self.sharedDrinks = self.drinksFiltered
            
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getDrinks()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedDrinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = sharedDrinks[indexPath.row].name
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drink = sharedDrinks[indexPath.row]
        let storyboards = UIStoryboard(name: "Main", bundle: nil)
        let infoDrink = storyboards.instantiateViewController(withIdentifier: "Info") as! InfoViewController
        
        infoDrink.drink = drink
        self.navigationController?.pushViewController(infoDrink, animated: true)
    }



}
