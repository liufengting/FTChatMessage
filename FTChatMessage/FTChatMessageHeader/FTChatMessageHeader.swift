//
//  FTChatMessageHeader.swift
//  FTChatMessage
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

protocol FTChatMessageHeaderDelegate {
    func ft_chatMessageHeaderDidTappedOnIcon(_ messageSenderModel : FTChatMessageUserModel)
}

class FTChatMessageHeader: UILabel {
    
    var iconButton : UIImageView!
    var messageSenderModel : FTChatMessageUserModel!
    var headerViewDelegate : FTChatMessageHeaderDelegate?


    
    convenience init(frame: CGRect, senderModel: FTChatMessageUserModel ) {
        self.init(frame : frame)
        
        messageSenderModel = senderModel;
        self.setupHeader(URL(string: senderModel.senderIconUrl), isSender: senderModel.isUserSelf)
    }
    
    
    
    fileprivate func setupHeader(_ imageUrl : URL?, isSender: Bool){
        self.backgroundColor = UIColor.clear
        
        let iconRect = isSender ? CGRect(x: self.frame.width-FTDefaultMargin-FTDefaultIconSize, y: FTDefaultMargin, width: FTDefaultIconSize, height: FTDefaultIconSize) : CGRect(x: FTDefaultMargin, y: FTDefaultMargin, width: FTDefaultIconSize, height: FTDefaultIconSize)
        iconButton = UIImageView(frame: iconRect)
        iconButton.backgroundColor = isSender ? FTDefaultOutgoingColor : FTDefaultIncomingColor
        iconButton.layer.cornerRadius = FTDefaultIconSize/2;
        iconButton.clipsToBounds = true
        iconButton.isUserInteractionEnabled = true
//        iconButton.addTarget(self, action: #selector(self.iconTapped), for: UIControlEvents.touchUpInside)
        self.addSubview(iconButton)
        
        if (imageUrl != nil){
            iconButton.kf.setImage(with: imageUrl)
        }
    }

    func iconTapped() {
        if (headerViewDelegate != nil) {
            headerViewDelegate?.ft_chatMessageHeaderDidTappedOnIcon(messageSenderModel)
        }
    }
    
    
    
}
