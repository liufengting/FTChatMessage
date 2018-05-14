//
//  FTChatMessageBubbleItem.swift
//  FTChatMessage
//
//  Created by liufengting on 16/3/23.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit
import FTImageSize

class FTChatMessageBubbleItem: UIButton {
    
    var message = FTChatMessageModel()
    var messageBubbleLayer = CAShapeLayer()
    var messageLabel : UILabel!

    convenience init(frame: CGRect, aMessage : FTChatMessageModel, for indexPath: IndexPath) {
        self.init(frame: frame)
        NSException(name: NSExceptionName(rawValue: "SubClassing"), reason: "Subclass must impliment this method", userInfo: nil).raise()
    }


    /**
     getBubbleShapePathWithSize
     
     - parameter size:       text size
     - parameter isUserSelf: isUserSelf
     
     - returns: UIBezierPath
     */
    func getBubbleShapePathWithSize(_ size:CGSize , isUserSelf : Bool, for indexPath: IndexPath) -> UIBezierPath {
        var path = UIBezierPath()
        
        let x : CGFloat = isUserSelf ? 0 : FTDefaultMessageBubbleAngleWidth
        let y : CGFloat = 0
        let bubbleWidth : CGFloat = size.width - FTDefaultMessageBubbleAngleWidth
        let bubbleHeight : CGFloat = size.height
        let magicNumber : CGFloat = FTDefaultMessageBubbleAngleWidth/4
        let distance : CGFloat = (FTDefaultMessageRoundCorner-magicNumber)/sqrt(2);

        path = UIBezierPath(roundedRect: CGRect(x: x, y: y, width: bubbleWidth, height: bubbleHeight),
                            byRoundingCorners: .allCorners,
                            cornerRadii: CGSize(width: FTDefaultMessageRoundCorner, height: FTDefaultMessageRoundCorner));
        
        if indexPath.row == 0 {
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
        }
        return path;
    }
    
}


extension FTChatMessageBubbleItem {
    
    internal class func getBubbleItemWithFrame(_ bubbleFrame: CGRect,aMessage: FTChatMessageModel, for indexPath: IndexPath) -> FTChatMessageBubbleItem {
        var messageBubbleItem : FTChatMessageBubbleItem! = FTChatMessageBubbleItem()
        switch aMessage.messageType {
        case .text:
            messageBubbleItem = FTChatMessageBubbleTextItem(frame: bubbleFrame, aMessage: aMessage, for: indexPath)
        case .image:
            messageBubbleItem = FTChatMessageBubbleImageItem(frame: bubbleFrame, aMessage: aMessage, for: indexPath)
        case .audio:
            messageBubbleItem = FTChatMessageBubbleAudioItem(frame: bubbleFrame, aMessage: aMessage, for: indexPath)
        case .location:
            messageBubbleItem = FTChatMessageBubbleLocationItem(frame: bubbleFrame, aMessage: aMessage, for: indexPath)
        case .video:
            messageBubbleItem = FTChatMessageBubbleVideoItem(frame: bubbleFrame, aMessage: aMessage, for: indexPath)
        default:
            break
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
                                                attributes: [NSAttributedStringKey.font:FTDefaultFontSize,NSAttributedStringKey.paragraphStyle: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()],
                                                context: nil)
            bubbleWidth = rect.width + FTDefaultTextLeftMargin*2 + FTDefaultMessageBubbleAngleWidth
        case .image:
            if aMessage.isKind(of: FTChatMessageImageModel.classForCoder()) {
                if let image : UIImage = (aMessage as! FTChatMessageImageModel).image {
                    bubbleWidth = FTImageSize.convertSizeForMessageBubble(size: image.size).width
                }else if let imageUrl : String = (aMessage as! FTChatMessageImageModel).imageUrl {
                    bubbleWidth = FTImageSize.getImageSizeFromImageURL(imageUrl, perferdWidth: FTDefaultMessageBubbleImageWidth, maxHeight: FTDefaultMessageBubbleImageHeight).height
                }else{
                    bubbleWidth = FTDefaultMessageBubbleImageWidth
                }
            }else{
                bubbleWidth = FTDefaultMessageBubbleImageWidth
            }
        case .audio:
            bubbleWidth = FTDefaultMessageBubbleImageWidth
        case .location:
            bubbleWidth = FTDefaultMessageBubbleMapViewWidth
        case .video:
            bubbleWidth = FTDefaultMessageBubbleImageWidth
        default:
            break
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
                                                    attributes: [NSAttributedStringKey.font:FTDefaultFontSize,NSAttributedStringKey.paragraphStyle: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()],
                                                    context: nil)
            bubbleHeight = max(textRect.height + FTDefaultTextTopMargin*2, FTDefaultMessageRoundCorner*2)
        case .image:
            if aMessage.isKind(of: FTChatMessageImageModel.classForCoder()) {
                if let image : UIImage = (aMessage as! FTChatMessageImageModel).image {
                    bubbleHeight = FTImageSize.convertSizeForMessageBubble(size: image.size).height
                }else if let imageUrl : String = (aMessage as! FTChatMessageImageModel).imageUrl {
                    bubbleHeight = FTImageSize.getImageSizeFromImageURL(imageUrl, perferdWidth: FTDefaultMessageBubbleImageWidth, maxHeight: FTDefaultMessageBubbleImageHeight).height
                }else{
                    bubbleHeight = FTDefaultMessageBubbleImageHeight
                }
            }else{
                bubbleHeight = FTDefaultMessageBubbleImageHeight
            }
        case .audio:
            bubbleHeight = FTDefaultMessageBubbleAudioHeight
        case .location:
            bubbleHeight = FTDefaultMessageBubbleMapViewHeight
        case .video:
            bubbleHeight = FTDefaultMessageBubbleImageHeight
        default:
            break
        }
        return bubbleHeight
    }
    

}

extension FTImageSize {
    
    internal class func convertSizeForMessageBubble(size :CGSize) -> CGSize {
        var convertedSize : CGSize = CGSize.zero
        if size.width == 0 || size.height == 0 {
            return CGSize(width: FTDefaultMessageBubbleImageWidth,height: FTDefaultMessageBubbleImageHeight)
        }
        if size.width < FTDefaultMessageBubbleImageWidth/2 {
            convertedSize.height = (size.height * FTDefaultMessageBubbleImageWidth/2) / size.width
            convertedSize.width = FTDefaultMessageBubbleImageWidth/2
        }else{
            convertedSize.height = (size.height * FTDefaultMessageBubbleImageWidth) / size.width
            convertedSize.width = FTDefaultMessageBubbleImageWidth;
        }
        convertedSize.height = min(convertedSize.height, FTDefaultMessageBubbleImageWidth*2)
        return convertedSize
    }
}
