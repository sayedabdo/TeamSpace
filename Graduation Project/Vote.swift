//
//  Vote.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 7/2/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import Foundation
class Vote{
    
    var Voting_id = 0.0
    var Voting_name = ""
    var Voting_question = ""
    var Groups_Group_id = 0.0
    var Groups_Community_Community_id = 0.0
    var Groups_Community_Users_User_id = 0.0
    
    static func createVote(Voting_id : Double,
                            Voting_name : String,
                            Voting_question : String,
                            Groups_Group_id : Double,
                            Groups_Community_Community_id : Double,
                            Groups_Community_Users_User_id : Double)-> Vote{
        
        let vote : Vote = Vote()
        vote.Voting_id = Voting_id
        vote.Voting_name = Voting_name
        vote.Voting_question = Voting_question
        vote.Groups_Group_id = Groups_Group_id
        vote.Groups_Community_Community_id = Groups_Community_Community_id
        vote.Groups_Community_Users_User_id = Groups_Community_Users_User_id
        
        return vote
    }
}
