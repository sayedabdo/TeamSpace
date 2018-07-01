//
//  CreateEventVC.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 6/30/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class CreateEventVC: UIViewController {
    @IBOutlet weak var eventNameTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!    
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!

    override func viewDidLoad() {
      
        super.viewDidLoad()
    }
    
    @IBAction func createEventAction(_ sender: Any) {
        if(eventNameTF.text?.isEmpty)! || (locationTF.text?.isEmpty)! || (descriptionTF.text?.isEmpty)!{
           /* displayAlertMessage(title: "Error", messageToDisplay: "Please complete your data", titleofaction: "Try Again")*/
            return
        }
        else{
            let eventurl = "http://team-space.000webhostapp.com/index.php/api/events/add"
            
            datePicker.datePickerMode = UIDatePickerMode.date
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            var selectedDate = dateFormatter.string(from: datePicker.date)
            
            let params: [String : String] =
                [
                    "Event_id" : "\(8)",
                    "Event_name" : "\(eventNameTF.text!)",
                    "Event_description" : "\(descriptionTF.text!)",
                    "Event_location" : "\(locationTF.text!)",
                    "Event_date" : "\(selectedDate)",
                    "Groups_Group_id" : "\(1)",
                    "Groups_Community_Community_id" : "\(1)",
                    "Groups_Community_Users_User_id" : "\(1)"
            ]
            
            Alamofire.request(eventurl, method: .post, parameters: params, encoding: JSONEncoding.default)
                .responseJSON { response in
                    print(response.result)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyEventsVC") as! MyEventsVC
                    self.present(nextViewController, animated:true, completion:nil)
            }

        }

    }

}
