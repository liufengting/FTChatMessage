//
//  ChatTableViewCell.swift
//  FTChatMessage
//
//  Created by liufengting on 16/3/27.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

class ChatRoomTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    var message : FTChatMessageModel! {
        didSet {
            nameLabel.text = message.messageSender.senderName
            contentLabel.text = message.messageText
            iconImageView.kf.setImage(with: URL(string: message.messageSender.senderIconUrl))
        }
    }
    
    
}
