//
//  FTChatMessageMarcos.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

/**
 FTChatMessageType
 
 - Text:     Text message
 - Image:    Image message
 - Audio:    Audio message
 - Video:    Video message
 - Location: Location message
 */
enum FTChatMessageType {
    case Text
    case Image
    case Audio
    case Video
    case Location
//    case Share
//    case More
}

let FTScreenWidth = UIScreen.mainScreen().bounds.size.width
let FTScreenHeight = UIScreen.mainScreen().bounds.size.height

let FTChatMessageCellReuseIndentifier = "FTChatMessageCellReuseIndentifier"

let FTDefaultMargin : CGFloat = 5.0
let FTDefaultTextInViewMaxWidth : CGFloat = FTScreenWidth*0.65
let FTDefaultIconToMessageMargin : CGFloat = 2.0
let FTDefaultTimeLabelHeight : CGFloat = 10.0
let FTDefaultNameLabelHeight : CGFloat = 20.0
let FTDefaultTimeLabelFont : UIFont = UIFont.systemFontOfSize(10)
let FTDefaultNameLabelFont : UIFont = UIFont.systemFontOfSize(12)
let FTDefaultAngleWidth : CGFloat = 8.0
let FTDefaultTextMargin : CGFloat = 10.0
let FTDefaultLineSpacing : CGFloat = 2.0
let FTDefaultSectionHeight : CGFloat = 40.0
let FTDefaultIconSize : CGFloat = 30.0
let FTDefaultMessageRoundCorner : CGFloat = 12.0
let FTDefaultFontSize : UIFont = UIFont.systemFontOfSize(16)
let FTDefaultOutgoingColor : UIColor = UIColor(red: 1/255, green: 123/255, blue: 225/255, alpha: 1)
let FTDefaultIncomingColor : UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)

let FTDefaultInputViewHeight : CGFloat = 44.0
let FTDefaultInputViewMargin : CGFloat = 8.0
let FTDefaultInputViewTextCornerRadius : CGFloat = 8.0
let FTDefaultInputViewMaxHeight : CGFloat = 150.0
let FTDefaultInputTextViewEdgeInset: UIEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
let FTDefaultInputViewBackgroundColor : UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)

let FTDefaultAccessoryViewHeight : CGFloat = 216.0
let FTDefaultAccessoryViewTopMargin : CGFloat = 25.0
let FTDefaultAccessoryViewBottomMargin : CGFloat = 25.0

let FTDefaultMessageBubbleWidth : CGFloat = FTScreenWidth*0.52
let FTDefaultMessageBubbleHeight : CGFloat = FTScreenWidth*0.32
let FTDefaultMessageBubbleMapViewWidth : CGFloat = FTScreenWidth*0.62
let FTDefaultMessageBubbleMapViewHeight : CGFloat = FTScreenWidth*0.40
let FTDefaultMessageBubbleAudioHeight : CGFloat = 36.0
let FTDefaultMessageBubbleAudioIconHeight : CGFloat = 24.0
let FTDefaultMessageBubbleMediaIconHeight : CGFloat = 30.0
let FTDefaultMessageSendStatusViewSize : CGFloat = 20.0


let FTDefaultMessageDefaultAnimationDuration : Double = 0.3



class FTChatMessagePublicMethods {
    
    class func getFTDefaultMessageParagraphStyle() -> NSMutableParagraphStyle{
        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = FTDefaultLineSpacing
        return paragraphStyle;
    }
    
//    class func getHeightWithWidth(width:CGFloat,text:NSString,font:UIFont)->CGFloat{
//        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = FTDefaultLineSpacing
//        let rect = text.boundingRectWithSize(CGSizeMake(width,CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font,NSParagraphStyleAttributeName: paragraphStyle], context: nil)
//        return rect.size.height
//    }
//    class func getWidthWithHeight(height:CGFloat,text:NSString,font:UIFont)->CGFloat{
//        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = FTDefaultLineSpacing
//        let rect = text.boundingRectWithSize(CGSizeMake(CGFloat(MAXFLOAT),height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font,NSParagraphStyleAttributeName: paragraphStyle], context: nil)
//        return rect.size.width
//    }
    
//    func getScreenWidth() -> CGFloat {
//        return UIScreen.mainScreen().bounds.size.width
//    }
}







