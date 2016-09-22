//
//  FTChatMessageBubbleTextItem.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/5/7.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

class FTChatMessageBubbleTextItem: FTChatMessageBubbleItem {
    
    convenience init(frame: CGRect, aMessage : FTChatMessageModel) {
        self.init(frame:frame)
        self.backgroundColor = UIColor.clear
        message = aMessage
        
        messageBubblePath = self.getBubbleShapePathWithSize(frame.size, isUserSelf: aMessage.isUserSelf)
        
        let layer = CAShapeLayer()
        layer.path = messageBubblePath.cgPath
        layer.fillColor = aMessage.messageSender.isUserSelf ? FTDefaultOutgoingColor.cgColor : FTDefaultIncomingColor.cgColor
        self.layer.addSublayer(layer)
        
        
        //text
        messageLabel = UILabel(frame: self.getTextRectWithSize(frame.size, isUserSelf: aMessage.isUserSelf));
        messageLabel.text = message.messageText
        messageLabel.numberOfLines = 0
        messageLabel.textColor = aMessage.messageSender.isUserSelf ? UIColor.white : UIColor.black
        messageLabel.font = FTDefaultFontSize
        self.addSubview(messageLabel)
        let attributeString = NSMutableAttributedString(attributedString: messageLabel.attributedText!)
        attributeString.addAttributes([NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()], range: NSMakeRange(0, (messageLabel.text! as NSString).length))
        messageLabel.attributedText = attributeString
        
    }
    
    fileprivate func getTextRectWithSize(_ size:CGSize , isUserSelf : Bool) -> CGRect {
        let bubbleWidth = size.width - FTDefaultMessageBubbleAngleWidth  - FTDefaultTextMargin*2
        let bubbleHeight = size.height - FTDefaultTextMargin*2
        let y = FTDefaultTextMargin
        let x : CGFloat = isUserSelf ? FTDefaultTextMargin : FTDefaultMessageBubbleAngleWidth + FTDefaultTextMargin
        return CGRect(x: x,y: y,width: bubbleWidth,height: bubbleHeight);
    }
    
    
    
    
}
