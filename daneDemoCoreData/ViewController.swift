//
//  ViewController.swift
//  daneDemoCoreData
//
//  Created by Jaewon Lee on 7/11/18.
//  Copyright © 2018 Jaewon Lee. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    var tableData:[User] = []
    var userEdting: Bool = false
    var editUserObject:[User] = []

    @IBOutlet weak var first_name: UITextField!
    @IBOutlet weak var last_name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var hobby: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if userEdting == false{
            createUser()
        }
        else{
            
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllPosts()
        createUser()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func createUser(){

        let newUser = User(context: context)
        newUser.first_name = first_name.text
        newUser.last_name = last_name.text
        newUser.hobby = hobby.text
        newUser.age = age.text
            
        saveContext()
        fetchAllPosts()

        print(newUser.first_name!, newUser.last_name!)
        
        
//        do{
//            try context.save()
//        }catch{
//            print(error)
//        }
        

    }
    
    func fetchAllPosts(){
        let request:NSFetchRequest<User> = User.fetchRequest()
        do {
            let posts = try context.fetch(request)
            
            // Here we can store the fetched data in an array
            tableData = posts
            tableView.reloadData()
            
            for post in posts{
                print(post.first_name, post.last_name)
            }
        } catch {
            print(error)
        }
    }
    
    
}


    extension ViewController: UITableViewDelegate, UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tableData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView .dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
            cell.textLabel?.text = tableData[indexPath.row].first_name
            cell.detailTextLabel?.text = tableData[indexPath.row].hobby
            return cell
        }
        

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        }
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {action, view, completionHandler in
                self.tableData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                completionHandler(false)
                //            tableView.reloadData()
            }
            
            
            let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
            return swipeConfig
        }
        
        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let editAction = UIContextualAction(style: . normal, title: "Edit"){action, view, completionHandler in
                self.editUserObject = [self.tableData[indexPath.row]]
                self.first_name.text = 
                completionHandler(false)


            }

            editAction.backgroundColor = UIColor.purple
            let swipeConfig = UISwipeActionsConfiguration(actions: [editAction])
            return swipeConfig
        }
    }
