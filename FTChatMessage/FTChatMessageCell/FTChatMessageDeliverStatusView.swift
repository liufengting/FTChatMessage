//
//  FTChatMessageDeliverStatusView.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/9/12.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

class FTChatMessageDeliverStatusView: UIButton {
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activity.frame = self.bounds
        activity.hidesWhenStopped = true
        return activity
    }()
    
    func setupWithDeliverStatus(status : FTChatMessageDeliverStatus) {
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(activityIndicator)
        switch status {
        case .Sending:
            activityIndicator.startAnimating()
            self.setBackgroundImage(nil, forState: UIControlState.Normal)
        case .Succeeded:
            activityIndicator.stopAnimating()
            self.setBackgroundImage(nil, forState: UIControlState.Normal)
        case .failed:
            activityIndicator.stopAnimating()
            self.setBackgroundImage(UIImage(named: "FT_Error"), forState: UIControlState.Normal)
        }
    }
}
