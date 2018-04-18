//
//  MeetingMembersVC.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 2/2/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit

class MeetingMembersVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var membersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = membersTableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }

}
