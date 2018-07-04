//
//  VoteVC.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 7/2/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class VoteVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var voteNameLbl: UILabel!
    @IBOutlet weak var voteQuestionLbl: UITextField!
    @IBOutlet weak var voteGroupLbl: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var current_user : Double  = 1
    var current_community = 0.0
    var current_group_id = 0.0
    var selectedAnswer = ""
    
    var vote : Vote = Vote()
    
    var arrayofid : [Double] = []{
        didSet{
            tableView.reloadData()
        }
    }
    var arrayofanswers : [String] = []{
        didSet{
            tableView.reloadData()
        }
    }
    var arrayofvotingid : [Double] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.voteNameLbl.text = vote.Voting_name
        self.voteQuestionLbl.text = vote.Voting_question
        
        let Answers_url = "http://team-space.000webhostapp.com/index.php/api/voting/answers"
        
        Alamofire.request(Answers_url).responseJSON { response in
            let result = response.result
               print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                
                for aDic in arrayOfDic{

                    let voting_id = ((aDic["Voting_Voting_id"] as! NSString).doubleValue)
                    
                    if(self.vote.Voting_id == voting_id){
                        self.arrayofid.append((aDic["Answer_id"] as!NSString).doubleValue)
                        self.arrayofanswers.append(aDic["Answer"] as! String)
                        self.arrayofvotingid.append((aDic["Voting_Voting_id"] as! NSString).doubleValue)
                        
                    }
                }
            }
        }
        
    }
    let menuList = ["Cheese", "Bacon", "Egg"]
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return arrayofanswers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:CustomiseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "customise") as! CustomiseTableViewCell
        cell.itemLabel.text = arrayofanswers[indexPath.row]
        cell.initCellItem()
        // Your logic....
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectedAnswer = arrayofanswers[indexPath.row]
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
}
