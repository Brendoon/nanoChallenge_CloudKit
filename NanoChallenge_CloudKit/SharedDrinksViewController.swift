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
    var sharedDrinks: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shared Drinks"
        sharedDrinks.append("Chá de camomila")
        sharedDrinks.append("Chá de alecrim")
        sharedDrinks.append("Chá verde")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
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
        cell.textLabel?.text = sharedDrinks[indexPath.row]
        return cell
    }
   
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("entrou")
//        let sharedDrink = sharedDrinks[indexPath.row]
//        let storyboards = UIStoryboard(name: "Main", bundle: nil)
//        let infoDrink = storyboards.instantiateViewController(withIdentifier: "Info") as! InfoViewController
//        self.navigationController?.pushViewController(infoDrink, animated: true)
//    }



}
