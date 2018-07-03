//
//  ProjectsVC.swift
//  Graduation Project
//
//  Created by Sayed Abdo on 6/28/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire


class ProjectsVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableview: UITableView!
    var current_user : Double  = 1
    var current_community = 0
    var arrayofid : [Double] = []{
        didSet{
            tableview.reloadData()
        }
    }
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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self

        // Do any additional setup after loading the view.
        
        let project_url = "http://team-space.000webhostapp.com/index.php/api/projects"
        
        Alamofire.request(project_url).responseJSON { response in
            let result = response.result
            print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                    let user_id = (aDic["Groups_Community_Users_User_id"]as! NSString).doubleValue
                    if(self.current_user == user_id){
                        self.arrayofnames.append(aDic["Project_name"] as! String)
                        self.arrayofnamesdescription.append(aDic["Project_description"] as! String)
                        self.arrayofid.append((aDic["Project_id"] as! NSString).doubleValue)
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
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "ProjectsCell") as? ProjectsCell else { return UITableViewCell()
        }
        cell.projectname.text = arrayofnames[indexPath.row] as! String
        cell.projectDescription.text =  arrayofnamesdescription[indexPath.row] as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
       let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
       let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TasksVC") as! TasksVC
       nextViewController.current_ptoject_id = arrayofid[indexPath.row]
       self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addbtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "createmyprojectVC") as! createmyprojectVC
        self.present(nextViewController, animated:true, completion:nil)
    }


}
