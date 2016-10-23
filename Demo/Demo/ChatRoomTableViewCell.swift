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

    var conversation : NIMRecentSession! {
        didSet {
            
            self.setIconImage(conversion: conversation)
            self.setName(conversion: conversation)
            self.setLastMessage(conversion: conversation)
            
//            nameLabel.text = message.messageSender.senderName
//            contentLabel.text = message.messageText
//            iconImageView.kf.setImage(with: URL(string: message.messageSender.senderIconUrl))
        }
    }


    
    
    func setIconImage(conversion:NIMRecentSession) {
        
        let user : NIMUser = self.userById(conversion: conversion)
        if (conversation.session?.sessionType == NIMSessionType.P2P){
            if let url : String = (user.userInfo?.avatarUrl){
                iconImageView.kf.setImage(with: URL(string: url))
            }
        }else{
            
        }
    }
    func setName(conversion:NIMRecentSession) {
        let user : NIMUser = self.userById(conversion: conversion)
        self.nameLabel.text = user.userInfo?.nickName
    }
    func setLastMessage(conversion:NIMRecentSession) {
        self.contentLabel.text = conversion.lastMessage?.text
    }
    
    
    func userById(conversion:NIMRecentSession) -> NIMUser {
        return NIMSDK.shared().userManager.userInfo((conversion.session?.sessionId)!)!
    }
}

