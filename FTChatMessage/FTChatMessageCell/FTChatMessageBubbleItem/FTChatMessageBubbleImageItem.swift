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
//        maskLayer.borderColor = UIColor.black.cgColor
//        maskLayer.borderWidth = 0.8
//        maskLayer.contentsScale = UIScreen.main.scale;
        
        let layer = CALayer()
        layer.mask = maskLayer
        layer.frame = self.bounds
        layer.contentsScale = UIScreen.main.scale
        layer.contentsGravity = kCAGravityResizeAspectFill

        self.layer.addSublayer(layer)
        
//        self.layer.contentsScale = UIScreen.main.scale
        
        if aMessage.isKind(of: FTChatMessageImageModel.classForCoder()) {
            if let image : UIImage = (aMessage as! FTChatMessageImageModel).image {
                layer.contents = image.withRenderingMode(.alwaysOriginal).cgImage
            }
        }else{
            if let image = UIImage(named : "dog.jpg") {
                layer.contents = image.cgImage
            }
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
