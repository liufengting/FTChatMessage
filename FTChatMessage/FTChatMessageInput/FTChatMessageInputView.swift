//
//  FTChatMessageInputView.swift
//  FTChatMessage
//
//  Created by liufengting on 16/3/22.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit

enum FTChatMessageInputMode {
    case keyboard
    case record
    case accessory
    case none
}

protocol FTChatMessageInputViewDelegate {
    func ft_chatMessageInputViewShouldBeginEditing()
    func ft_chatMessageInputViewShouldEndEditing()
    func ft_chatMessageInputViewShouldUpdateHeight(_ desiredHeight : CGFloat)
    func ft_chatMessageInputViewShouldDoneWithText(_ textString : String)
    func ft_chatMessageInputViewShouldShowRecordView()
    func ft_chatMessageInputViewShouldShowAccessoryView()
}

class FTChatMessageInputView: UIToolbar, UITextViewDelegate{
    
    var inputDelegate : FTChatMessageInputViewDelegate?
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var accessoryButton: UIButton!
    @IBOutlet weak var inputTextViewTopMargin: NSLayoutConstraint! {
        didSet {
            self.layoutIfNeeded()
        }
    }
    @IBOutlet weak var inputTextViewBottomMargin: NSLayoutConstraint! {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    
    //MARK: - awakeFromNib -
    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputTextView.layer.cornerRadius = FTDefaultInputViewTextCornerRadius
        inputTextView.layer.borderColor = UIColor.lightGray.cgColor
        inputTextView.layer.borderWidth = 0.5
        inputTextView.textContainerInset = FTDefaultInputTextViewEdgeInset
        inputTextView.delegate = self
        
        self.bringSubview(toFront: self.inputTextView);
        self.bringSubview(toFront: self.recordButton);
        self.bringSubview(toFront: self.accessoryButton);
    }
    
    //MARK: - layoutSubviews -
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.inputTextView.attributedText.length > 0 {
            self.inputTextView.scrollRangeToVisible(NSMakeRange(self.inputTextView.attributedText.length - 1, 1))
        }
    }
    
    //MARK: - recordButtonTapped -
    @IBAction func recordButtonTapped(_ sender: UIButton) {
        if (inputDelegate != nil) {
            inputDelegate!.ft_chatMessageInputViewShouldShowRecordView()
        }
    }
    //MARK: - accessoryButtonTapped -
    @IBAction func accessoryButtonTapped(_ sender: UIButton) {
        if (inputDelegate != nil) {
            inputDelegate!.ft_chatMessageInputViewShouldShowAccessoryView()
        }
    }
    
    //MARK: - clearText -
    func clearText(){
        inputTextView.text = ""
        if (inputDelegate != nil) {
            inputDelegate!.ft_chatMessageInputViewShouldUpdateHeight(FTDefaultInputViewHeight)
        }
    }
    
    //MARK: - UITextViewDelegate -
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if (inputDelegate != nil) {
            inputDelegate!.ft_chatMessageInputViewShouldBeginEditing()
        }
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if (inputDelegate != nil) {
            inputDelegate!.ft_chatMessageInputViewShouldEndEditing()
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let text : NSAttributedString = textView.attributedText {
            let textRect = text.boundingRect(with: CGSize(width: textView.bounds.width - textView.textContainerInset.left - textView.textContainerInset.right, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin , .usesFontLeading, .truncatesLastVisibleLine], context: nil);
            
            if (inputDelegate != nil) {
                inputDelegate!.ft_chatMessageInputViewShouldUpdateHeight(min(max(textRect.height + inputTextViewTopMargin.constant + inputTextViewBottomMargin.constant + textView.textContainerInset.top + textView.textContainerInset.bottom, FTDefaultInputViewHeight), FTDefaultInputViewMaxHeight))
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            if (textView.text as NSString).length > 0 {
                if (inputDelegate != nil) {
                    inputDelegate!.ft_chatMessageInputViewShouldDoneWithText(textView.text)
                    self.clearText()
                }
            }
            return false
        }
        return true
    }
    
    
}

