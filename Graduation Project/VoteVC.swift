//
//  VoteVC.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 7/2/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit

class VoteVC: UIViewController{

    @IBOutlet weak var voteNameLbl: UILabel!
    @IBOutlet weak var voteQuestionLbl: UITextField!
    @IBOutlet weak var voteGroupLbl: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var vote : Vote = Vote()
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate = self
        //tableView.dataSource = self
        
        self.voteNameLbl.text = vote.Voting_name
        self.voteQuestionLbl.text = vote.Voting_question
    }
 
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
}
