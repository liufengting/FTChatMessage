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
    
    var messageTimeLabel: UILabel! = {
        let label = UILabel(frame: CGRectZero)
        label.font = FTDefaultTimeLabelFont
        label.textAlignment = .Center
        label.textColor = UIColor.lightGrayColor()
        return label
    }()
    
    var messageSenderLabel: UILabel! = {
        let label = UILabel(frame: CGRectZero)
        label.font = FTDefaultTimeLabelFont
        label.textAlignment = .Center
        label.textColor = UIColor.lightGrayColor()
        return label
    }()
    
    var messageDeliverStatusView : FTChatMessageDeliverStatusView? = {
        return FTChatMessageDeliverStatusView(frame: CGRectZero)
    }()
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?, theMessage : FTChatMessageModel, shouldShowSendTime : Bool , shouldShowSenderName : Bool) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)

        message = theMessage

        var heightSoFar = -FTDefaultSectionHeight
        var bubbleRect = CGRectZero

        if shouldShowSendTime {
            self.addTimeLabel()
            heightSoFar += FTDefaultTimeLabelHeight
        }

        if shouldShowSenderName {
            self.addSenderLabel()
            heightSoFar = (FTDefaultNameLabelHeight - FTDefaultSectionHeight)/2
        }
        
        let y : CGFloat = heightSoFar + FTDefaultMargin
        let bubbleWidth : CGFloat = FTChatMessageBubbleItem.getMessageBubbleWidthForMessage(theMessage)
        let bubbleHeight : CGFloat = FTChatMessageBubbleItem.getMessageBubbleHeightForMessage(theMessage)

        let x = theMessage.isUserSelf ? FTScreenWidth - (FTDefaultIconSize + FTDefaultMargin + FTDefaultMessageCellIconToMessageMargin) - bubbleWidth : FTDefaultIconSize + FTDefaultMargin + FTDefaultMessageCellIconToMessageMargin
        
        bubbleRect = CGRectMake(x, y, bubbleWidth, bubbleHeight)

        self.setupCellBubbleItem(bubbleRect)

    }
    
    func setupCellBubbleItem(bubbleFrame: CGRect) {
        
        messageBubbleItem = FTChatMessageBubbleItem.getBubbleItemWithFrame(bubbleFrame, aMessage: message)
        self.addSubview(messageBubbleItem)
        
        if message.isUserSelf  && message.messageDeliverStatus != FTChatMessageDeliverStatus.Succeeded{
            self.addSendStatusView(bubbleFrame)
        }
    }
    
    func addTimeLabel() {
        let timeLabelRect = CGRectMake(0, -FTDefaultSectionHeight ,FTScreenWidth, FTDefaultTimeLabelHeight);
        messageTimeLabel.frame = timeLabelRect
        messageTimeLabel.text = "\(message.messageTimeStamp)"
        self.addSubview(messageTimeLabel)
    }
    
    
    func addSenderLabel() {
        var nameLabelTextAlignment : NSTextAlignment = .Right
        var nameLabelRect = CGRectMake( 0, (FTDefaultSectionHeight - FTDefaultNameLabelHeight)/2  - FTDefaultSectionHeight  , FTScreenWidth - (FTDefaultMargin + FTDefaultIconSize + FTDefaultMessageBubbleAngleWidth), FTDefaultNameLabelHeight)
 
        if message.isUserSelf == false {
            nameLabelRect.origin.x = FTDefaultMargin + FTDefaultIconSize + FTDefaultMessageBubbleAngleWidth
            nameLabelTextAlignment =  .Left
        }
        
        messageSenderLabel.frame = nameLabelRect
        messageSenderLabel.text = "\(message.messageSender.senderName)"
        messageSenderLabel.textAlignment = nameLabelTextAlignment
        self.addSubview(messageSenderLabel)
    }
    
    func addSendStatusView(bubbleFrame: CGRect) {
        let statusViewRect = CGRectMake(bubbleFrame.origin.x - FTDefaultMessageCellSendStatusViewSize - FTDefaultMargin, (bubbleFrame.origin.y + bubbleFrame.size.height - FTDefaultMessageCellSendStatusViewSize)/2, FTDefaultMessageCellSendStatusViewSize, FTDefaultMessageCellSendStatusViewSize)
        messageDeliverStatusView?.frame = statusViewRect
        messageDeliverStatusView?.setupWithDeliverStatus(message.messageDeliverStatus)
        self.addSubview(messageDeliverStatusView!)
    }
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






