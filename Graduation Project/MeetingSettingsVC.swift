//
//  MeetingSettingsVC.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 2/2/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit

class MeetingSettingsVC: UIViewController {
    
    
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var menuView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func settingsBtnPressed(_ sender: Any) {
        if(menuView.isHidden == true){
            menuView.isHidden = false
        }
        else{
            menuView.isHidden = true
        }
        
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
