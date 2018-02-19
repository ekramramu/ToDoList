//
//  ViewController.swift
//  ToDoList
//
//  Created by Ekramul Hoque on 18/2/18.
//  Copyright © 2018 Ekramul Hoque. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {

    var items:[NSManagedObject] = []
    let called = "called"
   
    
    var alartActionGlobal:UIAlertAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.brown
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItem))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: called)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //createing the guard let statement And app delegae instance
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        // creatirng mange context
        let manageContext = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Item")
        
        do {
            
            items = try manageContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("fetal Error to retrribe data ",error)
        }
    }
    
    @objc func addItem(_ sender:AnyObject){
        
        
        let alartController = UIAlertController(title: "Add New Item", message: "Please Fill in the below ", preferredStyle: .alert)
        
//        alartController.addTextField { (textFiled:UITextField) in
//            textFiled.placeholder = "Enter Task List! "
//        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let textFiled = alartController.textFields?.first, let itemAdd = textFiled.text else {return}
           
            self.save(itemAdd)
            self.tableView.reloadData()
            
        }
        
     
        let cancelAction = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        
       alartController.addTextField(configurationHandler: nil)
        alartController.addAction(saveAction)
        alartController.addAction(cancelAction)
        present(alartController, animated: true, completion: nil)
        
    }

    
    func save(_ itemName:String) {
        
        //creating apps delegate delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}

        //create manage object context instance
        
        let manageObjectContext = appDelegate.persistentContainer.viewContext
        
        //creating entity
        
        let entity = NSEntityDescription.entity(forEntityName: "item", in: manageObjectContext)!
        
        //create item
        
        let item = NSManagedObject(entity: entity, insertInto: manageObjectContext)
        item.setValue(itemName, forKey: "itemName")
        
        do {
            
            try manageObjectContext.save()
            items.append(item)
        } catch let error as NSError {
         
            print("fetal error to save it ",error)
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
   
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: called, for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.value(forKey: "itemName") as? String
        return cell
    }

    
    
    

}

