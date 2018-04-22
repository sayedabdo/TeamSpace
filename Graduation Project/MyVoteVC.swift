//
//  MyVoteVC.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 4/20/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit

class MyVoteVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var myVoteTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myVoteTableView.delegate = self
        myVoteTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myVoteCell", for: indexPath)
        return cell
    }

}
