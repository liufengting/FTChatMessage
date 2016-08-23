//
//  FTChatMessageHeader.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit
import AlamofireImage

protocol FTChatMessageHeaderDelegate {

    func fTChatMessageHeaderDidTappedOnIcon(messageSenderModel : FTChatMessageUserModel)
    
}

class FTChatMessageHeader: UIView {
    
    var iconButton : UIButton!
    var messageSenderModel : FTChatMessageUserModel!
    var headerViewDelegate : FTChatMessageHeaderDelegate?


    
    convenience init(frame: CGRect, senderModel: FTChatMessageUserModel ) {
        self.init(frame : frame)
        
        messageSenderModel = senderModel;
        
        self.setupHeader(NSURL(string: senderModel.senderIconUrl), isSender: senderModel.isUserSelf)

    }
    
    private func setupHeader(imageUrl : NSURL?, isSender: Bool){
        self.backgroundColor = UIColor.clearColor()
        
        let iconRect = isSender ? CGRectMake(self.frame.width-FTDefaultMargin-FTDefaultIconSize, FTDefaultMargin, FTDefaultIconSize, FTDefaultIconSize) : CGRectMake(FTDefaultMargin, FTDefaultMargin, FTDefaultIconSize, FTDefaultIconSize)
        iconButton = UIButton(frame: iconRect)
        iconButton.backgroundColor = isSender ? FTDefaultOutgoingColor : FTDefaultIncomingColor
        iconButton.layer.cornerRadius = FTDefaultIconSize/2;
        iconButton.clipsToBounds = true
        iconButton.addTarget(self, action: #selector(self.iconTapped), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(iconButton)
        
        if (imageUrl != nil){
//            iconButton.sd_setImageWithURL(imageUrl!, forState: UIControlState.Normal)
//            iconButton.af_setImageForState(UIControlState.Normal, URL: imageUrl!)
            iconButton.af_setImageForState(UIControlState.Normal, URL: imageUrl!)
        }
    }

    func iconTapped() {
        if (headerViewDelegate != nil) {
            headerViewDelegate?.fTChatMessageHeaderDidTappedOnIcon(messageSenderModel)
        }
    }
    
    
    
}
