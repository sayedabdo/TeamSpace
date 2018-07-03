//
//  profileVC.swift
//  Graduation Project
//
//  Created by Sayed Abdo on 4/17/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit
import Alamofire

class profileVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var id = 0
    var email = ""
    let picker = UIImagePickerController()
    var workasarray : [String] = []
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var FirstnameLBL: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imagePicked.layer.borderWidth = 3.0
        imagePicked.layer.masksToBounds = false
        imagePicked.layer.borderColor = UIColor.white.cgColor
        imagePicked.layer.cornerRadius = imagePicked.frame.size.width / 2
        imagePicked.clipsToBounds = true
        
        
        
        
        let url = "http://team-space.000webhostapp.com/index.php/api/users"
        Alamofire.request(url).responseJSON { response in
            let result = response.result
            print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                    let e_mail = aDic["E_mail"]!
                    if(self.email == e_mail   as! String){
                        self.FirstnameLBL.text = aDic["User_name"]! as? String
                        self.nameTextField.text = aDic["User_name"]! as? String
                        self.genderTextField.text = aDic["Gender"]! as? String
                        self.birthdateTextField.text = aDic["Birthday"]! as? String
                        self.addressTextField.text = aDic["Address"]! as? String
                        self.phoneTextField.text = aDic["phone"]! as? String
                        let work = aDic["Work"]! as? String
                        self.workasarray = (work?.components(separatedBy: "@"))!
                        print(self.workasarray)
                        
                        
                        
                        
                        
                        let alert = UIAlertController(title: "question", message: "want yo make update? 😊😊😊", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                            
                        }))
                        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                            
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CommunitesVC") as! CommunitesVC
                            self.present(nextViewController, animated:true, completion:nil)
                            
                        }))
                        
                        self.present(alert, animated: true)

                        
                        
                        
                        
                        return
                    }
                }
            }
        }
        
        
        // Do any additional setup after loading the view.
        print("ssss : \(email)")
        
    }
    

    @IBAction func Savebtn(_ sender: Any) {}
    
    
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
    
    
}
