//
//  EventMembersVC.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 7/2/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class MembersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var group_id = 0
    var member_id = 1
    var selectedCells:[Int] = []
    
    @IBOutlet weak var membersTableView: UITableView!
    var arrayofid : [Double] = []{
        didSet{
            membersTableView.reloadData()
        }
    }
    var arrayofnames : [String] = []{
        didSet{
            membersTableView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        membersTableView.delegate = self
        membersTableView.dataSource = self
        membersTableView.allowsMultipleSelection = true
        
        let group_get_url = "http://team-space.000webhostapp.com/index.php/api/members"
        Alamofire.request(group_get_url).responseJSON { response in
            let result = response.result
            //print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                    let get_group_id = Int((aDic["Groups_Group_id"]as! NSString).doubleValue)
                    self.member_id = Int((aDic["user_idasmember"]as! NSString).doubleValue)
                    if(get_group_id == self.group_id){
                        ///////
                        let userurl = "http://team-space.000webhostapp.com/index.php/api/users"
                        Alamofire.request(userurl).responseJSON { response in
                            let result = response.result
                            //print("the result is : \(result.value)")
                            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                                for aDic in arrayOfDic{
                                    let usersasmembers = Int((aDic["User_id"]as! NSString).doubleValue)
                                    if(self.member_id == usersasmembers){
                                        self.arrayofnames.append(aDic["User_name"] as! String)
                                        self.arrayofid.append((aDic["User_id"] as! NSString).doubleValue)
                                    }
                                }

                            }
                        }
                        
                    }
                }
            }
        }   

    }
    
    func numberOfSections(in tableview: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("the count is : ",self.arrayofnames.count)
        return self.arrayofnames.count
    }
    
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = membersTableView.dequeueReusableCell(withIdentifier: "memberCell") as? MembersCell else { return UITableViewCell()
        }
        cell.memberNameLbl.text = self.arrayofnames[indexPath.row]
        print(arrayofnames)
        cell.accessoryType = self.selectedCells.contains(indexPath.row) ? .checkmark : .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if self.selectedCells.contains(indexPath.row) {
            self.selectedCells.remove(at:indexPath.row)
        } else {
            self.selectedCells.append(indexPath.row)
        }
        
        tableView.reloadData()
        /*
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "profile") as! profileVC
        self.present(nextViewController, animated:true, completion:nil)
        */
    }
    
    

   

}
