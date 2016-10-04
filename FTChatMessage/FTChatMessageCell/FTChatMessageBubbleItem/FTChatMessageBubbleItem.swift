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
    var messageBubbleLayer = CAShapeLayer()
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
        
        let x : CGFloat = isUserSelf ? 0 : FTDefaultMessageBubbleAngleWidth
        let y : CGFloat = 0
        let bubbleWidth : CGFloat = size.width - FTDefaultMessageBubbleAngleWidth
        let bubbleHeight : CGFloat = size.height
        let magicNumber : CGFloat = FTDefaultMessageBubbleAngleWidth/4
        let distance : CGFloat = FTDefaultMessageRoundCorner/sqrt(2);

        path = UIBezierPath(roundedRect: CGRect(x: x, y: y, width: bubbleWidth, height: bubbleHeight),
                            byRoundingCorners: .allCorners,
                            cornerRadii: CGSize(width: FTDefaultMessageRoundCorner, height: FTDefaultMessageRoundCorner));
        
        if isUserSelf {
            
            path.move(to: CGPoint(x: x+bubbleWidth-FTDefaultMessageRoundCorner+distance, y: y+FTDefaultMessageRoundCorner-distance))

            path.addQuadCurve(to: CGPoint(x: x+bubbleWidth+FTDefaultMessageBubbleAngleWidth, y: y),
                              controlPoint: CGPoint(x: x+bubbleWidth ,y: y))
            
            path.addQuadCurve(to: CGPoint(x: x+bubbleWidth, y: y+FTDefaultMessageRoundCorner),
                              controlPoint: CGPoint(x: x+bubbleWidth+magicNumber ,y: y))
            
        }else{
            path.move(to: CGPoint(x: x, y: y + FTDefaultMessageRoundCorner))
            
            path.addQuadCurve(to: CGPoint(x: x - FTDefaultMessageBubbleAngleWidth ,y: y),
                              controlPoint: CGPoint(x: x-magicNumber ,y: y))

            path.addQuadCurve(to: CGPoint(x: x+FTDefaultMessageRoundCorner-distance, y: y+FTDefaultMessageRoundCorner-distance),
                              controlPoint: CGPoint(x: x ,y: y))
        }
        
        
        
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
            bubbleWidth = rect.width + FTDefaultTextLeftMargin*2 + FTDefaultMessageBubbleAngleWidth
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
            bubbleHeight += textRect.height + FTDefaultTextTopMargin*2
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
