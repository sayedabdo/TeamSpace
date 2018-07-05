//
//  createtaskVC.swift
//  Graduation Project
//
//  Created by Sayed Abdo on 7/1/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class createtaskVC: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource{
    
    
    let picker = UIImagePickerController()
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var tasktname: UITextField!
    @IBOutlet weak var taskdescription: UITextField!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var deadline: UIDatePicker!
    @IBOutlet weak var todobtn: UIButton!
    @IBOutlet weak var inprogressbtn: UIButton!
    @IBOutlet weak var donebtn: UIButton!
    var task_status = "TO DO"
    var current_group_id = 1
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
    var arrayofemails : [String] = []{
        didSet{
            tableview.reloadData()
        }
    }
    var arrayofgroupid : [Double] = []{
        didSet{
        }
    }
    var selectedids : [Double] = []{
        didSet{
        }
    }
    var arrayoftasksid : [Double] = []{
        didSet{
        }
    }
    override func viewDidLoad() {
        
        tableview.delegate = self
        tableview.dataSource = self
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getmember()
    }
    
    
    
       @IBAction func Createtask(_ sender: Any) {
            let projecturl = "http://team-space.000webhostapp.com/index.php/api/tasks/add"
            let params: [String : String] =
                [    "Task_id"                                    : "\(1)",
                     "Task_name"                                  : "\(tasktname.text!)",
                     "Task_description"                           : "\(taskdescription.text!)",
                     "Task_deadlinne"                             : "\(deadline.date)",
                     "Task_status"                                : "\(task_status)",
                     "Projects_Project_id"                        : "\(1)",
                     "Projects_Groups_Group_id"                   : "\(1)",
                     "Projects_Groups_Community_Community_id"     : "\(1)",
                     "Projects_Groups_Community_Users_User_id"    : "\(1)"
            ]
            Alamofire.request(projecturl, method: .post, parameters: params, encoding: JSONEncoding.default)
                .responseJSON { response in
                    print(response.result)
            }
        
        
        
        let alertController = UIAlertController(title: "sdvsfv", message: "sdfsdfssdf", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            let tasks_get_url = "http://team-space.000webhostapp.com/index.php/api/tasks/add"
            Alamofire.request(tasks_get_url).responseJSON { response in
                let result = response.result
                print("the result is : \(result.value)")
                if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                    for aDic in arrayOfDic{
                            self.arrayoftasksid.append((aDic["Task_id"] as! NSString).doubleValue)
                    }
                }
            }
            //////
            let member_task_url = "http://team-space.000webhostapp.com/index.php/api/task/members/add"
            let params: [String : String] =
                [    "magical_id"                                      :"\(1)",
                     "member_id"                                       :"1",
                     "Tasks_Task_id"                                   :"1",
                     "Tasks_Projects_Project_id"                       :"1",
                     "Tasks_Projects_Groups_Group_id"                  :"1",
                     "Tasks_Projects_Groups_Community_Community_id"    :"1",
                     "Tasks_Projects_Groups_Community_Users_User_id"   :"1"
            ]
            Alamofire.request(member_task_url, method: .post, parameters: params, encoding: JSONEncoding.default)
                .responseJSON { response in
                    print(response.result)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProjectsVC") as! ProjectsVC
                    self.present(nextViewController, animated:true, completion:nil)
            }
            //////
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
        
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
        todobtn.isEnabled = false
        inprogressbtn.isEnabled = true
        donebtn.isEnabled = true
        task_status = "TO DO"
    }
    
    @IBAction func inprogressfunc(_ sender: Any) {
        todobtn.isEnabled = true
        inprogressbtn.isEnabled = false
        donebtn.isEnabled = true
        task_status = "IN-Progress"
        
    }
    
    @IBAction func donefunc(_ sender: Any) {
        todobtn.isEnabled = true
        inprogressbtn.isEnabled = true
        donebtn.isEnabled = false
        task_status = "DONE"
    }
    func numberOfSections(in tableview: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("the count is : ",self.arrayofnames.count)
        return self.arrayofnames.count
    }
    
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "membersintaskCell") as? membersintaskCell else { return UITableViewCell()
        }
        cell.membername.text = self.arrayofnames[indexPath.row]
        cell.memberDescription.text =  self.arrayofemails[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableview.dequeueReusableCell(withIdentifier: "membersintaskCell") as? membersintaskCell
        var selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.green
                self.selectedids.removeAll()
                self.selectedids.append(arrayofid[indexPath.row])
                print(self.selectedids.count)
    
    }
    func getmember(){
        let member_get_url = "http://team-space.000webhostapp.com/index.php/api/members"
        Alamofire.request(member_get_url).responseJSON { response in
            let result = response.result
            print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                    let group_id = Int((aDic["Groups_Group_id"]as! NSString).doubleValue)
                    if(group_id == self.current_group_id){
                        self.arrayofgroupid.append((aDic["user_idasmember"] as! NSString).doubleValue)
                    }
                }
            }
        }
    
      let url = "http://team-space.000webhostapp.com/index.php/api/users"
      Alamofire.request(url).responseJSON { response in
      let result = response.result
      print("the result is : \(result.value)")
      if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
          for aDic in arrayOfDic{
          let user_id = (aDic["User_id"] as! NSString).doubleValue
            if(self.arrayofgroupid.contains(user_id as! Double) == true){
                print("Sayed")
             self.arrayofnames.append(aDic["User_name"] as! String)
             self.arrayofemails.append(aDic["E_mail"] as! String)
             self.arrayofid.append((aDic["User_id"] as! NSString).doubleValue)
          }
        }
      }
     }
   }

}
