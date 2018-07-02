//
//  MyEventsVC.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 2/13/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit
import Alamofire

class MyEventsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var current_user : Double  = 1
    var current_community = 0
    var arrayofid : [Double] = []{
        didSet{
            tableView.reloadData()
        }
    }
    var arrayofnames : [String] = []{
        didSet{
            tableView.reloadData()
        }
    }
    var arrayofnamesdescription : [String] = []{
        didSet{
            tableView.reloadData()
        }
    }
    var arrayofdates : [String] = []{
        didSet{
            tableView.reloadData()
        }
    }
    var arrayoflocations : [String] = []{
        didSet{
            tableView.reloadData()
        }

    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let Events_url = "http://team-space.000webhostapp.com/index.php/api/events"
        
        Alamofire.request(Events_url).responseJSON { response in
            let result = response.result
         //   print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                    let user_id = (aDic["Groups_Community_Users_User_id"]as! NSString).doubleValue
                    if(self.current_user == user_id){
                        self.arrayofnames.append(aDic["Event_name"] as! String)
                        self.arrayofnamesdescription.append(aDic["Event_description"] as! String)
                        self.arrayofdates.append(aDic["Event_date"] as! String)
                        self.arrayofid.append((aDic["Event_id"] as! NSString).doubleValue)
                        self.arrayoflocations.append(aDic["Event_location"] as! String)
                    }
                }
            }
        }
    }
    
    func numberOfSections(in tableview: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print("the count is : ",arrayofnames.count)
        return arrayofnames.count
    }
    
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "EventCell") as? EventCell else { return UITableViewCell()
        }
        cell.eventNameLbl.text = arrayofnames[indexPath.row] as! String
        cell.eventDescriptionLbl.text =  arrayofnamesdescription[indexPath.row] as! String
        
        var date = arrayofdates[indexPath.row] as! String
        let dateArr = date.characters.split{$0 == "-"}.map(String.init)
        cell.monthLbl.text = dateArr[1]
        cell.dayLbl.text = dateArr[2]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        var event: Event = Event()
        event = Event.createEvent(Event_id : "1",
                                  Event_name : arrayofnames[indexPath.row],
                                  Event_description : arrayofnamesdescription[indexPath.row],
                                  Event_location : arrayoflocations[indexPath.row],
                                  Event_date : arrayofdates[indexPath.row],
                                  Groups_Group_id : "1",
                                  Groups_Community_Community_id : "1",
                                  Groups_Community_Users_User_id : "1")
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EventVC") as! EventVC
        nextViewController.event = event
        print("SelectedEventName : ",event.Event_name)
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    @IBAction func createEventAction(_ sender: Any) {
        
     
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateEventVC") as! CreateEventVC
        
        
        self.present(nextViewController, animated:true, completion:nil)
    }
    


}
