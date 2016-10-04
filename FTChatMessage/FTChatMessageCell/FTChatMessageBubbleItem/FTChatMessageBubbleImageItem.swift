//
//  FTChatMessageBubbleImageItem.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/5/7.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

class FTChatMessageBubbleImageItem: FTChatMessageBubbleItem {
    
    convenience init(frame: CGRect, aMessage : FTChatMessageModel) {
        self.init(frame:frame)
        self.backgroundColor = UIColor.clear
        message = aMessage
        let messageBubblePath = self.getBubbleShapePathWithSize(frame.size, isUserSelf: aMessage.isUserSelf)
        
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = messageBubblePath.cgPath
        maskLayer.frame = self.bounds
        maskLayer.contentsScale = UIScreen.main.scale;
        
        let layer = CAShapeLayer()
        layer.mask = maskLayer
        layer.frame = self.bounds
        self.layer.addSublayer(layer)
        
        if let image = UIImage(named : "lost.jpg") {
            layer.contents = image.cgImage
        }
        //
        //        SDWebImageManager.sharedManager().downloadWithURL(NSURL(string : message.messageText),
        //                                                          options: .ProgressiveDownload,
        //                                                          progress: { (a, b) in
        //                                                            },
        //                                                          completed: { (downloadImage, error, cachType, finished) in
        //
        //                                                            if finished == true && downloadImage != nil{
        //                                                                layer.contents = downloadImage.CGImage
        //                                                            }
        //
        //                                                            })
    }
    
    
    
}
