//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Stefan Alexiev on 13.03.19.
//  Copyright © 2019 Stefan Alexiev. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        
        tableView.rowHeight = 75.0
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].backgroundColor ?? "1D9BF6")
        cell.textLabel?.textColor = UIColor.white
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }

        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.backgroundColor = UIColor.randomFlat.hexValue()

            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }

    // MARK : Save Data
    func save(category: Category){
        do {
            try realm.write{
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }

    // MARK : Load Data
    func load(){
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    // MARK : Delete & Update Data
    override func updateModel(at indexPath: IndexPath) {
         if let categoryForDeletion = self.categories?[indexPath.row] {
            super.updateModel(at: indexPath)
              do {
                 try self.realm.write{
                 self.realm.delete(categoryForDeletion)
                    }
                 } catch {
                 print("Error saving context \(error)")
                    }
                 }
    }
    
}

