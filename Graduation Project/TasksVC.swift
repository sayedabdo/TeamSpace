//
//  TasksVC.swift
//  Graduation Project
//
//  Created by Sayed Abdo on 6/29/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class TasksVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
    @IBOutlet weak var display_task_status: UISegmentedControl!
    @IBOutlet weak var collection: UICollectionView!
    var current_user : Double  = 1
    var current_community = 0
    var task_status_index = 0
    var current_task_status = "TO DO"
    var arrayofid : [Double] = []{
        didSet{
            collection.reloadData()
        }
    }
    var arrayofnames : [String] = []{
        didSet{
            collection.reloadData()
        }
    }
    var arrayofnamesdescription : [String] = []{
        didSet{
            collection.reloadData()
        }
    }
    var arrayofdeadline : [String] = []{
        didSet{
            collection.reloadData()
        }
    }
    override func viewDidLoad() {
        collection.dataSource = self
        collection.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        taskfilter(status: "TO DO")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("the count is : ",arrayofnames.count)
        return arrayofnames.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TasksVC") as! TasksVC
//        self.present(nextViewController, animated:true, completion:nil)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collection.dequeueReusableCell(withReuseIdentifier: "TasksCell", for: indexPath) as? TasksCell
        else { return UICollectionViewCell()
        }
        cell.taskname.text = arrayofnames[indexPath.row] as! String
        cell.taskDescription.text =  arrayofnamesdescription[indexPath.row] as! String
        cell.deadline.text =  arrayofdeadline[indexPath.row] as! String
        return cell
        
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func changecommunities(_ sender: Any) {
        arrayofnames.removeAll()
        arrayofnamesdescription.removeAll()
        arrayofid.removeAll()
        arrayofdeadline.removeAll()
        task_status_index = display_task_status.selectedSegmentIndex
        if(task_status_index == 0){
            taskfilter(status: "TO DO")
        }
        if(task_status_index == 1){
            taskfilter(status: "IN-Progress")
        }
        if(task_status_index == 2){
            taskfilter(status: "DONE")
        }
    }
    @IBAction func addbtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "createtaskVC") as! createtaskVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func taskfilter(status: String){
        self.current_task_status = status
        let project_url = "http://team-space.000webhostapp.com/index.php/api/tasks"
        Alamofire.request(project_url).responseJSON { response in
            let result = response.result
            print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                    let user_id = (aDic["Projects_Groups_Community_Users_User_id"]as! NSString).doubleValue
                    let task_status = aDic["Task_status"]as! NSString
                    if(self.current_user == user_id){
                        if(self.current_task_status  == task_status as String ){
                            self.arrayofnames.append(aDic["Task_name"] as! String)
                            self.arrayofnamesdescription.append(aDic["Task_description"] as! String)
                            self.arrayofid.append((aDic["Task_id"] as! NSString).doubleValue)
                            self.arrayofdeadline.append(aDic["Task_deadlinne"] as! String)
                        }
                    }
                }
            }
        }
    }
    
}
    
