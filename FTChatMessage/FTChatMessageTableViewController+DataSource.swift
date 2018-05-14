//
//  FTChatMessageTableViewController+DataSource.swift
//  FTChatMessage
//
//  Created by liufengting on 16/9/27.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit

extension FTChatMessageTableViewController{
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboradWillChangeFrame(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didChangeStatusBar(_:)), name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }

    //MARK: - scrollToBottom -
    
    func scrollToBottom(_ animated: Bool) {
        if self.messageArray.count > 0 {
            let lastSection = self.messageArray.count - 1
            let lastSectionMessageCount = messageArray[lastSection].count - 1

            self.messageTableView.scrollToRow(at: IndexPath(row: lastSectionMessageCount, section: lastSection), at: UITableViewScrollPosition.top, animated: animated)
        }
    }
    
//mark -
    
    @objc fileprivate func didChangeStatusBar(_ notification: Notification) {
//        self.view.endEditing(true)
        
        DispatchQueue.main.asyncAfter( deadline: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            self.repositionEverything()
        }
        
    }
    
    
    //MARK: - keyborad notification functions -
    
    @objc fileprivate func keyboradWillChangeFrame(_ notification: Notification) {
        
        if messageInputMode == FTChatMessageInputMode.keyboard {
            if let userInfo = (notification as NSNotification).userInfo {
                let duration = (userInfo["UIKeyboardAnimationDurationUserInfoKey"]! as AnyObject).doubleValue
                let keyFrame : CGRect = (userInfo["UIKeyboardFrameEndUserInfoKey"]! as AnyObject).cgRectValue
                let keyboradOriginY = min(keyFrame.origin.y, FTScreenHeight)
                let inputBarHeight = messageInputView.frame.height
                
                
                UIView.animate(withDuration: duration!, animations: {
                    self.messageTableView.frame = CGRect(x: 0 , y: 0 , width: FTScreenWidth, height: keyboradOriginY)
                    self.messageInputView.frame = CGRect(x: 0, y: keyboradOriginY - inputBarHeight, width: FTScreenWidth, height: inputBarHeight)
                    self.scrollToBottom(true)
                    }, completion: { (finished) in
                        if finished {
                            if self.messageInputView.inputTextView.isFirstResponder {
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
        messageInputMode = FTChatMessageInputMode.keyboard;
        switch originMode {
        case .keyboard: break
        case .accessory:
            self.dismissInputAccessoryView()
        case .record:
            self.dismissInputRecordView()
        case .none: break
        }
    }
    
    internal func ft_chatMessageInputViewShouldEndEditing() {
        messageInputMode = FTChatMessageInputMode.none;
    }
    
    internal func ft_chatMessageInputViewShouldUpdateHeight(_ desiredHeight: CGFloat) {
        var origin = messageInputView.frame;
        origin.origin.y = origin.origin.y + origin.size.height - desiredHeight;
        origin.size.height = desiredHeight;
        
        messageTableView.frame = CGRect(x: 0, y: 0, width: FTScreenWidth, height: origin.origin.y + FTDefaultInputViewHeight)
        messageInputView.frame = origin
        self.scrollToBottom(true)
        messageInputView.layoutIfNeeded()
    }
    internal func ft_chatMessageInputViewShouldDoneWithText(_ textString: String) {
        let message8 = FTChatMessageModel(data: textString, time: "4.12 22:42", from: sender2, type: .text)
        self.addNewMessage(message8)
        
    }
    internal func ft_chatMessageInputViewShouldShowRecordView(){
        let originMode = messageInputMode
        let inputViewFrameHeight = self.messageInputView.frame.size.height
        if originMode == FTChatMessageInputMode.record {
            messageInputMode = FTChatMessageInputMode.none
            
            UIView.animate(withDuration: FTDefaultMessageDefaultAnimationDuration, animations: {
                
                self.messageTableView.frame = CGRect(x: 0, y: 0, width: FTScreenWidth, height: FTScreenHeight - inputViewFrameHeight + FTDefaultInputViewHeight )
                self.messageInputView.frame = CGRect(x: 0, y: FTScreenHeight - inputViewFrameHeight, width: FTScreenWidth, height: inputViewFrameHeight)
                self.messageRecordView.frame = CGRect(x: 0, y: FTScreenHeight, width: FTScreenWidth, height: FTDefaultAccessoryViewHeight)
                self.scrollToBottom(true)
                }, completion: { (finished) in
            })
        }else{
            switch originMode {
            case .keyboard:
                self.messageInputView.inputTextView.resignFirstResponder()
            case .accessory:
                self.dismissInputAccessoryView()
            case .none: break
            case .record: break
            }
            messageInputMode = FTChatMessageInputMode.record
            
            UIView.animate(withDuration: FTDefaultMessageDefaultAnimationDuration, animations: {
                self.messageTableView.frame = CGRect(x: 0, y: 0, width: FTScreenWidth, height: FTScreenHeight - inputViewFrameHeight - FTDefaultAccessoryViewHeight + FTDefaultInputViewHeight )
                self.messageInputView.frame = CGRect(x: 0, y: FTScreenHeight - inputViewFrameHeight - FTDefaultAccessoryViewHeight, width: FTScreenWidth, height: inputViewFrameHeight)
                self.messageRecordView.frame = CGRect(x: 0, y: FTScreenHeight - FTDefaultAccessoryViewHeight, width: FTScreenWidth, height: FTDefaultAccessoryViewHeight)
                self.scrollToBottom(true)
                }, completion: { (finished) in
                    
            })
            
        }
    }
    
    internal func ft_chatMessageInputViewShouldShowAccessoryView(){
        let originMode = messageInputMode
        
        let inputViewFrameHeight = self.messageInputView.frame.size.height
        
        if originMode == FTChatMessageInputMode.accessory {
            messageInputMode = FTChatMessageInputMode.none
            UIView.animate(withDuration: FTDefaultMessageDefaultAnimationDuration, animations: {
                
                self.messageTableView.frame = CGRect(x: 0, y: 0, width: FTScreenWidth, height: FTScreenHeight - inputViewFrameHeight + FTDefaultInputViewHeight )
                self.messageInputView.frame = CGRect(x: 0, y: FTScreenHeight - inputViewFrameHeight, width: FTScreenWidth, height: inputViewFrameHeight)
                self.messageAccessoryView.frame = CGRect(x: 0, y: FTScreenHeight, width: FTScreenWidth, height: FTDefaultAccessoryViewHeight)
                self.scrollToBottom(true)
                }, completion: { (finished) in
                    
            })
        }else{
            switch originMode {
            case .keyboard:
                self.messageInputView.inputTextView.resignFirstResponder()
            case .record:
                self.dismissInputRecordView()
            case .none: break
            case .accessory: break
            }
            messageInputMode = FTChatMessageInputMode.accessory
            
            UIView.animate(withDuration: FTDefaultMessageDefaultAnimationDuration, animations: {
                
                self.messageTableView.frame = CGRect(x: 0, y: 0, width: FTScreenWidth, height: FTScreenHeight - inputViewFrameHeight - FTDefaultAccessoryViewHeight + FTDefaultInputViewHeight )
                
                self.messageInputView.frame = CGRect(x: 0, y: FTScreenHeight - inputViewFrameHeight - FTDefaultAccessoryViewHeight, width: FTScreenWidth, height: inputViewFrameHeight)
                self.messageAccessoryView.frame = CGRect(x: 0, y: FTScreenHeight - FTDefaultAccessoryViewHeight, width: FTScreenWidth, height: FTDefaultAccessoryViewHeight)
                self.scrollToBottom(true)
                }, completion: { (finished) in
                    
            })
        }
    }
    
    //MARK: - dismissInputRecordView -
    
    fileprivate func dismissInputRecordView(){
        UIView.animate(withDuration: FTDefaultMessageDefaultAnimationDuration, animations: {
            self.messageRecordView.frame = CGRect(x: 0, y: FTScreenHeight, width: FTScreenWidth, height: FTDefaultAccessoryViewHeight)
        })
    }
    
    
    //MARK: - dismissInputAccessoryView -
    
    fileprivate func dismissInputAccessoryView(){
        UIView.animate(withDuration: FTDefaultMessageDefaultAnimationDuration, animations: {
            self.messageAccessoryView.frame = CGRect(x: 0, y: FTScreenHeight, width: FTScreenWidth, height: FTDefaultAccessoryViewHeight)
        })
    }
    
    //MARK: - UITableViewDelegate,UITableViewDataSource -
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        switch self.messageInputMode {
        case .accessory:
            self.ft_chatMessageInputViewShouldShowAccessoryView()
        case .record:
            self.ft_chatMessageInputViewShouldShowRecordView()
        default:
            break;
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return messageArray.count;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let messages : [FTChatMessageModel] = messageArray[section]
        return messages.count;
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let message = messageArray[section][0]
        let header = FTChatMessageHeader(frame: CGRect(x: 0,y: 0,width: tableView.frame.width,height: FTDefaultSectionHeight), senderModel: message.messageSender)
        header.headerViewDelegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return FTDefaultSectionHeight
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = messageArray[indexPath.section][indexPath.row]
        return FTChatMessageCell.getCellHeightWithMessage(message, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messageArray[indexPath.section][indexPath.row]
        
        let cell = FTChatMessageCell(style: UITableViewCellStyle.default, reuseIdentifier: FTDefaultMessageCellReuseIndentifier, theMessage: message, for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK: - FTChatMessageHeaderDelegate -
    
    func ft_chatMessageHeaderDidTappedOnIcon(_ messageSenderModel: FTChatMessageUserModel) {
        print("tapped at user icon : \(messageSenderModel.senderName!)")
        
    }
    
//    //MARK: - preferredInterfaceOrientationForPresentation -
//    
//    override var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
//        return UIInterfaceOrientation.portrait
//    }
//    
//    //MARK: - supportedInterfaceOrientations -
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return UIInterfaceOrientationMask.portrait
//    }
}
