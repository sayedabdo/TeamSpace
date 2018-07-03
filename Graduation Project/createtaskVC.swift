//
//  createtaskVC.swift
//  Graduation Project
//
//  Created by Sayed Abdo on 7/1/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class createtaskVC: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITableViewDataSource,UITableViewDelegate{
    
    
    let picker = UIImagePickerController()
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var tasktname: UITextField!
    @IBOutlet weak var taskdescription: UITextField!
    @IBOutlet weak var deadline: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var todobtn: UIButton!
    @IBOutlet weak var inprogressbtn: UIButton!
    @IBOutlet weak var donebtn: UIButton!
    
    var Group_id : String = "1"
    
    var Task_status : String = "TO DO"
    var communityid : Int = 1
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
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       getgroups()
    }
    
    
    
       @IBAction func Createtask(_ sender: Any) {
            let projecturl = "http://team-space.000webhostapp.com/index.php/api/tasks/add"
            let params: [String : String] =
                [    "Task_id"                                    : "\(1)",
                     "Task_name"                                  : "\(tasktname.text!)",
                     "Task_description"                           : "\(taskdescription.text!)",
                     "Task_deadlinne"                             : "\(deadline.date)",
                     "Task_status"                                : "\(Task_status)",
                     "Projects_Project_id"                        : "\(1)",
                     "Projects_Groups_Group_id"                   : "\(Group_id)",
                     "Projects_Groups_Community_Community_id"     : "\(1)",
                     "Projects_Groups_Community_Users_User_id"    : "\(1)"
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
    
    
    @IBAction func todofunc(_ sender: Any) {
        Task_status = "TO DO"
        todobtn.isEnabled = false
        inprogressbtn.isEnabled = true
        donebtn.isEnabled = true
    }
    
    @IBAction func inprogressfunc(_ sender: Any) {
        Task_status = "IN_Progress"
        todobtn.isEnabled = true
        inprogressbtn.isEnabled = false
        donebtn.isEnabled = true
    }
    
    @IBAction func donefunc(_ sender: Any) {
        Task_status = "DONE"
        todobtn.isEnabled = true
        inprogressbtn.isEnabled = true
        donebtn.isEnabled = false
    }
    func getgroups(){
        let group_get_url = "http://team-space.000webhostapp.com/index.php/api/groups"
        Alamofire.request(group_get_url).responseJSON { response in
            let result = response.result
            print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                    let community_id = Int((aDic["Community_Community_id"]as! NSString).doubleValue)
                    if(community_id == self.communityid){
                        self.arrayofnames.append(aDic["Group_name"] as! String)
                        self.arrayofnamesdescription.append(aDic["Group_description"] as! String)
                        self.arrayofid.append((aDic["Group_id"] as! NSString).doubleValue)
                        self.tableView.reloadData()
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
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "groupintaskCell") as? groupintaskCell else { return UITableViewCell()
        }
        cell.Structurename.text = arrayofnames[indexPath.row] as! String
        cell.Structuredescription.text =  arrayofnamesdescription[indexPath.row] as! String
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
      //  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
     //   let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GroupmembersVC") as! GroupmembersVC
     //   nextViewController.group_id =  Int(arrayofid[indexPath.row])
        Group_id = String(Int(arrayofid[indexPath.row]))
    //    self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    

}
