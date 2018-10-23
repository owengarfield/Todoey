//
//  ViewController.swift
//  Todoey
//
//  Created by Owen Richards on 21/10/2018.
//  Copyright © 2018 Owen Garfield. All rights reserved.
//

import UIKit
import CoreData


class ToDoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard

    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
//        loadItems()
        
    }

    //MARK - Tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return itemArray.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
       let item = itemArray[indexPath.row]
    
        cell.textLabel!.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }

    //MARK - Tableview deletage methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
    tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController.init(title: "Add new todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //What will happen once the user clicksthe add item button on our UIAlert
            
            
            
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
         alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
         textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }


    //MARK - Add new items section
    
    func saveItems() {
        
        do {
       try context.save()
        } catch {
            
            print("There was an error")
        }
        tableView.reloadData()
    }

//
//    func loadItems(){
//
//       if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//        do {
//       try itemArray = decoder.decode([Item].self, from: data)
//        } catch {
//            print("error")
//        }
//        }
//
//    }
}
