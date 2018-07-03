//
//  MyVoteVC.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 4/20/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit
import Alamofire

class MyVoteVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var current_user : Double  = 1
    var current_community = 0.0
    var current_group_id = 0.0

    var arrayofid : [Double] = []{
        didSet{
            tableView.reloadData()
        }
    }
    var arrayofnames : [String] = []{
        didSet{
            tableView.reloadData()
        }
    }
    var arrayofquestions : [String] = []{
        didSet{
            tableView.reloadData()
        }
    }

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        let Votes_url = "http://team-space.000webhostapp.com/index.php/api/voting"
        
        Alamofire.request(Votes_url).responseJSON { response in
            let result = response.result
            //   print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                    let user_id = (aDic["Groups_Community_Users_User_id"]as! NSString).doubleValue
                    if(self.current_user == user_id){
                        self.arrayofid.append((aDic["Voting_id"] as! NSString).doubleValue)
                        self.arrayofnames.append(aDic["Voting_name"] as! String)
                        self.arrayofquestions.append(aDic["Voting_question"] as! String)
                    }
                }
            }
        }

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("the count is : ",arrayofnames.count)
        return arrayofnames.count
    }
    
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "voteCell") as? VoteCell else { return UITableViewCell()
        }
        cell.voteCreatorNameLbl.text = arrayofnames[indexPath.row] as! String
        cell.voteQuestionLbl.text =  arrayofquestions[indexPath.row] as! String

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

        var vote : Vote = Vote()
        print("__ID____",arrayofid[indexPath.row])
        
        var voteId = arrayofid[indexPath.row] as! Double
        var votename = arrayofnames[indexPath.row] as! String
        var votequestion = arrayofquestions[indexPath.row] as! String
        
        vote = Vote.createVote(Voting_id: voteId, Voting_name: votename, Voting_question: votequestion, Groups_Group_id: current_group_id, Groups_Community_Community_id: current_community, Groups_Community_Users_User_id: current_user)
        
        
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "vote") as! VoteVC
        nextViewController.vote = vote

        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    @IBAction func AddVoteAction(_ sender: Any){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "createVote") as! CreateVoteVC
        
        
        self.present(nextViewController, animated:true, completion:nil)
    }

}
