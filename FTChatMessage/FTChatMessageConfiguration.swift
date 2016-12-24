//
//  FTChatMessageConfiguration.swift
//  Demo
//
//  Created by liufengting on 16/9/27.
//  Copyright © 2016年 LiuFengting. All rights reserved.
//

import UIKit

class FTChatMessageConfiguration: NSObject {

    public static var shared : FTChatMessageConfiguration {
        struct Static {
            static let instance : FTChatMessageConfiguration = FTChatMessageConfiguration()
        }
        return Static.instance
    }


    override init() {
        
    }
    
    
    
    
}
