//
//  MyDrinksViewController.swift
//  NanoChallenge_CloudKit
//
//  Created by Gustavo Rodrigues on 04/10/17.
//  Copyright © 2017 Brendoon Ryos. All rights reserved.
//

import UIKit

class MyDrinksViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    fileprivate var drinks: [Drink] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadSections([0], with: .automatic)
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Drinks"
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableview.tableFooterView = UIView()
        
        CloudKitManager.shared.fetchUser { (user, error) in
            
            guard error == nil else {
                print("Ocorreu um erro na primeira busca")
                print(error!)
                return
            }
            
            guard let user = user else {
                print("user is nil")
                return
            }
            
            CloudKitManager.shared.user = user
        }
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
            
            self.drinks = drinks
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.getDrinks()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = drinks[indexPath.row].name
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let drink = self.drinks[indexPath.row] as? Drink {
                CloudKitManager.shared.delete(drink: drink)
                self.drinks.remove(at: indexPath.row)
            }
        }
    }
    
}
