//
//  createmyprojectVC.swift
//  Graduation Project
//
//  Created by Sayed Abdo on 6/30/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class createmyprojectVC: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource{
    
    
    let picker = UIImagePickerController()
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var projectname: UITextField!
    @IBOutlet weak var projectdescription: UITextField!
    @IBOutlet weak var tableview: UITableView!
    var current_user : Double  = 1
    var current_communityid = 1
    var selectedgroup = 0
    var current_group_id : String = "0"
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
        tableview.delegate = self
        tableview.dataSource = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getproject()
    }

    @IBAction func addmyproject(_ sender: Any) {
        if(projectname.text?.isEmpty)!{
            displayAlertMessage(title: "Error", messageToDisplay: "Project Name Is Empty 😡😡😡", titleofaction: "Try Again")
            return
        }
        if(projectdescription.text?.isEmpty)!{
            displayAlertMessage(title: "Error", messageToDisplay: "Project Description Is Empty 😡😡😡", titleofaction: "Try Again")
            return
        }
        if(selectedgroup == 0){
            displayAlertMessage(title: "Error", messageToDisplay: "Please, Select Group 😡😡😡", titleofaction: "Try Again")
            return
        }
        let projecturl = "http://team-space.000webhostapp.com/index.php/api/projects/add"
        let params: [String : String] =
                [   "Project_id"                       : "\(4)",
                    "Project_name"                     : "\(projectname.text!)",
                    "Project_description"              : "\(projectdescription.text!)",
                    "Groups_Group_id"                  : "\(current_group_id)",
                    "Groups_Community_Community_id"    : "\(current_communityid)",
                    "Groups_Community_Users_User_id"   : "\(current_user)"
                ]
        Alamofire.request(projecturl, method: .post, parameters: params, encoding: JSONEncoding.default)
                .responseJSON { response in
                print(response.result)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProjectsVC") as! ProjectsVC
                self.present(nextViewController, animated:true, completion:nil)
        }
    }
    
    @IBAction func changeimage(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    
    
    
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            present(myPickerController, animated: true, completion: nil)
        }
        
    }
    func photoLibrary()
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            present(myPickerController, animated: true, completion: nil)
            
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicked.contentMode = .scaleToFill
            imagePicked.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    //function to display alert
    func displayAlertMessage(title: String,messageToDisplay: String, titleofaction : String)
    {
        let alertController = UIAlertController(title: title, message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: titleofaction, style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    @IBAction func backtocommuity(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func getproject(){
        let group_get_url = "http://team-space.000webhostapp.com/index.php/api/groups"
        Alamofire.request(group_get_url).responseJSON { response in
            let result = response.result
            print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                    let community_id = Int((aDic["Community_Community_id"]as! NSString).doubleValue)
                    if(community_id == self.current_communityid){
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
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "groupsintaskCell") as? groupsintaskCell else { return UITableViewCell()
        }
        cell.groupname.text = arrayofnames[indexPath.row] as! String
        cell.groupDescription.text =  arrayofnamesdescription[indexPath.row] as! String
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
       current_group_id =  String(Int(arrayofid[indexPath.row]))
       selectedgroup = 1
        
    }
}
