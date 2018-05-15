//
//  SignupVC.swift
//  Graduation Project
//
//  Created by Sayed Abdo on 3/22/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit
import Alamofire

class SignupVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    var emailexist = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signupbuttonpressed(_ sender: Any) {
        emailexist = 0
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
        //check if the Username textfield is empty or not
        if(usernameTextField.text?.isEmpty)!{
            displayAlertMessage(title: "Error", messageToDisplay: "Username is empty 😡😡😡", titleofaction: "Try Again")
            return
        }
        //check if the password textfield is empty or not
        if(passwordTextField.text?.isEmpty)!{
            displayAlertMessage(title: "Error", messageToDisplay: "password is empty 😡😡😡", titleofaction: "Try Again")
        }
        //check if the password textfield is longer than 8 characters
        if((passwordTextField.text?.characters.count)! < 8 ){
            displayAlertMessage(title: "Error", messageToDisplay: "password must longer than 8 characters 😡😡😡", titleofaction: "Try Again")
            return
        }
        //check if the confirm password textfield is empty or not
        if(confirmTextField.text?.isEmpty)!{
            displayAlertMessage(title: "Error", messageToDisplay: "confirm password is empty 😡😡😡", titleofaction: "Try Again")
        }
        //check if password and confirm is equal or not
        if(confirmTextField.text != passwordTextField.text){
            displayAlertMessage(title: "Error", messageToDisplay: "password is not equal Confirm 😡😡😡", titleofaction: "Try Again")
            return
        }
        //check on the gender is male or female
        //        let gender = genderTextField.text?.lowercased()
        //        print("the gender is : \(gender!)")
        //        if(gender! != "male" || gender! != "female"){
        //            displayAlertMessage(title: "Error", messageToDisplay: "please, enter male or female y 😡😡😡", titleofaction: "Try Again")
        //            return
        //        }
        //        if(gender! != "female"){
        //            displayAlertMessage(title: "Error", messageToDisplay: "please, enter male or female 😡😡😡", titleofaction: "Try Again")
        //            return
        //        }
        let url = "http://team-space.000webhostapp.com/index.php/api/users/add"
        print("nnnnnnnnnn")
        let params: [String : String] =
            [   "User_id"      : "\(1)",
                "User_name"    : "\(usernameTextField.text!)",
                "E_mail"       : "\(emailTextField.text!)",
                "Password"     : "\(passwordTextField.text!)",
                "Gender"       : "\(genderTextField.text!)"
        ]
        
        
        let userurl = "http://team-space.000webhostapp.com/index.php/api/users"
        Alamofire.request(userurl).responseJSON { response in
            let result = response.result
            //print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                    let e_mail = aDic["E_mail"]!
                    if(self.emailTextField.text! == e_mail   as! String){
                        self.emailexist = 1
                        print("\(e_mail)")
                        print("\(self.emailexist)")
                       self.displayAlertMessage(title: "Error", messageToDisplay: "This Email is Exist 😡😡😡😡", titleofaction: "Try Again")
                        return
                    }
                }
                if(self.emailexist != 1){
                    Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
                        .responseJSON { response in
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "profile") as! profileVC
                            self.present(nextViewController, animated:true, completion:nil)
                    }
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
