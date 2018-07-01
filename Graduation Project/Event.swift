//
//  Event.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 6/30/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import Foundation

class Event{
    
    var Event_id = ""
    var Event_name = ""
    var Event_description = ""
    var Event_location = ""
    var Event_date = ""
    var Groups_Group_id = ""
    var Groups_Community_Community_id = ""
    var Groups_Community_Users_User_id = ""
    
    static func createEvent(Event_id : String,
                     Event_name : String,
                     Event_description : String,
                     Event_location : String,
                     Event_date : String,
                     Groups_Group_id : String,
                     Groups_Community_Community_id : String,
                     Groups_Community_Users_User_id : String)-> Event{
    
        let event : Event = Event()
        event.Event_id = Event_id
        event.Event_name = Event_name
        event.Event_description = Event_description
        event.Event_location = Event_location
        event.Event_date = Event_date
        event.Groups_Group_id = Groups_Group_id
        event.Groups_Community_Community_id = Groups_Community_Community_id
        event.Groups_Community_Users_User_id = Groups_Community_Users_User_id
        
        return event
    }
}
