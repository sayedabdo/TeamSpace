//
//  GroupmembersVC.swift
//  Graduation Project
//
//  Created by Sayed Abdo on 5/21/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class GroupmembersVC: UIViewController, UITableViewDataSource,UITableViewDelegate {

    var group_id = 0
    var member_id = 0
    @IBOutlet weak var tableView: UITableView!
    
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
    var arrayofemails : [String] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let group_get_url = "http://team-space.000webhostapp.com/index.php/api/members"
        Alamofire.request(group_get_url).responseJSON { response in
            let result = response.result
            print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                    let get_group_id = Int((aDic["Groups_Group_id"]as! NSString).doubleValue)
                    self.member_id = Int((aDic["user_idasmember"]as! NSString).doubleValue)
                    if(get_group_id == self.group_id){
                        ///////
                        let userurl = "http://team-space.000webhostapp.com/index.php/api/users"
                        Alamofire.request(userurl).responseJSON { response in
                            let result = response.result
                            print("the result is : \(result.value)")
                            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                                for aDic in arrayOfDic{
                                  let usersasmembers = Int((aDic["User_id"]as! NSString).doubleValue)
                                    if(self.member_id == usersasmembers){
                                        self.arrayofnames.append(aDic["User_name"] as! String)
                                        self.arrayofemails.append(aDic["E_mail"] as! String)
                                        self.arrayofid.append((aDic["User_id"] as! NSString).doubleValue)
                                    }
                                }
                            
                        ///////
                        
                }
            }
            
        }
                }}}
        
        
        
    }
    
    func numberOfSections(in tableview: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("the count is : ",self.arrayofnames.count)
        return self.arrayofnames.count
    }
    
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "GroupmembersCell") as? GroupmembersCell else { return UITableViewCell()
        }
        cell.groupmembername.text = self.arrayofnames[indexPath.row]
        cell.groupmemberdescription.text =  self.arrayofemails[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "profile") as! profileVC
        nextViewController.email =  arrayofemails[indexPath.row] as! String
        self.present(nextViewController, animated:true, completion:nil)
    }
   
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func Addmember(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
