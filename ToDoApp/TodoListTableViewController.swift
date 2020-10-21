//
//  TodoListTableViewController.swift
//  ToDoApp
//
//  Created by Egor Lass on 21.10.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    let itemArray = ["Call grandma", "Prepare to exam", "Go to doctor"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    

}
