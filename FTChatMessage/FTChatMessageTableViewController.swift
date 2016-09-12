//
//  FTChatMessageTableViewController.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit





class FTChatMessageTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,FTChatMessageInputViewDelegate, FTChatMessageHeaderDelegate {
    
    var messageTableView : UITableView!
    var messageInputView : FTChatMessageInputView!
    var messageRecordView : FTChatMessageRecorderView!
    var messageAccessoryView : FTChatMessageAccessoryView!
    var messageInputMode : FTChatMessageInputMode = FTChatMessageInputMode.None
    var messageArray : [FTChatMessageModel] = []
    var shouldShowSendTime : Bool = true
    var shouldShowSenderName : Bool = true
    var delegete : FTChatMessageDelegate?
    var dataSource : FTChatMessageDataSource?

    let sender1 = FTChatMessageUserModel.init(id: "1", name: "Someone", icon_url: "http://ww3.sinaimg.cn/mw600/6cca1403jw1f3lrknzxczj20gj0g0t96.jpg", extra_data: nil, isSelf: false)
    let sender2 = FTChatMessageUserModel.init(id: "2", name: "LiuFengting", icon_url: "http://ww3.sinaimg.cn/mw600/9d319f9agw1f3k8e4pixfj20u00u0ac6.jpg", extra_data: nil, isSelf: true)
    let sender3 = FTChatMessageUserModel.init(id: "3", name: "Someone else", icon_url: "http://ww3.sinaimg.cn/mw600/9d319f9agw1f3k8e4pixfj20u00u0ac6.jpg", extra_data: nil, isSelf: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageTableView = UITableView(frame: CGRectMake(0, 0, FTScreenWidth, FTScreenHeight), style: .Plain)
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.separatorStyle = .None
        messageTableView.allowsSelection = false
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
        messageRecordView.frame = CGRectMake(0, FTScreenHeight, FTScreenWidth, FTDefaultAccessoryViewHeight)
        self.view.addSubview(messageRecordView)
        
        messageAccessoryView = NSBundle.mainBundle().loadNibNamed("FTChatMessageAccessoryView", owner: nil, options: nil)[0] as! FTChatMessageAccessoryView
        messageAccessoryView.frame = CGRectMake(0, FTScreenHeight, FTScreenWidth, FTDefaultAccessoryViewHeight)

        self.view.addSubview(messageAccessoryView)
        
        dispatch_after( dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            self.scrollToBottom(false)
        }

        
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

    @objc private func keyboradWillChangeFrame(notification : NSNotification) {
        
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

    internal func ft_chatMessageInputViewShouldBeginEditing() {
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
    internal func ft_chatMessageInputViewShouldEndEditing() {
        messageInputMode = FTChatMessageInputMode.None;
    }
    
    internal func ft_chatMessageInputViewShouldUpdateHeight(desiredHeight: CGFloat) {
        var origin = messageInputView.frame;
        origin.origin.y = origin.origin.y + origin.size.height - desiredHeight;
        origin.size.height = desiredHeight;
        
        messageTableView.frame = CGRectMake(0, 0, FTScreenWidth, origin.origin.y + FTDefaultInputViewHeight)
        messageInputView.frame = origin
        self.scrollToBottom(true)
        messageInputView.layoutIfNeeded()
    }
    internal func ft_chatMessageInputViewShouldDoneWithText(textString: String) {
        let message8 = FTChatMessageModel(data: textString, time: "4.12 22:42", from: sender2, type: .Text)
        self.addNewMessage(message8)
        
    }
    internal func ft_chatMessageInputViewShouldShowRecordView(){
        let originMode = messageInputMode
        let inputViewFrameHeight = self.messageInputView.frame.size.height
        if originMode == FTChatMessageInputMode.Record {
            messageInputMode = FTChatMessageInputMode.None
            
            UIView.animateWithDuration(FTDefaultMessageDefaultAnimationDuration, animations: {
                
                self.messageTableView.frame = CGRectMake(0, 0, FTScreenWidth, FTScreenHeight - inputViewFrameHeight + FTDefaultInputViewHeight )
                self.messageInputView.frame = CGRectMake(0, FTScreenHeight - inputViewFrameHeight, FTScreenWidth, inputViewFrameHeight)
                self.messageRecordView.frame = CGRectMake(0, FTScreenHeight, FTScreenWidth, FTDefaultAccessoryViewHeight)
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
                self.messageTableView.frame = CGRectMake(0, 0, FTScreenWidth, FTScreenHeight - inputViewFrameHeight - FTDefaultAccessoryViewHeight + FTDefaultInputViewHeight )
                self.messageInputView.frame = CGRectMake(0, FTScreenHeight - inputViewFrameHeight - FTDefaultAccessoryViewHeight, FTScreenWidth, inputViewFrameHeight)
                self.messageRecordView.frame = CGRectMake(0, FTScreenHeight - FTDefaultAccessoryViewHeight, FTScreenWidth, FTDefaultAccessoryViewHeight)
                self.scrollToBottom(true)
                }, completion: { (finished) in

            })

        }
    }
    
    internal func ft_chatMessageInputViewShouldShowAccessoryView(){
        let originMode = messageInputMode

        let inputViewFrameHeight = self.messageInputView.frame.size.height
        
        if originMode == FTChatMessageInputMode.Accessory {
            messageInputMode = FTChatMessageInputMode.None
            UIView.animateWithDuration(FTDefaultMessageDefaultAnimationDuration, animations: {
                
                self.messageTableView.frame = CGRectMake(0, 0, FTScreenWidth, FTScreenHeight - inputViewFrameHeight + FTDefaultInputViewHeight )
                self.messageInputView.frame = CGRectMake(0, FTScreenHeight - inputViewFrameHeight, FTScreenWidth, inputViewFrameHeight)
                self.messageAccessoryView.frame = CGRectMake(0, FTScreenHeight, FTScreenWidth, FTDefaultAccessoryViewHeight)
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
                
                self.messageTableView.frame = CGRectMake(0, 0, FTScreenWidth, FTScreenHeight - inputViewFrameHeight - FTDefaultAccessoryViewHeight + FTDefaultInputViewHeight )
                
                self.messageInputView.frame = CGRectMake(0, FTScreenHeight - inputViewFrameHeight - FTDefaultAccessoryViewHeight, FTScreenWidth, inputViewFrameHeight)
                self.messageAccessoryView.frame = CGRectMake(0, FTScreenHeight - FTDefaultAccessoryViewHeight, FTScreenWidth, FTDefaultAccessoryViewHeight)
                self.scrollToBottom(true)
                }, completion: { (finished) in

            })
        }
    }

    //MARK: - dismissInputRecordView -

    private func dismissInputRecordView(){
        UIView.animateWithDuration(FTDefaultMessageDefaultAnimationDuration, animations: {
            self.messageRecordView.frame = CGRectMake(0, FTScreenHeight, FTScreenWidth, FTDefaultAccessoryViewHeight)
            })
    }

    
    //MARK: - dismissInputAccessoryView -

    private func dismissInputAccessoryView(){
        UIView.animateWithDuration(FTDefaultMessageDefaultAnimationDuration, animations: {
            self.messageAccessoryView.frame = CGRectMake(0, FTScreenHeight, FTScreenWidth, FTDefaultAccessoryViewHeight)
        })
    }
    
    
 

    
    
    internal func addNewMessage(message : FTChatMessageModel) {
        
        messageArray.append(message);
        
        messageTableView.insertSections(NSIndexSet.init(indexesInRange: NSMakeRange(messageArray.count-1, 1)), withRowAnimation: UITableViewRowAnimation.Bottom)
        
        self.scrollToBottom(true)

    }
    
    //MARK: - scrollToBottom -

    func scrollToBottom(animated: Bool) {
        if self.messageArray.count > 0 {
            self.messageTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: self.messageArray.count-1), atScrollPosition: UITableViewScrollPosition.Top, animated: animated)
        }
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
        let message = messageArray[section]
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
        let message = messageArray[indexPath.section]

        return FTChatMessageCell.getCellHeightWithMessage(message, shouldShowSendTime: shouldShowSendTime, shouldShowSenderName: shouldShowSenderName)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let message = messageArray[indexPath.section]
        
        let cell = FTChatMessageCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: FTDefaultMessageCellReuseIndentifier, theMessage: message, shouldShowSendTime: shouldShowSendTime , shouldShowSenderName: shouldShowSenderName );
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

   

    
    //MARK: - FTChatMessageHeaderDelegate -
    
    func ft_chatMessageHeaderDidTappedOnIcon(messageSenderModel: FTChatMessageUserModel) {
        print("tapped at user icon : \(messageSenderModel.senderName)")
 
    }
    
    //MARK: - preferredInterfaceOrientationForPresentation -

    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.Portrait
    }

}
