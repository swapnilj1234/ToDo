//
//  ViewController.swift
//  ToDo
//
//  Created by swapnil jadhav on 22/01/20.
//  Copyright © 2020 swapnil jadhav. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    var array = [item]()
    
    let datafilepath = FileManager.default.urls(for : .documentDirectory, in : .userDomainMask).first?.appendingPathComponent("items.plist")
           
    
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
       
        //print(datafilepath)
        
        /*
        let newItem = item()
        newItem.title = "Home"
        array.append(newItem)
        
        let newItem1 = item()
        newItem1.title = "About"
        array.append(newItem1)
        
        let newItem2 = item()
        newItem2.title = "contact"
        array.append(newItem2)
        */
        
        loaditems()
        
        /*
        if let items  = defaults.array(forKey: "todolistitem") as? [item]{
    
        array = items
        }*/
 
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //let cell = UITableViewCell(style: .default , reuseIdentifier: "ToDoList")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoList", for: indexPath)
       
        
        let item = array[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = item.done  ? .checkmark : .none
        
       
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        array[indexPath.row].done = !array[indexPath.row].done
        //print(array[indexPath.row])
        
        
        
        saveItem()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New To ToDo", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

            let newitems = item()
            newitems.title = textField.text!
            
            self.array.append(newitems)
            
           
            self.saveItem()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            
            textField = alertTextField
            
            
            print(alertTextField.text)
            print("Now")
            
    }
        
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
        
    }
    

    func saveItem()
    {
        let encoder = PropertyListEncoder()
                   
                   do
                   {
                       let data = try encoder.encode(self.array)
                       
                       try data.write(to :  self.datafilepath!)
                   }
                   catch
                   {
                       print("error encoding array \(error)")
                   }
                   //self.defaults.set(self.array,forKey: "todolistitem")
                   
                   self.tableView.reloadData()
    }
    
    func loaditems()
    {
        if let data = try? Data(contentsOf : datafilepath!)
        {
            let decoder = PropertyListDecoder()
            
            do {
               
                array = try decoder.decode([item].self,from : data)
            
            } catch  {
            print("error decoding \(error)")
            }
        }
    }
}

