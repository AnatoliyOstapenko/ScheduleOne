//
//  ScheduleTableViewController.swift
//  ScheduleOne
//
//  Created by MacBook on 19.09.2021.
//

import UIKit
import CoreData

class ScheduleTableViewController: UITableViewController {
    
    var array = [ItemCoreData]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadData()

    }

    // MARK: - TableView Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let item = array[indexPath.row]

        cell.textLabel?.text = item.city

        return cell
    }
    
    // MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let item = tableView.cellForRow(at: indexPath) else { return }
        
        guard let text = item.textLabel?.text else { return }
        
        print(text)
        
       
    }
    // MARK: - Add New Item
    
    @IBAction func addBarButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "New Item", message: "", preferredStyle: .alert)
        
        // text field
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "type here"
            textField = alertTextField
        }
        
        // add buttons
        
        let addButton = UIAlertAction(title: "add", style: .default) { (action) in
            
            guard let text = textField.text else { return }
            
            let item = ItemCoreData(context: self.context)
            
            item.city = text
            item.time = Date()
            
            self.array.append(item)
            
            self.saveData()
        }
        
        let cancelButton = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        

        alert.addAction(addButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    // MARK: - Core Data
    
    func saveData() {
        do {
            try context.save()
        } catch { print("saving error \(error)")}
        tableView.reloadData()
    }
    
    func loadData() {
        do {
            array = try context.fetch(ItemCoreData.fetchRequest())
        } catch { print("loading error \(error)")}
        
        
    }
   
    
    
}

