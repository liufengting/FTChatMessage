//
//  FTChatMessageCell.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

class FTChatMessageCell: UITableViewCell {

    var message : FTChatMessageModel!
    
    var messageTimeLabel: UILabel!
    var messageSenderLabel: UILabel!
    var messageBubbleItem: FTChatMessageBubbleItem!
    var messageDeliverStatusView : FTChatMessageDeliverStatusView?
    
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?, theMessage : FTChatMessageModel, shouldShowSendTime : Bool , shouldShowSenderName : Bool) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)

        message = theMessage

        var timeLabelRect = CGRectZero
        var nameLabelRect = CGRectZero
        var bubbleRect = CGRectZero
        
        if shouldShowSendTime {
            timeLabelRect = CGRectMake(0, -FTDefaultSectionHeight ,FTScreenWidth, FTDefaultTimeLabelHeight);
            nameLabelRect = CGRectMake(0, FTDefaultTimeLabelHeight - FTDefaultSectionHeight, FTScreenWidth, 0);

            messageTimeLabel = UILabel(frame: timeLabelRect);
            messageTimeLabel.text = "\(message.messageTimeStamp)"
            messageTimeLabel.textAlignment = .Center
            messageTimeLabel.textColor = UIColor.lightGrayColor()
            messageTimeLabel.font = FTDefaultTimeLabelFont
            self.addSubview(messageTimeLabel)
        }else{
            nameLabelRect = CGRectMake(0, -FTDefaultSectionHeight, FTScreenWidth, 0);
        }


        if shouldShowSenderName {
            var nameLabelTextAlignment : NSTextAlignment = .Left
            
            if theMessage.isUserSelf {
                nameLabelRect = CGRectMake( 0, (FTDefaultSectionHeight - FTDefaultNameLabelHeight)/2  - FTDefaultSectionHeight  , FTScreenWidth - (FTDefaultMargin + FTDefaultIconSize + FTDefaultAngleWidth), FTDefaultNameLabelHeight)
                nameLabelTextAlignment =  .Right
            }else{
                nameLabelRect = CGRectMake(FTDefaultMargin + FTDefaultIconSize + FTDefaultAngleWidth, (FTDefaultSectionHeight - FTDefaultNameLabelHeight)/2  - FTDefaultSectionHeight ,FTScreenWidth, FTDefaultNameLabelHeight)
                nameLabelTextAlignment = .Left
            }
            messageSenderLabel = UILabel(frame: nameLabelRect);
            messageSenderLabel.text = "\(message.messageSender.senderName)"
            messageSenderLabel.textAlignment = nameLabelTextAlignment
            messageSenderLabel.textColor = UIColor.lightGrayColor()
            messageSenderLabel.font = FTDefaultTimeLabelFont
            self.addSubview(messageSenderLabel)
        }
        
        let y : CGFloat = nameLabelRect.origin.y + nameLabelRect.height + FTDefaultMargin
        var bubbleWidth : CGFloat = 0
        var bubbleHeight : CGFloat = 0
        
        switch message.messageType {
        case .Text:
            let att = NSString(string: message.messageText)
            let rect = att.boundingRectWithSize(CGSizeMake(FTDefaultTextInViewMaxWidth,CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()], context: nil)
            bubbleWidth = rect.width + FTDefaultTextMargin*2 + FTDefaultAngleWidth
            bubbleHeight = rect.height + FTDefaultTextMargin*2
        case .Image:
            bubbleWidth = FTDefaultMessageBubbleWidth
            bubbleHeight = FTDefaultMessageBubbleHeight
        case .Audio:
            bubbleWidth = FTDefaultMessageBubbleWidth
            bubbleHeight = FTDefaultMessageBubbleAudioHeight
        case .Location:
            bubbleWidth = FTDefaultMessageBubbleMapViewWidth
            bubbleHeight = FTDefaultMessageBubbleMapViewHeight
        case .Video:
            bubbleWidth = FTDefaultMessageBubbleWidth
            bubbleHeight = FTDefaultMessageBubbleHeight
            
            
        }
        
        let x = theMessage.isUserSelf ? FTScreenWidth - (FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin) - bubbleWidth : FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin
        
        bubbleRect = CGRectMake(x, y, bubbleWidth, bubbleHeight)

        
        self.setupCellBubbleItem(bubbleRect)

    }
    
    func setupCellBubbleItem(bubbleFrame: CGRect) {
    
        switch message.messageType {
        case .Text:
            messageBubbleItem = FTChatMessageBubbleTextItem(frame: bubbleFrame, aMessage: message)
        
        case .Image:
            messageBubbleItem = FTChatMessageBubbleImageItem(frame: bubbleFrame, aMessage: message)
        
        case .Audio:

            messageBubbleItem = FTChatMessageBubbleAudioItem(frame: bubbleFrame, aMessage: message)

        case .Location:

            messageBubbleItem = FTChatMessageBubbleLocationItem(frame: bubbleFrame, aMessage: message)

        case .Video:
        
            messageBubbleItem = FTChatMessageBubbleVideoItem(frame: bubbleFrame, aMessage: message)

        }
        
        
        
        if message.isUserSelf  && message.messageDeliverStatus != FTChatMessageDeliverStatus.Succeeded{
            if messageDeliverStatusView == nil {
                messageDeliverStatusView = FTChatMessageDeliverStatusView(frame: CGRectZero)
            }
            let statusViewRect = CGRectMake(bubbleFrame.origin.x - 20 - FTDefaultMargin, (bubbleFrame.origin.y + bubbleFrame.size.height - 20)/2, 20, 20)
            messageDeliverStatusView?.frame = statusViewRect
            messageDeliverStatusView?.setupWithDeliverStatus(message.messageDeliverStatus)
            self.addSubview(messageDeliverStatusView!)
        }
        
        
        

        self.addSubview(messageBubbleItem)

    }
    

    class func getCellHeightWithMessage(theMessage : FTChatMessageModel, shouldShowSendTime : Bool , shouldShowSenderName : Bool) -> CGFloat{
        var cellDesiredHeight : CGFloat = 0;
        if shouldShowSendTime {
            cellDesiredHeight = FTDefaultTimeLabelHeight
        }
        if shouldShowSenderName {
            cellDesiredHeight = (FTDefaultSectionHeight - FTDefaultNameLabelHeight)/2 + FTDefaultNameLabelHeight
        }
        cellDesiredHeight += FTDefaultMargin
        switch theMessage.messageType {
        case .Text:
            let att = NSString(string: theMessage.messageText)
            let textRect = att.boundingRectWithSize(CGSizeMake(FTDefaultTextInViewMaxWidth,CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:FTDefaultFontSize,NSParagraphStyleAttributeName: FTChatMessagePublicMethods.getFTDefaultMessageParagraphStyle()], context: nil)
            cellDesiredHeight += textRect.height + FTDefaultTextMargin*2
        case .Image:
            cellDesiredHeight += FTDefaultMessageBubbleHeight
        case .Audio:
            cellDesiredHeight += FTDefaultMessageBubbleAudioHeight
        case .Location:
            cellDesiredHeight += FTDefaultMessageBubbleMapViewHeight
        case .Video:
            cellDesiredHeight += FTDefaultMessageBubbleHeight
        }
        cellDesiredHeight += FTDefaultMargin*2 - FTDefaultSectionHeight

        return cellDesiredHeight
    }
    
    
    
    
}
class FTChatMessageDeliverStatusView: UIView {

    lazy var activityIndicator : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activity.frame = self.bounds
        return activity
    }()
    
    lazy var failedImageView : UIImageView = {
        let imageView = UIImageView.init(frame: CGRectMake(0, 0, 20, 20))
        imageView.backgroundColor = UIColor.clearColor();
        imageView.image = UIImage(named: "FT_Add")
        return imageView
    }()
    
    func setupWithDeliverStatus(status : FTChatMessageDeliverStatus) {
        self.backgroundColor = UIColor.clearColor()
        
        switch status {
        case .Sending:
            activityIndicator.startAnimating()
            self.addSubview(activityIndicator)
            failedImageView.hidden = true
        case .Succeeded:
            activityIndicator.stopAnimating()
            activityIndicator.hidden = true
            failedImageView.hidden = true
        case .failed:
            activityIndicator.stopAnimating()
            activityIndicator.hidden = true
            self.addSubview(failedImageView)
            failedImageView.hidden = false
        }
        
    }
    
    
}



