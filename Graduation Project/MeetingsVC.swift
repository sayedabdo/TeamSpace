//
//  ViewController.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 1/29/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit

class MeetingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    //Outlets
    
   
    @IBOutlet weak var meetingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = meetingsTableView.dequeueReusableCell(withIdentifier: "meetingCell", for: indexPath)
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    @IBAction func createMeeting(_ sender: Any) {
    }
}

