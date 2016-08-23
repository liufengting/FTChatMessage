//
//  FTChatMessageTableViewController.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit
import FTIndicator




class FTChatMessageTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,FTChatMessageInputViewDelegate,FTChatMessageAccessoryViewDataSource,FTChatMessageAccessoryViewDelegate, FTChatMessageHeaderDelegate, FTChatMessageRecorderViewDelegate{
    
    var messageTableView : UITableView!
    var messageInputView : FTChatMessageInputView!
    var messageRecordView : FTChatMessageRecorderView!
    var messageAccessoryView : FTChatMessageAccessoryView!
    var messageInputMode : FTChatMessageInputMode = FTChatMessageInputMode.None
    
    var messageArray : NSMutableArray!
    var shouldShowSendTime : Bool = true
    var shouldShowSenderName : Bool = true

    
    let sender1 = FTChatMessageUserModel.init(id: "1", name: "Someone", icon_url: "http://ww3.sinaimg.cn/mw600/6cca1403jw1f3lrknzxczj20gj0g0t96.jpg", extra_data: nil, isSelf: false)
    let sender2 = FTChatMessageUserModel.init(id: "2", name: "LiuFengting", icon_url: "http://ww3.sinaimg.cn/mw600/9d319f9agw1f3k8e4pixfj20u00u0ac6.jpg", extra_data: nil, isSelf: true)
    let sender3 = FTChatMessageUserModel.init(id: "3", name: "Someone else", icon_url: "http://ww3.sinaimg.cn/mw600/9d319f9agw1f3k8e4pixfj20u00u0ac6.jpg", extra_data: nil, isSelf: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.navigationItem.setRightBarButtonItem(UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(self.addNewIncomingMessage)), animated: true)
       
        self.loadDefaultMessages()
        
        messageTableView = UITableView(frame: CGRectMake(0, 0, FTScreenWidth, FTScreenHeight), style: .Plain)
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.separatorStyle = .None
        messageTableView.allowsSelection = false
        messageTableView.scrollsToTop = true
        messageTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        messageTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, FTDefaultInputViewHeight, 0)
        self.view.addSubview(messageTableView)

        let header = UIView(frame: CGRectMake( 0, 0, FTScreenWidth, FTDefaultMargin*2))
        messageTableView.tableHeaderView = header
        
        let footer = UIView(frame: CGRectMake( 0, 0, FTScreenWidth, FTDefaultInputViewHeight))
        messageTableView.tableFooterView = footer
        

        
        messageInputView = NSBundle.mainBundle().loadNibNamed("FTChatMessageInputView", owner: nil, options: nil)[0] as! FTChatMessageInputView
       messageInputView.frame = CGRectMake(0, FTScreenHeight-FTDefaultInputViewHeight, FTScreenWidth, FTDefaultInputViewHeight)
        messageInputView.inputDelegate = self
        self.view.addSubview(messageInputView)

        messageRecordView = NSBundle.mainBundle().loadNibNamed("FTChatMessageRecorderView", owner: nil, options: nil)[0] as! FTChatMessageRecorderView
        messageRecordView.frame = CGRectMake(0, FTScreenHeight, FTScreenWidth, FTDefaultRecordViewHeight)
        messageRecordView.recorderDelegate = self
        self.view.addSubview(messageRecordView)
        
        messageAccessoryView = NSBundle.mainBundle().loadNibNamed("FTChatMessageAccessoryView", owner: nil, options: nil)[0] as! FTChatMessageAccessoryView
        messageAccessoryView.frame = CGRectMake(0, FTScreenHeight, FTScreenWidth, FTDefaultRecordViewHeight)
        messageAccessoryView.setupWithDataSource(self , accessoryViewDelegate : self)
        self.view.addSubview(messageAccessoryView)
        
        dispatch_after( dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            self.scrollToBottom(false)
        }
    }
    
    
    
    
    
    
    func loadDefaultMessages(){
        let message1 = FTChatMessageModel(data: "最近有点无聊，抽点时间写了这个聊天的UI框架。", time: "4.12 21:09:50", from: sender1, type: .Text)
        let message2 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "4.12 21:09:51", from: sender2, type: .Audio)
        let message3 = FTChatMessageModel(data: "纯Swift编写，目前只写了纯文本消息，后续会有更多功能，图片视频语音定位等。这一版本还有很多需要优化，希望可以改成一个易拓展的方便大家使用，哈哈哈哈", time: "4.12 21:09:52", from: sender1, type: .Image)
        let message4 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "4.12 21:09:53", from: sender2, type: .Video)
        let message5 = FTChatMessageModel(data: "文字背景不是图片，是用贝塞尔曲线画的，效率应该不高，后期优化", time: "4.12 21:09:53", from: sender1, type: .Text)
        let message6 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "4.12 21:09:54", from: sender2, type: .Text)
        let message7 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "4.12 21:09:55", from: sender1, type: .Text)
        let message8 = FTChatMessageModel(data: "https://raw.githubusercontent.com/liufengting/liufengting.github.io/master/img/macbookpro.jpg", time: "4.12 21:09:56", from: sender3, type: .Image)

        messageArray = NSMutableArray(array: [message1,message2,message3,message4,message5,message6,message7,message8,
            message1,message2,message3,message4,message5,message6,message7,message8,
            message1,message2,message3,message4,message5,message6,message7,message8,
            message1,message2,message3,message4,message5,message6,message7,message8,
            message1,message2,message3,message4,message5,message6,message7,message8,
            message1,message2,message3,message4,message5,message6,message7,message8,])
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboradWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)


    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
    
    }
    
//    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
//        self.messageTableView.frame = CGRectMake(0, 0, FTScreenWidth, FTScreenHeight)
//        self.messageTableView.reloadData()
//    }
    
    
    //MARK: - keyborad notification functions -

    func keyboradWillChangeFrame(notification : NSNotification) {
        
        if messageInputMode == FTChatMessageInputMode.Keyboard {
            if let userInfo = notification.userInfo {
                let duration = userInfo["UIKeyboardAnimationDurationUserInfoKey"]!.doubleValue
                let keyFrame = userInfo["UIKeyboardFrameEndUserInfoKey"]!.CGRectValue()
                let keyboradOriginY = min(keyFrame.origin.y, FTScreenHeight)
                let inputBarHeight = messageInputView.frame.height
                
                
                UIView.animateWithDuration(duration, animations: {
                    self.messageTableView.frame = CGRectMake(0 , 0 , FTScreenWidth, keyboradOriginY)
                    self.messageInputView.frame = CGRectMake(0, keyboradOriginY - inputBarHeight, FTScreenWidth, inputBarHeight)
                    self.scrollToBottom(true)
                    }, completion: { (finished) in
                        if finished {
                            if self.messageInputView.inputTextView.isFirstResponder() {
                                self.dismissInputRecordView()
                                self.dismissInputAccessoryView()
                            }
                        }
                })
            }
        }

    }

    //MARK: - FTChatMessageInputViewDelegate -

    func ft_chatMessageInputViewShouldBeginEditing() {
        let originMode = messageInputMode
        messageInputMode = FTChatMessageInputMode.Keyboard;
        switch originMode {
        case .Keyboard: break
        case .Accessory:
            self.dismissInputAccessoryView()
        case .Record:
            self.dismissInputRecordView()
        case .None: break
        }
    }
    func ft_chatMessageInputViewShouldEndEditing() {
        messageInputMode = FTChatMessageInputMode.None;
    }
    
    func ft_chatMessageInputViewShouldUpdateHeight(desiredHeight: CGFloat) {
        var origin = messageInputView.frame;
        origin.origin.y = origin.origin.y + origin.size.height - desiredHeight;
        origin.size.height = desiredHeight;
        
        messageTableView.frame = CGRectMake(0, 0, FTScreenWidth, origin.origin.y + FTDefaultInputViewHeight)
        messageInputView.frame = origin
        self.scrollToBottom(true)
        messageInputView.layoutIfNeeded()
    }
    func ft_chatMessageInputViewShouldDoneWithText(textString: String) {
        
        self.addNewMessage(textString)
        
    }
    func ft_chatMessageInputViewShouldShowRecordView(){
        let originMode = messageInputMode
        let inputViewFrameHeight = self.messageInputView.frame.size.height
        if originMode == FTChatMessageInputMode.Record {
            messageInputMode = FTChatMessageInputMode.None
            
            UIView.animateWithDuration(FTDefaultMessageDefaultAnimationDuration, animations: {
                
                self.messageTableView.frame = CGRectMake(0, 0, FTScreenWidth, FTScreenHeight - inputViewFrameHeight + FTDefaultInputViewHeight )
                self.messageInputView.frame = CGRectMake(0, FTScreenHeight - inputViewFrameHeight, FTScreenWidth, inputViewFrameHeight)
                self.messageRecordView.frame = CGRectMake(0, FTScreenHeight, FTScreenWidth, FTDefaultRecordViewHeight)
                self.scrollToBottom(true)
                }, completion: { (finished) in
            })
        }else{
            switch originMode {
            case .Keyboard:
                self.messageInputView.inputTextView.resignFirstResponder()
            case .Accessory:
                self.dismissInputAccessoryView()
            case .None: break
            case .Record: break
            }
            messageInputMode = FTChatMessageInputMode.Record

            UIView.animateWithDuration(FTDefaultMessageDefaultAnimationDuration, animations: {
                self.messageTableView.frame = CGRectMake(0, 0, FTScreenWidth, FTScreenHeight - inputViewFrameHeight - FTDefaultRecordViewHeight + FTDefaultInputViewHeight )
                self.messageInputView.frame = CGRectMake(0, FTScreenHeight - inputViewFrameHeight - FTDefaultRecordViewHeight, FTScreenWidth, inputViewFrameHeight)
                self.messageRecordView.frame = CGRectMake(0, FTScreenHeight - FTDefaultRecordViewHeight, FTScreenWidth, FTDefaultRecordViewHeight)
                self.scrollToBottom(true)
                }, completion: { (finished) in

            })

        }
    }
    
    func ft_chatMessageInputViewShouldShowAccessoryView(){
        let originMode = messageInputMode

        let inputViewFrameHeight = self.messageInputView.frame.size.height
        
        if originMode == FTChatMessageInputMode.Accessory {
            messageInputMode = FTChatMessageInputMode.None
            UIView.animateWithDuration(FTDefaultMessageDefaultAnimationDuration, animations: {
                
                self.messageTableView.frame = CGRectMake(0, 0, FTScreenWidth, FTScreenHeight - inputViewFrameHeight + FTDefaultInputViewHeight )
                self.messageInputView.frame = CGRectMake(0, FTScreenHeight - inputViewFrameHeight, FTScreenWidth, inputViewFrameHeight)
                self.messageAccessoryView.frame = CGRectMake(0, FTScreenHeight, FTScreenWidth, FTDefaultRecordViewHeight)
                self.scrollToBottom(true)
                }, completion: { (finished) in

            })
        }else{
            switch originMode {
            case .Keyboard:
                self.messageInputView.inputTextView.resignFirstResponder()
            case .Record:
                self.dismissInputRecordView()
            case .None: break
            case .Accessory: break
            }
            messageInputMode = FTChatMessageInputMode.Accessory

            UIView.animateWithDuration(FTDefaultMessageDefaultAnimationDuration, animations: {
                
                self.messageTableView.frame = CGRectMake(0, 0, FTScreenWidth, FTScreenHeight - inputViewFrameHeight - FTDefaultRecordViewHeight + FTDefaultInputViewHeight )
                
                self.messageInputView.frame = CGRectMake(0, FTScreenHeight - inputViewFrameHeight - FTDefaultRecordViewHeight, FTScreenWidth, inputViewFrameHeight)
                self.messageAccessoryView.frame = CGRectMake(0, FTScreenHeight - FTDefaultRecordViewHeight, FTScreenWidth, FTDefaultRecordViewHeight)
                self.scrollToBottom(true)
                }, completion: { (finished) in

            })
        }
    }

    //MARK: - dismissInputRecordView -

    func dismissInputRecordView(){
        UIView.animateWithDuration(FTDefaultMessageDefaultAnimationDuration, animations: {
            self.messageRecordView.frame = CGRectMake(0, FTScreenHeight, FTScreenWidth, FTDefaultRecordViewHeight)
            })
    }

    
    //MARK: - dismissInputAccessoryView -

    func dismissInputAccessoryView(){
        UIView.animateWithDuration(FTDefaultMessageDefaultAnimationDuration, animations: {
            self.messageAccessoryView.frame = CGRectMake(0, FTScreenHeight, FTScreenWidth, FTDefaultRecordViewHeight)
        })
    }
    
    
 
    
    //MARK: - addNewIncomingMessage -

    func addNewIncomingMessage() {
        
        let message8 = FTChatMessageModel(data: "New Message", time: "4.12 22:42", from: sender1, type: .Text)
        
        messageArray.addObject(message8);
        
        messageTableView.insertSections(NSIndexSet.init(indexesInRange: NSMakeRange(messageArray.count-1, 1)), withRowAnimation: UITableViewRowAnimation.Bottom)
        
        self.scrollToBottom(true)
        
    }
    
    
    func addNewMessage(text:String) {
        
        let message8 = FTChatMessageModel(data: text, time: "4.12 22:43", from: sender2, type: .Text)
        message8.messageDeliverStatus = FTChatMessageDeliverStatus.Sending
        messageArray.addObject(message8);
        
        messageTableView.insertSections(NSIndexSet.init(indexesInRange: NSMakeRange(messageArray.count-1, 1)), withRowAnimation: UITableViewRowAnimation.Bottom)
        
        self.scrollToBottom(true)
        

        

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {

            
            message8.messageDeliverStatus = FTChatMessageDeliverStatus.Succeeded
            
            self.messageTableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: self.messageArray.indexOfObject(message8))], withRowAnimation: UITableViewRowAnimation.None)
            
            
        })

        
    }
    
    //MARK: - scrollToBottom -

    func scrollToBottom(animated: Bool) {
        self.messageTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: self.messageArray.count-1), atScrollPosition: UITableViewScrollPosition.Top, animated: animated)
    }

    //MARK: - UITableViewDelegate,UITableViewDataSource -
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        switch self.messageInputMode {
        case .Accessory:
            self.ft_chatMessageInputViewShouldShowAccessoryView()
        case .Record:
            self.ft_chatMessageInputViewShouldShowRecordView()
        default:
            break;
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return messageArray.count;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let message = messageArray[section] as! FTChatMessageModel
        let header = FTChatMessageHeader.init(frame: CGRectMake(0,0,FTScreenWidth,40), senderModel: message.messageSender)
        header.headerViewDelegate = self
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let message = messageArray[indexPath.section] as! FTChatMessageModel

        return FTChatMessageCell.getCellHeightWithMessage(message, shouldShowSendTime: shouldShowSendTime, shouldShowSenderName: shouldShowSenderName)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let message = messageArray[indexPath.section] as! FTChatMessageModel
        
        let cell = FTChatMessageCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: FTChatMessageCellReuseIndentifier, theMessage: message, shouldShowSendTime: shouldShowSendTime , shouldShowSenderName: shouldShowSenderName );
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

   
    //MARK: - FTChatMessageRecorderViewDelegate -
    
    func ft_chatMessageRecordViewDidStartRecording(){
        FTIndicator.showProgressWithmessage("Recording...")
    }
    func ft_chatMessageRecordViewDidCancelRecording(){
        FTIndicator.dismissProgress()
    }
    func ft_chatMessageRecordViewDidStopRecording(duriation: NSTimeInterval, file: NSData?){
        FTIndicator.dismissProgress()
    }
    
    //MARK: - FTChatMessageAccessoryViewDataSource -

    func ftChatMessageAccessoryViewItemCount() -> NSInteger {
        return self.getAccessoryItemTitle().count
    }
    func ftChatMessageAccessoryViewImageForItemAtIndex(index : NSInteger) -> UIImage {
        return UIImage(named: self.getAccessoryItemTitle()[index])!
    }
    func ftChatMessageAccessoryViewTitleForItemAtIndex(index : NSInteger) -> String {
        return self.getAccessoryItemTitle()[index]
    }
    
    func getAccessoryItemTitle() -> [String] {
        return ["Alarm","Camera","Contacts","Mail","Messages","Music","Phone","Photos","Settings","VideoChat","Videos","Weather"]
    }

    
    //MARK: - FTChatMessageAccessoryViewDelegate -

    func ftChatMessageAccessoryViewDidTappedOnItemAtIndex(index: NSInteger) {
        print("tapped at accessory view at index : \(index)")
    }
    
    //MARK: - FTChatMessageHeaderDelegate -
    
    func fTChatMessageHeaderDidTappedOnIcon(messageSenderModel: FTChatMessageUserModel) {
        print("tapped at user icon : \(messageSenderModel.senderName)")
 
    }
    
    //MARK: - preferredInterfaceOrientationForPresentation -

    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.Portrait
    }

}
