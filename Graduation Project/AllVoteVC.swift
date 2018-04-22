//
//  AllVoteVC.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 4/20/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit

class AllVoteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var allVoteTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        allVoteTableView.delegate = self
        allVoteTableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allVoteCell", for: indexPath)
        return cell
    }


}
