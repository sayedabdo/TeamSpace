//
//  MessageVC.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 1/30/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit

class MessageVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var msgTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = msgTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        
        return cell
    }
    

    @IBAction func settingsBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toMeetingSettings", sender: nil)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    

}
