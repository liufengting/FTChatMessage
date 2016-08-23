//
//  ChatTableViewCell.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/3/27.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {


    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.cornerRadius = iconImageView.bounds.size.height/2
    }

    var message : FTChatMessageModel! {
        didSet {
            nameLabel.text = message.messageSender.senderName
            contentLabel.text = message.messageText
        }
    }
    
    
}
