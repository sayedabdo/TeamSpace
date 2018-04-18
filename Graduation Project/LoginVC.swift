//
//  LoginVC.swift
//  Graduation Project
//
//  Created by Sayed Abdo on 3/5/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit
import Alamofire


class LoginVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordtextfield: UITextField!
    var checkifexist = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //this function to login
    //the action on login button
    //check if the user is exist or not
    @IBAction func pressOnLoginBtn(_ sender: Any) {
        //check if the email textfield is empty or not
        if(emailTextField.text?.isEmpty)!{
            displayAlertMessage(title: "Error", messageToDisplay: "email is empty 😡😡😡", titleofaction: "Try Again")
            return
        }
        
        //check if the email textfield is valid or not
        let EmailAddress = emailTextField.text
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: EmailAddress!)
        if isEmailAddressValid
        {} else {
            displayAlertMessage(title: "Error", messageToDisplay: "E-mail is InValid 😡😡😡", titleofaction: "Try Again")
            return
        }
        //check if the password textfield is empty or not
        if(passwordtextfield.text?.isEmpty)!{
            displayAlertMessage(title: "Error", messageToDisplay: "password is empty 😡😡😡", titleofaction: "Try Again")
            return
        }
        //check if the password textfield is longer than 8 characters
        if((passwordtextfield.text?.characters.count)! < 1 ){
            displayAlertMessage(title: "Error", messageToDisplay: "password must longer than 8 characters 😡😡😡", titleofaction: "Try Again")
            return
        }
        let url = "http://team-space.000webhostapp.com/index.php/api/users"
        Alamofire.request(url).responseJSON { response in
            let result = response.result
            print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                print("000000000")
                print(arrayOfDic[0]["User_name"]!)
                
                
                for aDic in arrayOfDic{
                    print("//////")
                    print(aDic["E_mail"]!)
                    print(aDic["Password"]!)
                    let e_mail = aDic["E_mail"]!
                    let password = aDic["Password"]!
                    if(self.emailTextField.text!    == e_mail   as! String){
                    if(self.passwordtextfield.text! == password as! String){
                     //self.displayAlertMessage(title: "Done", messageToDisplay: "😍😍😍😍", titleofaction: "OK")
                        self.checkifexist = 1
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "profile") as! profileVC
                        self.present(nextViewController, animated:true, completion:nil)
                        
                     return
                     }
                    }
            }
                if(self.checkifexist == 0){
                    self.displayAlertMessage(title: "Error", messageToDisplay: "Email or Password Not Right 😡😡😡", titleofaction: "Try Again")
                        return
                }
         }
        }
    }
    //function used to check is email valid or not
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
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
}
