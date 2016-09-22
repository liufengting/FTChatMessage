//
//  FTChatMessageBubbleItem.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/3/23.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

class FTChatMessageBubbleItem: UIButton {
    
    var message = FTChatMessageModel()
    var messageBubblePath = UIBezierPath()
    var messageLabel : UILabel!

    convenience init(frame: CGRect, aMessage : FTChatMessageModel) {
        self.init(frame: frame)
        NSException(name: NSExceptionName(rawValue: "SubClassing"), reason: "Subclass must impliment this method", userInfo: nil).raise()
    }


    /**
     getBubbleShapePathWithSize
     
     - parameter size:       text size
     - parameter isUserSelf: isUserSelf
     
     - returns: UIBezierPath
     */
    func getBubbleShapePathWithSize(_ size:CGSize , isUserSelf : Bool) -> UIBezierPath {
        var path = UIBezierPath()
        
        let bubbleWidth = size.width - FTDefaultMessageBubbleAngleWidth
        let bubbleHeight = size.height
        let y : CGFloat = 0
        let x : CGFloat = isUserSelf ? 0 : FTDefaultMessageBubbleAngleWidth
        
        path = UIBezierPath(roundedRect: CGRect(x: x, y: y, width: bubbleWidth, height: bubbleHeight), byRoundingCorners: .allCorners, cornerRadii: CGSize(width: FTDefaultMessageRoundCorner, height: FTDefaultMessageRoundCorner));
//        path.move(to: CGPoint(x: x, y: y + FTDefaultMessageRoundCorner))
//        path.addLine(to: CGPoint(x: 0, y: y + FTDefaultMessageRoundCorner + 3))
//        path.addLine(to: CGPoint(x: x, y: y + FTDefaultMessageRoundCorner + 6))
 

        return path;
    }
    
}


extension FTChatMessageBubbleItem {
    
    internal class func getBubbleItemWithFrame(_ bubbleFrame: CGRect,aMessage: FTChatMessageModel) -> FTChatMessageBubbleItem {
        var messageBubbleItem : FTChatMessageBubbleItem! = FTChatMessageBubbleItem()
        switch aMessage.messageType {
        case .text:
            messageBubbleItem = FTChatMessageBubbleTextItem(frame: bubbleFrame, aMessage: aMessage)
        case .image:
            messageBubbleItem = FTChatMessageBubbleImageItem(frame: bubbleFrame, aMessage: aMessage)
        case .audio:
            messageBubbleItem = FTChatMessageBubbleAudioItem(frame: bubbleFrame, aMessage: aMessage)
        case .location:
            messageBubbleItem = FTChatMessageBubbleLocationItem(frame: bubbleFrame, aMessage: aMessage)
        case .video:
            messageBubbleItem = FTChatMessageBubbleVideoItem(frame: bubbleFrame, aMessage: aMessage)
        }
        return messageBubbleItem
    }
    
    
    internal class func getMessageBubbleWidthForMessage(_ aMessage: FTChatMessageModel) -> CGFloat {
        var bubbleWidth : CGFloat = 0
        switch aMessage.messageType {
        case .text:
            let att = NSString(string: aMessage.messageText)
            let rect = att.boundingRect(with: CGSize(width: FTDefaultMessageBubbleTextInViewMaxWidth,height: CGFloat(MAXFLOAT)),
                                                options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                attributes: [NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()],
                                                context: nil)
            bubbleWidth = rect.width + FTDefaultTextMargin*2 + FTDefaultMessageBubbleAngleWidth
        case .image:
            bubbleWidth = FTDefaultMessageBubbleWidth
        case .audio:
            bubbleWidth = FTDefaultMessageBubbleWidth
        case .location:
            bubbleWidth = FTDefaultMessageBubbleMapViewWidth
        case .video:
            bubbleWidth = FTDefaultMessageBubbleWidth
        }
        return bubbleWidth
    }
    
    internal class func getMessageBubbleHeightForMessage(_ aMessage : FTChatMessageModel) -> CGFloat {
        var bubbleHeight : CGFloat = 0
        switch aMessage.messageType {
        case .text:
            let att = NSString(string: aMessage.messageText)
            let textRect = att.boundingRect(with: CGSize(width: FTDefaultMessageBubbleTextInViewMaxWidth,height: CGFloat(MAXFLOAT)),
                                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                    attributes: [NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()],
                                                    context: nil)
            bubbleHeight += textRect.height + FTDefaultTextMargin*2
        case .image:
            bubbleHeight += FTDefaultMessageBubbleHeight
        case .audio:
            bubbleHeight += FTDefaultMessageBubbleAudioHeight
        case .location:
            bubbleHeight += FTDefaultMessageBubbleMapViewHeight
        case .video:
            bubbleHeight += FTDefaultMessageBubbleHeight
        }
        return bubbleHeight
    }
    

}
