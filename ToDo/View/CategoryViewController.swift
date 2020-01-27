//
//  CategoryViewController.swift
//  ToDo
//
//  Created by swapnil jadhav on 23/01/20.
//  Copyright © 2020 swapnil jadhav. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

        var array = [Categorys]()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
           
           
            //print(FileManager.default.urls(for : .documentDirectory, in : .userDomainMask))
           
            loaditems()
            
            
     
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return array.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
           
            
            let item = array[indexPath.row]
            
            cell.textLabel?.text = item.name
             
       return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            performSegue(withIdentifier: "goToItem", sender: self)
            //saveItem()
        }
        
    
    override func prepare(for segue: UIStoryboardSegue,sender: Any?)
    {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let  indexPath = tableView.indexPathForSelectedRow
        {
            destinationVC.selectedCategory = array[indexPath.row]
        }
    }
        
        
        @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
            
            var textField = UITextField()
            
            
            let alert = UIAlertController(title: "Add New To ToDo", message: "", preferredStyle: .alert)
            
            
            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

                
                let newitems = Categorys(context: self.context)
                
                 newitems.name = textField.text!
               
                self.array.append(newitems)
               
                self.saveItem()
                
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "create new item"
                
                textField = alertTextField
                
            
                
               // print(alertTextField.text)
                print("Now")
                
        }
            
            alert.addAction(action)
            present(alert,animated: true,completion: nil)
            
            
        }
        

        func saveItem()
        {
                       
                       do
                       {
                            try  context.save()
                       }
                       catch
                       {
                        
                        print("error saving context \(error)")
                       }
                       
                       self.tableView.reloadData()
        }
        
               
        func loaditems(with request : NSFetchRequest<Categorys> = Categorys.fetchRequest())
        {
            
            do
            
            {
                array =  try context.fetch(request)
            }
            catch
            {
                print("error in fetch \(error)")
            }
            tableView.reloadData()
        }
        
    
        
       
    }

    
 
 
