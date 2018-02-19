//
//  ViewController.swift
//  ToDoList
//
//  Created by Ekramul Hoque on 18/2/18.
//  Copyright © 2018 Ekramul Hoque. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var items:[String] = []
    let called = "called"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.brown
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItem))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: called)
    }
    
    @objc func addItem(_ sender:AnyObject){
        
        
        let alartController = UIAlertController(title: "Add New Item", message: "Please Fill in the below ", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard let textFiled = alartController.textFields?.first, let itemAdd = textFiled.text else {return}
            
            self.items.append(itemAdd)
            self.tableView.reloadData()
            
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        alartController.addAction(saveAction)
        alartController.addAction(cancelAction)
        present(alartController, animated: true, completion: nil)
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
   
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: called, for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }

    
    
    

}

