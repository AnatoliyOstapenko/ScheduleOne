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
    
    var textField = UITextField()
    
    var currentItem: String?
    
    var weatherManager = WeatherManager()
    
    var temperature: String?

    var tempIcon: String?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        weatherManager.weatherDelegate = self

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
        
        let item = array[indexPath.row]
        // dispatch name of city to other VC
        guard let text = item.city else { return }
        currentItem = text
        weatherManager.getCityName(text)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let detailedButton = UIAlertAction(title: "show weather", style: .default) { (action) in
            
            self.performSegue(withIdentifier: "goToWeatherVC", sender: self)
        }
        
        let deleteButton = UIAlertAction(title: "delete city", style: .destructive) { (action) in
            self.deleteData(item)
        }
        
        let cancelButton = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alert.addAction(detailedButton)
        alert.addAction(deleteButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
        
       
    }
    // MARK: - Prepare Segue
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
        if segue.identifier == "goToWeatherVC" {
            
            let destination = segue.destination as! WeatherViewController
    
            destination.textLabel = currentItem
            destination.temp = temperature
            destination.pic = tempIcon
            
        }
  
    }
    
    // MARK: - Add New Item
    
    @IBAction func addBarButton(_ sender: UIBarButtonItem) {
        
       
        
        let alert = UIAlertController(title: "New City", message: "", preferredStyle: .alert)
        
        // text field
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "type city name"
            self.textField = alertTextField
        }
        
        // add buttons
        
        let addButton = UIAlertAction(title: "add", style: .default) { (action) in
            
            guard let text = self.textField.text else { return }
            
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
    
    func deleteData(_ item: ItemCoreData) {
        
        context.delete(item)
        saveData()
        
    }

}

// MARK: - Weather Delegate

extension ScheduleTableViewController: WeatherDelegate {
    func getData(_ temp: Float, _ icon: String) {
        temperature = String(format: "%.0f", temp)
        tempIcon = icon
    }
    
    
    
    
}

