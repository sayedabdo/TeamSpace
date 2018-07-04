//
//  CreateVoteVC.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 7/2/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class CreateVoteVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var voteQuestionTF: UITextField!
    @IBOutlet weak var voteGroup: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var options : [String] = []
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var addBtn: CircleBtn!
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            guard let cell = tableview.dequeueReusableCell(withIdentifier: "optionCell") as? optionCell else { return UITableViewCell()
            }

            cell.optionLbl.text = options[indexPath.row]
            return cell
    }
    

    
    @IBAction func createAction(_ sender: Any) {
        if(voteQuestionTF.text?.isEmpty)! {
            /* displayAlertMessage(title: "Error", messageToDisplay: "Please complete your data", titleofaction: "Try Again")*/
            return
        }
        else{
            let voteurl = "http://team-space.000webhostapp.com/index.php/api/voting/add"
            
            let params: [String : String] =
                [
                    "Voting_id" : "\(13)",
                    "Voting_name" : "vote",
                    "Voting_question" : "\(voteQuestionTF.text!)",
                    "Groups_Group_id" : "\(1)",
                    "Groups_Community_Community_id" : "\(1)",
                    "Groups_Community_Users_User_id" : "\(1)"
            ]
            
            Alamofire.request(voteurl, method: .post, parameters: params, encoding: JSONEncoding.default)
                .responseJSON { response in
                    print(response.result)
            }
            
            
            let answersurl = "http://team-space.000webhostapp.com/index.php/api/voting/answers/add"
            
            let option : [String : String] =
                [
                    "Answer_id": "\(8)",
                    "Answer": "\(options[0])",
                    "Voting_Voting_id": "\(13)",
                    "Voting_Groups_Group_id": "\(1)",
                    "Voting_Groups_Community_Community_id": "\(1)",
                    "Voting_Groups_Community_Users_User_id": "\(1)"
            ]
            
            Alamofire.request(answersurl, method: .post, parameters: option, encoding: JSONEncoding.default)
                .responseJSON { response in
                    print("*****Response***** : ",response.result)
                    
                   
            }
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "myVote") as! MyVoteVC
            self.present(nextViewController, animated:true, completion:nil)
            
        }

    }
    
    
    @IBAction func addAction(_ sender: Any) {

            options.append(textField.text!)
            textField.text = ""
            tableView.reloadData()
        
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectMembers(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "members") as! MembersVC
        self.present(nextViewController, animated:true, completion:nil)
    }

}
