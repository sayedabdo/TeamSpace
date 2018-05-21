//
//  communitystructureVC.swift
//  Graduation Project
//
//  Created by Sayed Abdo on 5/20/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire


class communitystructureVC: UIViewController, UITableViewDataSource,UITableViewDelegate{
    
    var communityid = 0
    var displaytype = 0
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
    var arrayofnamesdescription : [String] = []{
        didSet{
            tableView.reloadData()
        }
    }
    var arrayofusersincommunity : [Int] = []{
        didSet{
        }
    }
    @IBOutlet weak var segmentstructure: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let group_get_url = "http://team-space.000webhostapp.com/index.php/api/groups"
        Alamofire.request(group_get_url).responseJSON { response in
            let result = response.result
            print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                    let community_id = Int((aDic["Community_Community_id1"]as! NSString).doubleValue)
                        if(community_id == self.communityid){
                            print("nice isa")
                            self.arrayofnames.append(aDic["Group_name"] as! String)
                            self.arrayofnamesdescription.append(aDic["Group_description"] as! String)
                            self.arrayofid.append((aDic["Group_id"] as! NSString).doubleValue)
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
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "CommunityStructureCell") as? CommunityStructureCell else { return UITableViewCell()
        }
        cell.Structurename.text = arrayofnames[indexPath.row] as! String
        cell.Structuredescription.text =  arrayofnamesdescription[indexPath.row] as! String
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CommunityStructureVC") as! communitystructureVC
//        nextViewController.communityid =  Int(arrayofid[indexPath.row])
//        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    
    
    @IBAction func segmentAction(_ sender: Any) {
        arrayofnames.removeAll()
        arrayofnamesdescription.removeAll()
        arrayofid.removeAll()
        
        displaytype = segmentstructure.selectedSegmentIndex
        if(displaytype == 1){
            let member_get_url = "http://team-space.000webhostapp.com/index.php/api/members"
            Alamofire.request(member_get_url).responseJSON { response in
                let result = response.result
                print("the result is : \(result.value)")
                if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                    for aDic in arrayOfDic{
                        let community_id = Int((aDic["Groups_Community_Community_id1"]as! NSString).doubleValue)
                        if(community_id == self.communityid){
                            print("nice isa")
                            self.arrayofusersincommunity.append(Int((aDic["user_id"]as! NSString).doubleValue))
                        }
                    }
                }
                
            }
            ////////////////
            var uniquecommunityid = removeDuplicateInts(values: arrayofusersincommunity)
            let url = "http://team-space.000webhostapp.com/index.php/api/users"
            Alamofire.request(url).responseJSON { response in
                let result2 = response.result
                print("the result is : \(result2.value)")
                if let arrayOfDic2 = result2.value as? [Dictionary<String, AnyObject>] {
                    for aDic2 in arrayOfDic2{
                        let user_id = Int((aDic2["User_id"]as! NSString).doubleValue)
                        for index in uniquecommunityid{
                            if(user_id == index){
                                self.arrayofnames.append(aDic2["User_name"] as! String)
                                self.arrayofnamesdescription.append(aDic2["E_mail"] as! String)
                                self.arrayofid.append((aDic2["User_id"] as! NSString).doubleValue)
                            }
                        }
                    }
            /////////////////
            
                }
            }
        }
        if(displaytype == 0){
            let group_get_url1 = "http://team-space.000webhostapp.com/index.php/api/groups"
            Alamofire.request(group_get_url1).responseJSON { response in
                let result1 = response.result
                print("the result is : \(result1.value)")
                if let arrayOfDic1 = result1.value as? [Dictionary<String, AnyObject>] {
                    for aDic1 in arrayOfDic1{
                        let community_id1 = Int((aDic1["Community_Community_id1"]as! NSString).doubleValue)
                        if(community_id1 == self.communityid){
                            print("nice isa")
                            self.arrayofnames.append(aDic1["Group_name"] as! String)
                            self.arrayofnamesdescription.append(aDic1["Group_description"] as! String)
                            self.arrayofid.append((aDic1["Group_id"] as! NSString).doubleValue)
                        }
                    }
                }
                
            }
        }
    }
    @IBAction func savebtn(_ sender: Any) {
    }

    @IBAction func addbtn(_ sender: Any) {
    }
    func removeDuplicateInts(values: [Int]) -> [Int] {
        // Convert array into a set to get unique values.
        let uniques = Set<Int>(values)
        // Convert set back into an Array of Ints.
        let result = Array<Int>(uniques)
        return result
    }
}
