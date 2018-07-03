//
//  MessageCellTableViewCell.swift
//  Graduation Project
//
//  Created by Yasmine Ghazy on 1/30/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

  
    
    @IBOutlet weak var senderMsgView: UIView!
    @IBOutlet weak var senderMsgLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(){
        senderMsgView.layer.cornerRadius = self.frame.height / 4
        senderMsgView.clipsToBounds = true
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }


}
