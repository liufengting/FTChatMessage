//
//  FTChatMessageBubbleAudioItem.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/5/7.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

class FTChatMessageBubbleAudioItem: FTChatMessageBubbleItem {
    
    var playImageView : UIImageView!
    var mediaInfoLabel : UILabel!
    
    convenience init(frame: CGRect, aMessage : FTChatMessageModel ) {
        self.init(frame:frame)
        self.backgroundColor = UIColor.clearColor()
        message = aMessage
        messageBubblePath = self.getAudioBubblePath(frame.size, isUserSelf: aMessage.isUserSelf)
        
        let layer = CAShapeLayer()
        layer.path = messageBubblePath.CGPath
        layer.fillColor = aMessage.messageSender.isUserSelf ? FTDefaultOutgoingColor.CGColor : FTDefaultIncomingColor.CGColor
        self.layer.addSublayer(layer)
        
        let mediaImageRect = self.getPlayImageViewFrame(aMessage.isUserSelf)
        playImageView = UIImageView(frame : mediaImageRect)
        playImageView.backgroundColor = UIColor.clearColor()
        playImageView.image = UIImage(named: "Media_Play")
        self.addSubview(playImageView)
        
        let mediaInfoLabelRect = self.getMediaInfoLabelFrame(aMessage.isUserSelf)
        mediaInfoLabel = UILabel(frame : mediaInfoLabelRect)
        mediaInfoLabel.backgroundColor = UIColor.clearColor()
        mediaInfoLabel.font = FTDefaultFontSize
        mediaInfoLabel.textColor = UIColor.whiteColor()
        mediaInfoLabel.textAlignment = aMessage.isUserSelf ? NSTextAlignment.Left : NSTextAlignment.Right
        mediaInfoLabel.text = "1′ 22″"
        self.addSubview(mediaInfoLabel)
        
    }
    
    private func getAudioBubblePath(size:CGSize , isUserSelf : Bool) -> UIBezierPath {
        let bubbleRect = CGRectMake(isUserSelf ? 0 : FTDefaultAngleWidth, 0, size.width - FTDefaultAngleWidth , size.height)
        let path = UIBezierPath.init(roundedRect: bubbleRect, cornerRadius:  size.height/2)
        return path;
    }
    
    private func getPlayImageViewFrame(isUserSelf : Bool) -> CGRect {
        let margin = (FTDefaultMessageBubbleAudioHeight - FTDefaultMessageBubbleAudioIconHeight)/2
        return isUserSelf ?
            CGRectMake(margin, margin, FTDefaultMessageBubbleAudioIconHeight, FTDefaultMessageBubbleAudioIconHeight) :
            CGRectMake(self.frame.size.width - FTDefaultMessageBubbleAudioHeight + margin , margin, FTDefaultMessageBubbleAudioIconHeight, FTDefaultMessageBubbleAudioIconHeight)
        
    }
    private func getMediaInfoLabelFrame(isUserSelf : Bool) -> CGRect {
        let margin = (FTDefaultMessageBubbleAudioHeight - FTDefaultMessageBubbleAudioIconHeight)/2
        return isUserSelf ?
            CGRectMake(FTDefaultMessageBubbleAudioHeight, margin, self.frame.size.width - FTDefaultMessageBubbleAudioHeight - FTDefaultAngleWidth - margin, FTDefaultMessageBubbleAudioIconHeight) :
            CGRectMake( FTDefaultAngleWidth + margin, margin, self.frame.size.width - FTDefaultMessageBubbleAudioHeight - FTDefaultAngleWidth - margin, FTDefaultMessageBubbleAudioIconHeight)
    }
    
}
