//
//  CreateGroupVC.swift
//  Graduation Project
//
//  Created by Sayed Abdo on 6/28/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire


class CreateGroupVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var user_id = 0
    var communityid = 0
    let picker = UIImagePickerController()
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var Groupname: UITextField!
    @IBOutlet weak var Groupdescription: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func GreateGroup(_ sender: Any) {
        let communityurl = "http://team-space.000webhostapp.com/index.php/api/groups/add"
        let params: [String : String] =
            [
                "Group_id"                    : "\(1)",
                "Group_name"                  : "\(Groupname.text!)",
                "Group_description"           : "\(Groupdescription.text!)",
                "Super_group_id"              : "\(0)",
                "Group_picture"               : "",
                "head_id"                     : "\(0)",
                "Community_Community_id"      : "\(1)",
                "Community_Users_User_id"     : "\(1)"
        ]
        Alamofire.request(communityurl, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response.result)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CommunitesVC") as! CommunitesVC
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
    
    
    
    @IBAction func createcommunity(_ sender: Any) {
        if(Groupname.text?.isEmpty)!{
            displayAlertMessage(title: "Error", messageToDisplay: "Community Name is empty 😡😡😡", titleofaction: "Try Again")
            return
        }
        if(Groupdescription.text?.isEmpty)!{
            displayAlertMessage(title: "Error", messageToDisplay: "Community Description is empty 😡😡😡", titleofaction: "Try Again")
            return
        }
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
}
