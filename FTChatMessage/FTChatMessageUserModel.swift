//
//  FTChatMessageUserModel.swift
//  FTChatMessage
//
//  Created by liufengting on 16/8/21.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit

class FTChatMessageUserModel : NSObject{
    
    var isUserSelf : Bool = false;
    var senderId : String!
    var senderName : String!
    var senderIconUrl : String!
    var senderExtraData : NSDictionary?
    
    // MARK: - convenience init
    convenience init(id : String? ,name : String?, icon_url : String?, extra_data : NSDictionary?, isSelf : Bool){
        self.init()
        senderId = id
        senderName = name
        senderIconUrl = icon_url
        senderExtraData = extra_data
        isUserSelf = isSelf
    }
}
