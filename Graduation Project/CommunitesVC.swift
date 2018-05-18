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

    @IBOutlet weak var tableview: UITableView!
    
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
                    self.arrayofnames.append(aDic["Community_name"] as! String)
                    self.arrayofnamesdescription.append(aDic["Community_description"] as! String)
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
}
