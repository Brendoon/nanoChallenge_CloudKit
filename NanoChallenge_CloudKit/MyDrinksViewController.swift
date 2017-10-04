//
//  MyDrinksViewController.swift
//  NanoChallenge_CloudKit
//
//  Created by Gustavo Rodrigues on 04/10/17.
//  Copyright © 2017 Brendoon Ryos. All rights reserved.
//

import UIKit

class MyDrinksViewController: UIViewController,  UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    var drinks: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Drinks"
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableview.tableFooterView = UIView()
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
        cell.textLabel?.text = drinks[indexPath.row]
        return cell
    }
    
}
