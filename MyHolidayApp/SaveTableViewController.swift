//
//  SaveTableViewController.swift
//  MyHolidayApp
//
//  Created by user199544 on 12/13/21.
//

import UIKit
import CoreData

class SaveTableViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var result:[SaveData] = []
    @IBOutlet var mytable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.fetch()
        self.mytable.reloadData()

       
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return result.count
    }

    func fetch()
    {

        let request = NSFetchRequest<SaveData>(entityName:"SaveData")

        do{
            result = try context.fetch(request)
            print(result)

        }catch{
            print(error)
        }
    }
    
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let rslt = result[indexPath.row]
        if(rslt.holiday != nil){
            
        }

        print(rslt.holiday!)
        cell.textLabel?.text? = rslt.holiday!
        cell.detailTextLabel?.text = rslt.date!
        return cell
    }
    
    override  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") { [self]  (contextualAction, view, boolValue) in
            //Code I want to do here
//            let data = Saveddata(context:N)
            let cell = tableView.cellForRow(at: indexPath)

            if(cell?.textLabel?.text != nil){                
                let cell = tableView.cellForRow(at: indexPath)
                    context.delete(self.result[indexPath.row])
                    self.fetch()
                    self.mytable.reloadData()
            }
           
            
            
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
//        contextItem.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
        return swipeActions
    }
    

   
    

}
