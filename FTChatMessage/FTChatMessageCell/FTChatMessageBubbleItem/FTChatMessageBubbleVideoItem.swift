//
//  FTChatMessageBubbleVideoItem.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/5/7.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

class FTChatMessageBubbleVideoItem: FTChatMessageBubbleItem {
    
    var mediaPlayImageView : UIImageView!
    
    
    convenience init(frame: CGRect, aMessage : FTChatMessageModel ) {
        self.init(frame:frame)
        self.backgroundColor = UIColor.clearColor()
        message = aMessage
        messageBubblePath = self.getBubbleShapePathWithSize(frame.size, isUserSelf: aMessage.isUserSelf)
        
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = messageBubblePath.CGPath
        maskLayer.frame = self.bounds
        maskLayer.contentsScale = UIScreen.mainScreen().scale;
        
        let layer = CAShapeLayer()
        layer.mask = maskLayer
        layer.frame = self.bounds
        self.layer.addSublayer(layer)
        
        if let image = UIImage(named : "dog.jpg") {
            layer.contents = image.CGImage
        }

        
        let mediaImageRect = self.getMediaImageViewFrame(aMessage.isUserSelf)
        
        mediaPlayImageView = UIImageView(frame : mediaImageRect)
        mediaPlayImageView.backgroundColor = UIColor.clearColor()
        mediaPlayImageView.image = UIImage(named: "Media_Play")
        self.addSubview(mediaPlayImageView)
    }
    
    private func getMediaImageViewFrame(isUserSelf : Bool) -> CGRect {
        let xx = isUserSelf ?
            (self.frame.size.width - FTDefaultAngleWidth - FTDefaultMessageBubbleMediaIconHeight)/2 :
            FTDefaultAngleWidth + (self.frame.size.width - FTDefaultAngleWidth - FTDefaultMessageBubbleMediaIconHeight)/2
        
        let yy = (self.frame.size.height - FTDefaultMessageBubbleMediaIconHeight)/2
        return CGRectMake(xx, yy, FTDefaultMessageBubbleMediaIconHeight, FTDefaultMessageBubbleMediaIconHeight)
    }
}
