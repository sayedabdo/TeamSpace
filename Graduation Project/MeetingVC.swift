//
//  MeetingVC.swift
//  Graduation Project
//
//  Created by Sayed Abdo on 7/4/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class MeetingVC: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
    @IBOutlet weak var collection: UICollectionView!
    var current_user : Double  = 1
    var current_community_id  : Double = 1
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
    override func viewDidLoad() {
        collection.dataSource = self
        collection.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getmeeting()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("the count is : ",arrayofnames.count)
        return arrayofnames.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TasksVC") as! TasksVC
                self.present(nextViewController, animated:true, completion:nil)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collection.dequeueReusableCell(withReuseIdentifier: "meetingCell", for: indexPath) as? meetingCell
            else { return UICollectionViewCell()
        }
        cell.meetingname.text = arrayofnames[indexPath.row] as! String
        //cell.meetingDescription.text =  arrayofnamesdescription[indexPath.row] as! String
        return cell
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func getmeeting(){
        let meeting_url = "http://team-space.000webhostapp.com/index.php/api/meeting"
        Alamofire.request(meeting_url).responseJSON { response in
            let result = response.result
            print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                    let community_id = (aDic["Groups_Community_Community_id"]as! NSString).doubleValue
                    if(community_id == self.current_community_id){
                            self.arrayofnames.append(aDic["Meeting_title"] as! String)
                           // self.arrayofnamesdescription.append(aDic["Task_description"] as! String)
                            self.arrayofid.append((aDic["Meeting_id"] as! NSString).doubleValue)
                    }
                }
            }
        }
    }
}

