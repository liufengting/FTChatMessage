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
        NSException(name: "SubClassing", reason: "Subclass must impliment this method", userInfo: nil).raise()
    }


    /**
     getBubbleShapePathWithSize
     
     - parameter size:       text size
     - parameter isUserSelf: isUserSelf
     
     - returns: UIBezierPath
     */
    func getBubbleShapePathWithSize(size:CGSize , isUserSelf : Bool) -> UIBezierPath {
        var path = UIBezierPath()
        
        let bubbleWidth = size.width - FTDefaultMessageBubbleAngleWidth
        let bubbleHeight = size.height
        let y : CGFloat = 0
        let x : CGFloat = isUserSelf ? 0 : FTDefaultMessageBubbleAngleWidth
        
        path = UIBezierPath(roundedRect: CGRectMake(x, y, bubbleWidth, bubbleHeight), byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSizeMake(FTDefaultMessageRoundCorner, FTDefaultMessageRoundCorner));

        return path;
    }
    
}


extension FTChatMessageBubbleItem {
    
    internal class func getBubbleItemWithFrame(bubbleFrame: CGRect,aMessage: FTChatMessageModel) -> FTChatMessageBubbleItem {
        var messageBubbleItem : FTChatMessageBubbleItem! = FTChatMessageBubbleItem()
        switch aMessage.messageType {
        case .Text:
            messageBubbleItem = FTChatMessageBubbleTextItem(frame: bubbleFrame, aMessage: aMessage)
        case .Image:
            messageBubbleItem = FTChatMessageBubbleImageItem(frame: bubbleFrame, aMessage: aMessage)
        case .Audio:
            messageBubbleItem = FTChatMessageBubbleAudioItem(frame: bubbleFrame, aMessage: aMessage)
        case .Location:
            messageBubbleItem = FTChatMessageBubbleLocationItem(frame: bubbleFrame, aMessage: aMessage)
        case .Video:
            messageBubbleItem = FTChatMessageBubbleVideoItem(frame: bubbleFrame, aMessage: aMessage)
        }
        return messageBubbleItem
    }
    
    
    internal class func getMessageBubbleWidthForMessage(aMessage: FTChatMessageModel) -> CGFloat {
        var bubbleWidth : CGFloat = 0
        switch aMessage.messageType {
        case .Text:
            let att = NSString(string: aMessage.messageText)
            let rect = att.boundingRectWithSize(CGSizeMake(FTDefaultMessageBubbleTextInViewMaxWidth,CGFloat(MAXFLOAT)),
                                                options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                                attributes: [NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()],
                                                context: nil)
            bubbleWidth = rect.width + FTDefaultTextMargin*2 + FTDefaultMessageBubbleAngleWidth
        case .Image:
            bubbleWidth = FTDefaultMessageBubbleWidth
        case .Audio:
            bubbleWidth = FTDefaultMessageBubbleWidth
        case .Location:
            bubbleWidth = FTDefaultMessageBubbleMapViewWidth
        case .Video:
            bubbleWidth = FTDefaultMessageBubbleWidth
        }
        return bubbleWidth
    }
    
    internal class func getMessageBubbleHeightForMessage(aMessage : FTChatMessageModel) -> CGFloat {
        var bubbleHeight : CGFloat = 0
        switch aMessage.messageType {
        case .Text:
            let att = NSString(string: aMessage.messageText)
            let textRect = att.boundingRectWithSize(CGSizeMake(FTDefaultMessageBubbleTextInViewMaxWidth,CGFloat(MAXFLOAT)),
                                                    options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                                    attributes: [NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()],
                                                    context: nil)
            bubbleHeight += textRect.height + FTDefaultTextMargin*2
        case .Image:
            bubbleHeight += FTDefaultMessageBubbleHeight
        case .Audio:
            bubbleHeight += FTDefaultMessageBubbleAudioHeight
        case .Location:
            bubbleHeight += FTDefaultMessageBubbleMapViewHeight
        case .Video:
            bubbleHeight += FTDefaultMessageBubbleHeight
        }
        return bubbleHeight
    }
    

}
//func getBubbleShapePathWithSize(size:CGSize , isUserSelf : Bool) -> UIBezierPath {
//    var path = UIBezierPath()
//    
//    let bubbleWidth = size.width - FTDefaultMessageBubbleAngleWidth
//    let bubbleHeight = size.height
//    let y : CGFloat = 0
//    let x : CGFloat = isUserSelf ? 0 : FTDefaultMessageBubbleAngleWidth
//    
//    if (isUserSelf){
//        
//        
//        path = UIBezierPath(roundedRect: CGRectMake(x, y, bubbleWidth, bubbleHeight), byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSizeMake(FTDefaultMessageRoundCorner, FTDefaultMessageRoundCorner));
//        
//        
//        //            path.moveToPoint(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y))
//        //            path.addLineToPoint(CGPointMake(x+FTDefaultMessageRoundCorner, y))
//        //            path.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(-M_PI), clockwise: false);
//        //            path.addLineToPoint(CGPointMake(x, y+bubbleHeight-FTDefaultMessageRoundCorner))
//        //            path.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI_2), clockwise: false);
//        //            path.addLineToPoint(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+bubbleHeight))
//        //            path.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI_2), endAngle: 0, clockwise: false);
//        //            path.addLineToPoint(CGPointMake(x+bubbleWidth, y+FTDefaultMessageRoundCorner*2+8))
//        //
//        //            path.addQuadCurveToPoint(CGPointMake(x+bubbleWidth+FTDefaultMessageBubbleAngleWidth, y+FTDefaultMessageRoundCorner-2), controlPoint: CGPointMake(x+bubbleWidth+2.5, y+FTDefaultMessageRoundCorner+2))
//        //            path.addQuadCurveToPoint(CGPointMake(x+bubbleWidth, y+FTDefaultMessageRoundCorner), controlPoint: CGPointMake(x+bubbleWidth+4, y+FTDefaultMessageRoundCorner-1))
//        //
//        //            path.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(0), endAngle: CGFloat(-M_PI_2), clockwise: false);
//        //            path.closePath()
//    }else{
//        let x = FTDefaultMessageBubbleAngleWidth
//        
//        path = UIBezierPath(roundedRect: CGRectMake(x, y, bubbleWidth, bubbleHeight), byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSizeMake(FTDefaultMessageRoundCorner, FTDefaultMessageRoundCorner));
//        
//        //            path.moveToPoint(CGPointMake(x+FTDefaultMessageRoundCorner, y))
//        //            path.addLineToPoint(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y))
//        //            path.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(-M_PI_2), endAngle: 0, clockwise: true);
//        //            path.addLineToPoint(CGPointMake(x+bubbleWidth, y+bubbleHeight-FTDefaultMessageRoundCorner))
//        //            path.addArcWithCenter(CGPointMake(x+bubbleWidth-FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: 0, endAngle: CGFloat(M_PI_2), clockwise: true);
//        //            path.addLineToPoint(CGPointMake(x+FTDefaultMessageRoundCorner, y+bubbleHeight))
//        //            path.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+bubbleHeight-FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI_2), endAngle: CGFloat(M_PI), clockwise: true);
//        //            path.addLineToPoint(CGPointMake(x, y+FTDefaultMessageRoundCorner*2+8))
//        //
//        //            path.addQuadCurveToPoint(CGPointMake(x-FTDefaultMessageBubbleAngleWidth, y+FTDefaultMessageRoundCorner-2), controlPoint: CGPointMake(x-2.5, y+FTDefaultMessageRoundCorner+2))
//        //            path.addQuadCurveToPoint(CGPointMake(x, y+FTDefaultMessageRoundCorner), controlPoint: CGPointMake(x-4, y+FTDefaultMessageRoundCorner-1))
//        //
//        //            path.addArcWithCenter(CGPointMake(x+FTDefaultMessageRoundCorner, y+FTDefaultMessageRoundCorner), radius: FTDefaultMessageRoundCorner, startAngle: CGFloat(M_PI), endAngle: CGFloat(-M_PI_2), clockwise: true);
//        //            path.closePath()
//    }
//    return path;
//}
//
//}
//
