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
    
    
    convenience init(frame: CGRect, aMessage : FTChatMessageModel, for indexPath: IndexPath) {
        self.init(frame:frame)
        self.backgroundColor = UIColor.clear
        message = aMessage
        let messageBubblePath = self.getBubbleShapePathWithSize(frame.size, isUserSelf: aMessage.isUserSelf, for: indexPath)
        
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = messageBubblePath.cgPath
        maskLayer.frame = self.bounds
        maskLayer.contentsScale = UIScreen.main.scale;
        
        let layer = CAShapeLayer()
        layer.mask = maskLayer
        layer.frame = self.bounds
        self.layer.addSublayer(layer)
        
        if let image = UIImage(named : "dog.jpg") {
            layer.contents = image.cgImage
        }

        
        let mediaImageRect = self.getMediaImageViewFrame(aMessage.isUserSelf)
        
        mediaPlayImageView = UIImageView(frame : mediaImageRect)
        mediaPlayImageView.backgroundColor = UIColor.clear
        mediaPlayImageView.image = UIImage(named: "Media_Play")
        self.addSubview(mediaPlayImageView)
    }
    
    fileprivate func getMediaImageViewFrame(_ isUserSelf : Bool) -> CGRect {
        let xx = isUserSelf ?
            (self.frame.size.width - FTDefaultMessageBubbleAngleWidth - FTDefaultMessageBubbleMediaIconHeight)/2 :
            FTDefaultMessageBubbleAngleWidth + (self.frame.size.width - FTDefaultMessageBubbleAngleWidth - FTDefaultMessageBubbleMediaIconHeight)/2
        let yy = (self.frame.size.height - FTDefaultMessageBubbleMediaIconHeight)/2
        return CGRect(x: xx, y: yy, width: FTDefaultMessageBubbleMediaIconHeight, height: FTDefaultMessageBubbleMediaIconHeight)
    }
}
