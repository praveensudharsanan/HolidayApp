//
//  HolidayTableViewController.swift
//  holidayApp
//
//  Created by user199544 on 12/8/21.
//
//
//  HolidayViewController.swift
//  holidayApp
//
//  Created by user199544 on 12/7/21.
//
import UIKit
import CoreData
class HolidayTableViewController : UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var listofHolidays = [HolidayDetail](){
        didSet{
            DispatchQueue.main.sync {
                self.tableView.reloadData()
                self.navigationItem.title="\(self.listofHolidays.count) Holidays Found"

                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        
    }
    func createItem(name:String,date:String)  {

        let newItem = SaveData(context: context)
        newItem.holiday = name
        newItem.date = date
        print("Added Succesfully")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView:UITableView,numberOfRowsInSection section:Int)->Int{
        return listofHolidays.count

            
           }
    
    

    override  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Save") {  (contextualAction, view, boolValue) in
            //Code I want to do here
//            let data = Saveddata(context:N)
            let cell = tableView.cellForRow(at: indexPath)

            if(cell?.textLabel?.text != nil){
                let date = (cell?.detailTextLabel?.text)!
                self.createItem(name: (cell?.textLabel?.text)!, date:date )
                print((cell?.textLabel?.text)!)
                print((cell?.detailTextLabel?.text)!)
                print("Swiped")
            }
           
            
            
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
//        contextItem.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
        return swipeActions
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for:indexPath)
        let holiday = listofHolidays[indexPath.row]
        cell.textLabel?.text = holiday.name
        cell.detailTextLabel?.text = holiday.date.iso
        return cell
    }
    
    }
extension HolidayTableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar:UISearchBar){

        guard  let searchBarText = searchBar.text else {
            return
            
        }
        let  holidayRequest = HolidayRequest(countryCode: searchBarText)
        holidayRequest.getHolidays{
            [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let holidays):
                self?.listofHolidays = holidays

            }
           
        }
        
    }

    
}

