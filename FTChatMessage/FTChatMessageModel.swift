//
//  FTChatMessageModel.swift
//  FTChatMessage
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit

// MARK: - FTChatMessageDeliverStatus

enum FTChatMessageDeliverStatus {
    case sending
    case succeeded
    case failed
}

// MARK: - FTChatMessageModel

class FTChatMessageModel: NSObject {
    
    var targetId : String!
    var isUserSelf : Bool = false;
    var messageText : String!
    var messageTimeStamp : String!
    var messageType : FTChatMessageType = .text
    var messageSender : FTChatMessageUserModel!
    var messageExtraData : NSDictionary?
    var messageDeliverStatus : FTChatMessageDeliverStatus = FTChatMessageDeliverStatus.succeeded

    // MARK: - convenience init
    
    convenience init(data : String? ,time : String?, from : FTChatMessageUserModel, type : FTChatMessageType){
        self.init()
        self.transformMessage(data,time : time,extraDic: nil,from: from,type: type)
    }
    
    convenience init(data : String?,time : String?, extraDic : NSDictionary?, from : FTChatMessageUserModel, type : FTChatMessageType){
        self.init()
        self.transformMessage(data,time : time,extraDic: extraDic,from: from,type: type)
    }
    
    // MARK: - transformMessage
    
    fileprivate func transformMessage(_ data : String? ,time : String?, extraDic : NSDictionary?, from : FTChatMessageUserModel, type : FTChatMessageType){
        messageType = type
        messageText = data
        messageTimeStamp = time
        messageSender = from
        isUserSelf = from.isUserSelf
        if (extraDic != nil) {
            messageExtraData = extraDic;
        }
    }

}

class FTChatMessageImageModel: FTChatMessageModel {
    
    var image : UIImage!
    var imageUrl : String!

}
