//
//  addmemberVC.swift
//  Graduation Project
//
//  Created by Sayed Abdo on 5/21/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class addmemberVC: UIViewController, UITableViewDataSource,UITableViewDelegate {

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
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let userurl = "http://team-space.000webhostapp.com/index.php/api/users"
        Alamofire.request(userurl).responseJSON { response in
            let result = response.result
            print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                        self.arrayofnames.append(aDic["User_name"] as! String)
                        self.arrayofemails.append(aDic["E_mail"] as! String)
                        self.arrayofid.append((aDic["User_id"] as! NSString).doubleValue)
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
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "addmemberCell") as? addmemberCell
            else { return UITableViewCell()
        }
        cell.membername.text = arrayofnames[indexPath.row] as! String
        cell.memberdescription.text =  arrayofemails[indexPath.row] as! String
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
   
    @IBAction func addMember(_ sender: Any) {
        print("HHHHHHHH")
    }
}
