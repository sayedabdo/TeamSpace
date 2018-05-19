//
//  CreatecommunitesVC.swift
//  Graduation Project
//
//  Created by Sayed Abdo on 5/12/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit
import Alamofire

class CommunitesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var displaycommuniytindex: UISegmentedControl!
    
    @IBOutlet weak var tableview: UITableView!
    var current_user : Double  = 1
    var communitytype = 0
    var arrayofnames : [String] = []{
        didSet{
            tableview.reloadData()
        }
    }
    var arrayofnamesdescription : [String] = []{
        didSet{
            tableview.reloadData()
        }
    }
//    var arrayofimages : [String] = []{
//        didSet{
//            tableview.reloadData()
//        }
//    }
    
    var arrayofcommunityid : [Double] = []{
        didSet{
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        // Do any additional setup after loading the view.
        let community_get_url = "http://team-space.000webhostapp.com/index.php/api/community"
        
        Alamofire.request(community_get_url).responseJSON { response in
            let result = response.result
            print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                    let user_id = (aDic["Users_User_id"]as! NSString).doubleValue
                    if(self.current_user == user_id){
                        self.arrayofnames.append(aDic["Community_name"] as! String)
                        self.arrayofnamesdescription.append(aDic["Community_description"] as! String)
                   }
                }
            }
        }
    }
    
    func numberOfSections(in tableview: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("the count is : ",arrayofnames.count)
        return arrayofnames.count
    }
    
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "communitesCell") as? communitesCell else { return UITableViewCell()
        }
        cell.communityname.text = arrayofnames[indexPath.row] as! String
        cell.communityDescription.text =  arrayofnamesdescription[indexPath.row] as! String
        return cell
    }
    
    
    @IBAction func createcommunity(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreatecommunityVC") as! CreatecommunityVC
        self.present(nextViewController, animated:true, completion:nil)    }
    
    @IBAction func changecommunities(_ sender: Any) {
        arrayofnames.removeAll()
        arrayofnamesdescription.removeAll()
        communitytype = displaycommuniytindex.selectedSegmentIndex
        if(communitytype == 1){
          let member_in_community = "http://team-space.000webhostapp.com/index.php/api/members"
            Alamofire.request(member_in_community).responseJSON { response in
                let result = response.result
               print("the result is : \(result.value)")
               if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                        let user_id = (aDic["user_id"]as! NSString).doubleValue
                         if(self.current_user == user_id){
                            let community_id = (aDic["Groups_Community_Community_id1"]as! NSString).doubleValue
                            self.arrayofcommunityid.append(user_id)
                            
                         }
                  }
               }
            }
        }
        //////////////////////////
        let community_get_url1 = "http://team-space.000webhostapp.com/index.php/api/community"
        Alamofire.request(community_get_url1).responseJSON { response in
            let result1 = response.result
            print("the result is : \(result1.value)")
            if let arrayOfDic1 = result1.value as? [Dictionary<String, AnyObject>] {
                for aDic1 in arrayOfDic1{
                    let community_id1 = (aDic1["Community_id"]as! NSString).doubleValue
                    for index in self.arrayofcommunityid{
                        if(community_id1 == arrayofcommunityid[index]){
                            print("nice isa")
                            self.arrayofnames.append(aDic1["Community_name"] as! String)
                            self.arrayofnamesdescription.append(aDic1["Community_description"] as! String)
                        }
                    }
                    
                }
            }
        }
        /////////////////////////
    }
    
}
