//
//  EventVC.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 6/30/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit

class EventVC: UIViewController {
    @IBOutlet weak var eventNameLbl: UILabel!
    @IBOutlet weak var eventDescriptionLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var groupLbl: UILabel!
    
    var event: Event = Event()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventNameLbl.text = event.Event_name
        eventDescriptionLbl.text = event.Event_description
        locationLbl.text = event.Event_location
        dateLbl.text = event.Event_date
        groupLbl.text = event.Groups_Group_id
        
        print("ViewedEventName : ",event.Event_name)
    }
    
        
}
