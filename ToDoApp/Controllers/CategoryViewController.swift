//
//  CategoryViewController.swift
//  ToDoApp
//
//  Created by Egor Lass on 23.10.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

    }

    //MARK: - Add New Category
    
    @IBAction func AddBarButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
             
             let alert = UIAlertController(title: "Add New ToDo Category ", message: "", preferredStyle: .alert)
             
             let action = UIAlertAction(title: "Add", style: .default) { (action) in
                 guard let categoryText = textField.text else { return }
                 let newCategory = Category(context: self.context)
                 newCategory.name = categoryText
                 self.categoryArray.append(newCategory)
                 self.saveCategories()
             }
             
             alert.addTextField { (alertTextField) in
                 alertTextField.placeholder = "Add a new category"
                 textField = alertTextField
             }
             
             alert.addAction(action)
             present(alert, animated: true, completion: nil)
        
    }
    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return categoryArray.count
       }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories() {
          do {
              try context.save()
          } catch {
              print("Error saving context, \(error)")
          }
          tableView.reloadData()
      }

      func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
          do {
              categoryArray = try context.fetch(request)
          } catch {
              print("Error fetching data from context, \(error)")
          }
          tableView.reloadData()
      }
    
}
