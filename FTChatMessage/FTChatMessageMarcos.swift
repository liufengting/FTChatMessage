//
//  FTChatMessageMarcos.swift
//  FTChatMessage
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
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
    case text
    case image
    case audio
    case video
    case location
    case Share
    case More
}

public var FTScreenWidth : CGFloat { return UIScreen.main.bounds.size.width }
public var FTScreenHeight : CGFloat { return UIScreen.main.bounds.size.height }


let FTDefaultMargin : CGFloat = 5.0
//MARK: - TimeLabel -
let FTDefaultTimeLabelHeight : CGFloat = 10.0
let FTDefaultTimeLabelFont : UIFont = UIFont.systemFont(ofSize: 10)
//MARK: - NameLabel -
let FTDefaultNameLabelHeight : CGFloat = 20.0
let FTDefaultNameLabelFont : UIFont = UIFont.systemFont(ofSize: 12)
//MARK: - Input -
let FTDefaultInputViewHeight : CGFloat = 44.0
let FTDefaultInputViewMargin : CGFloat = 8.0
let FTDefaultInputViewTextCornerRadius : CGFloat = 8.0
let FTDefaultInputViewMaxHeight : CGFloat = 150.0
let FTDefaultInputTextViewEdgeInset: UIEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
let FTDefaultInputViewBackgroundColor : UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
//MARK: - Accessory -
let FTDefaultAccessoryViewHeight : CGFloat = 216.0
let FTDefaultAccessoryViewItemWidth : CGFloat = 60.0
let FTDefaultAccessoryViewItemHeight : CGFloat = 80.0
let FTDefaultAccessoryViewTopMargin : CGFloat = 15.0
let FTDefaultAccessoryViewLeftMargin : CGFloat = 25.0
let FTDefaultAccessoryViewBottomMargin : CGFloat = 30.0
//MARK: - MessageBubble -
let FTDefaultMessageBubbleTextInViewMaxWidth : CGFloat = FTScreenWidth*0.65
let FTDefaultMessageBubbleAngleWidth : CGFloat = 6.0
let FTDefaultMessageBubbleImageWidth : CGFloat = FTScreenWidth*0.48
let FTDefaultMessageBubbleImageHeight : CGFloat = FTDefaultMessageBubbleImageWidth*0.62
let FTDefaultMessageBubbleMapViewWidth : CGFloat = FTDefaultMessageBubbleImageWidth
let FTDefaultMessageBubbleMapViewHeight : CGFloat = FTDefaultMessageBubbleImageHeight
let FTDefaultMessageBubbleAudioHeight : CGFloat = 36.0
let FTDefaultMessageBubbleAudioIconHeight : CGFloat = 24.0
let FTDefaultMessageBubbleMediaIconHeight : CGFloat = 30.0
//MARK: - MessageCell -
let FTDefaultMessageCellTimeLabelHeight : CGFloat = 20.0
let FTDefaultMessageCellSendStatusViewSize : CGFloat = 20.0
let FTDefaultMessageCellIconToMessageMargin : CGFloat = 2.0
let FTDefaultMessageCellReuseIndentifier = "FTDefaultMessageCellReuseIndentifier"


let FTDefaultTextTopMargin : CGFloat = 10.0
let FTDefaultTextLeftMargin : CGFloat = 15.0
let FTDefaultLineSpacing : CGFloat = 2.0
let FTDefaultSectionHeight : CGFloat = 40.0
let FTDefaultIconSize : CGFloat = 30.0
let FTDefaultMessageRoundCorner : CGFloat = 16.0
let FTDefaultFontSize : UIFont = UIFont.systemFont(ofSize: 14)
let FTDefaultOutgoingColor : UIColor = UIColor(red: 1/255, green: 123/255, blue: 225/255, alpha: 1)
let FTDefaultIncomingColor : UIColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
//MARK: - Animation -
let FTDefaultMessageDefaultAnimationDuration : Double = 0.3



class FTChatMessagePublicMethods {
    
    class func getFTDefaultMessageParagraphStyle() -> NSMutableParagraphStyle{
        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = FTDefaultLineSpacing
        return paragraphStyle;
    }

}
