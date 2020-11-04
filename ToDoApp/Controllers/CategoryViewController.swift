//
//  CategoryViewController.swift
//  ToDoApp
//
//  Created by Egor Lass on 23.10.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
    }
    
    override func viewWillAppear(_ animated: Bool) {
         guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation Controller does not exist.") }
        navBar.backgroundColor = UIColor(hexString: "1D9BF6")
        
    }
    //MARK: - Add New Category
    
    @IBAction func AddBarButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDo Category ",
                                      message: "",
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add",
                                   style: .default)
        { (action) in
            guard let categoryText = textField.text else { return }
            let newCategory = Category()
            
            newCategory.name = categoryText
            newCategory.colour = UIColor.randomFlat().hexValue()
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int)
                            -> Int
    {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)
                            -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell",
                                                 for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added yet"
        
        cell.backgroundColor = UIColor(hexString: categoryArray?[indexPath.row].colour ?? "1D9BF6")
        
        guard let categoryColour = UIColor(hexString: (categoryArray?[indexPath.row].colour)!) else { fatalError() }
        //fix next row
        cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row] 
        }
    }
    
    //MARK: - Delete Items
    
    func tableView(tableView: UITableView,
                   canEditRowAtIndexPath indexPath: NSIndexPath)
                   -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            if let item = categoryArray?[indexPath.row] {
                do {
                    try realm.write {
                        realm.delete(item)
                    }
                } catch {
                    print("Error with deletion, \(error)")
                }
            }
        }
        tableView.reloadData()
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
}
