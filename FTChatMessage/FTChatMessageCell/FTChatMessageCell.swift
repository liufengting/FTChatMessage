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
        let bubbleWidth : CGFloat = FTChatMessageBubbleItem.getMessageBubbleWidthForMessage(theMessage)
        let bubbleHeight : CGFloat = FTChatMessageBubbleItem.getMessageBubbleHeightForMessage(theMessage)

        let x = theMessage.isUserSelf ? FTScreenWidth - (FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin) - bubbleWidth : FTDefaultIconSize + FTDefaultMargin + FTDefaultIconToMessageMargin
        
        bubbleRect = CGRectMake(x, y, bubbleWidth, bubbleHeight)

        self.setupCellBubbleItem(bubbleRect)

    }
    
    func setupCellBubbleItem(bubbleFrame: CGRect) {
        
        messageBubbleItem = FTChatMessageBubbleItem.getBubbleItemWithFrame(bubbleFrame, aMessage: message)

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
    
    var messageTimeLabel: UILabel! = {
        
        
        return UILabel()
    }()
    

    var messageSenderLabel: UILabel! = {
        
        
        return UILabel()
    }()

 
    
    
    
}
extension FTChatMessageCell {

    internal class func getCellHeightWithMessage(theMessage : FTChatMessageModel, shouldShowSendTime : Bool , shouldShowSenderName : Bool) -> CGFloat{
        var cellDesiredHeight : CGFloat = 0;
        if shouldShowSendTime {
            cellDesiredHeight = FTDefaultTimeLabelHeight
        }
        if shouldShowSenderName {
            cellDesiredHeight = (FTDefaultSectionHeight - FTDefaultNameLabelHeight)/2 + FTDefaultNameLabelHeight
        }
        cellDesiredHeight += FTDefaultMargin
        cellDesiredHeight += FTChatMessageBubbleItem.getMessageBubbleHeightForMessage(theMessage)
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



