//
//  FTChatMessageDeliverStatusView.swift
//  FTChatMessage
//
//  Created by liufengting on 16/9/12.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit

class FTChatMessageDeliverStatusView: UIButton {
    
    //MARK: - activityIndicator
    lazy var activityIndicator : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activity.frame = self.bounds
        activity.hidesWhenStopped = true
        return activity
    }()
    
    //MARK: - setupWithDeliverStatus
    func setupWithDeliverStatus(_ status : FTChatMessageDeliverStatus) {
        self.backgroundColor = UIColor.clear
        self.addSubview(activityIndicator)
        switch status {
        case .sending:
            activityIndicator.startAnimating()
            self.setBackgroundImage(nil, for: UIControlState())
        case .succeeded:
            activityIndicator.stopAnimating()
            self.setBackgroundImage(nil, for: UIControlState())
        case .failed:
            activityIndicator.stopAnimating()
            self.setBackgroundImage(UIImage(named: "FT_Error"), for: UIControlState())
        }
    }
}
