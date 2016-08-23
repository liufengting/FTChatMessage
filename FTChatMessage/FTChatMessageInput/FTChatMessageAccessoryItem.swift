//
//  FTChatMessageAccessoryItem.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/8/21.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

class FTChatMessageAccessoryItem : UIButton {
    
    @IBOutlet weak var accessoryImageView: UIImageView!
    @IBOutlet weak var accessoryNameLabel: UILabel!
    
    func setupWithImage(image : UIImage?, name:String , index : NSInteger) {
        
        self.tag = index
        self.accessoryImageView.image = image
        self.accessoryNameLabel.text = name
        
    }
    
}
