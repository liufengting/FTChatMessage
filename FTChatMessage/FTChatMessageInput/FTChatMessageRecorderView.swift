//
//  FTChatMessageRecorderView.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/4/20.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

@objc protocol FTChatMessageRecorderViewDelegate : NSObjectProtocol {
    
    func ft_chatMessageRecordViewDidStartRecording()
    func ft_chatMessageRecordViewDidCancelRecording()
    func ft_chatMessageRecordViewDidStopRecording(_ duriation: TimeInterval, file: Data?)

}


class FTChatMessageRecorderView: UIView {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    var recorderTimer : Timer!
    var recorderDelegate : FTChatMessageRecorderViewDelegate!
 
    
    @IBAction func buttonTouchDown(_ sender: UIButton) {
        self.startRecording()
        if recorderDelegate != nil {
            recorderDelegate.ft_chatMessageRecordViewDidStartRecording()
        }
    }
    
    @IBAction func buttonTouchUpInside(_ sender: UIButton) {
        if recorderDelegate != nil {
            recorderDelegate.ft_chatMessageRecordViewDidStopRecording(10, file: nil)
        }
    }
    
    @IBAction func buttonTouchUpOutside(_ sender: UIButton) {
        if recorderDelegate != nil {
            recorderDelegate.ft_chatMessageRecordViewDidCancelRecording()
        }
    }

    
    @IBAction func buttonTouchCancel(_ sender: UIButton) {
       
        if recorderDelegate != nil {
            recorderDelegate.ft_chatMessageRecordViewDidCancelRecording()
        }
    }
    
    func startRecording() {

    }
    func stopRecording() {
        
        
        
    }
    
    
    
    
}
