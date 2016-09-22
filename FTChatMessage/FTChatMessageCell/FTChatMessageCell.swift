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
    
    lazy var messageTimeLabel: UILabel! = {
        let label = UILabel(frame: CGRect.zero)
        label.font = FTDefaultTimeLabelFont
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        return label
    }()
    
    lazy var messageSenderNameLabel: UILabel! = {
        let label = UILabel(frame: CGRect.zero)
        label.font = FTDefaultTimeLabelFont
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        return label
    }()
    
    var messageDeliverStatusView : FTChatMessageDeliverStatusView? = {
        return FTChatMessageDeliverStatusView(frame: CGRect.zero)
    }()
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?, theMessage : FTChatMessageModel, shouldShowSendTime : Bool , shouldShowSenderName : Bool) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)

        message = theMessage

        var heightSoFar = -FTDefaultSectionHeight
        var bubbleRect = CGRect.zero

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
        
        bubbleRect = CGRect(x: x, y: y, width: bubbleWidth, height: bubbleHeight)

        self.setupCellBubbleItem(bubbleRect)

    }
    
    func setupCellBubbleItem(_ bubbleFrame: CGRect) {
        
        messageBubbleItem = FTChatMessageBubbleItem.getBubbleItemWithFrame(bubbleFrame, aMessage: message)
        self.addSubview(messageBubbleItem)
        
        if message.isUserSelf  && message.messageDeliverStatus != FTChatMessageDeliverStatus.succeeded{
            self.addSendStatusView(bubbleFrame)
        }
    }
    
    func addTimeLabel() {
        let timeLabelRect = CGRect(x: 0, y: -FTDefaultSectionHeight ,width: FTScreenWidth, height: FTDefaultTimeLabelHeight);
        messageTimeLabel.frame = timeLabelRect
        messageTimeLabel.text = message.messageTimeStamp
        self.addSubview(messageTimeLabel)
    }
    
    
    func addSenderLabel() {
        var nameLabelTextAlignment : NSTextAlignment = .right
        var nameLabelRect = CGRect( x: 0, y: (FTDefaultSectionHeight - FTDefaultNameLabelHeight)/2  - FTDefaultSectionHeight  , width: FTScreenWidth - (FTDefaultMargin + FTDefaultIconSize + FTDefaultMessageBubbleAngleWidth), height: FTDefaultNameLabelHeight)
 
        if message.isUserSelf == false {
            nameLabelRect.origin.x = FTDefaultMargin + FTDefaultIconSize + FTDefaultMessageBubbleAngleWidth
            nameLabelTextAlignment =  .left
        }
        
        messageSenderNameLabel.frame = nameLabelRect
        messageSenderNameLabel.text = message.messageSender.senderName
        messageSenderNameLabel.textAlignment = nameLabelTextAlignment
        self.addSubview(messageSenderNameLabel)
    }
    
    func addSendStatusView(_ bubbleFrame: CGRect) {
        let statusViewRect = CGRect(x: bubbleFrame.origin.x - FTDefaultMessageCellSendStatusViewSize - FTDefaultMargin, y: (bubbleFrame.origin.y + bubbleFrame.size.height - FTDefaultMessageCellSendStatusViewSize)/2, width: FTDefaultMessageCellSendStatusViewSize, height: FTDefaultMessageCellSendStatusViewSize)
        messageDeliverStatusView?.frame = statusViewRect
        messageDeliverStatusView?.setupWithDeliverStatus(message.messageDeliverStatus)
        self.addSubview(messageDeliverStatusView!)
    }
}



extension FTChatMessageCell {

    internal class func getCellHeightWithMessage(_ theMessage : FTChatMessageModel, shouldShowSendTime : Bool , shouldShowSenderName : Bool) -> CGFloat{
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






