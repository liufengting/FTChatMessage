//
//  NSString+NTES.m
//  NIMDemo
//
//  Created by chris on 15/2/12.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NSString+NTES.h"
#import <CommonCrypto/CommonDigest.h>
#import <NIMSDK.h>

@implementation NSString (NTES)

- (NSString *)MD5String {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)tokenByPassword
{
    //demo直接使用username作为account，md5(password)作为token
    //接入应用开发需要根据自己的实际情况来获取 account和token
    return [[NIMSDK sharedSDK] isUsingDemoAppKey] ? [self MD5String] : self;
}


@end

//add a friend
//        self.searchAndADD(user: "Test05")
// change icon
//        self.setmyIconUrl(url: "..")


//    func setmyIconUrl(url:String) {
//        let number : NSNumber = NSNumber(value: NIMUserInfoUpdateTag.avatar.rawValue)
//        NIMSDK.shared().userManager.updateMyUserInfo([number:url]) { (error) in
//            if  error == nil {
//                FTIndicator.showSuccess(withMessage: "Update icon succeeded.")
//            }else{
//                FTIndicator.showError(withMessage: "Update icon failed.");
//            }
//        }
//    }
//
//
//
//    func searchAndADD(user:String) {
//        NIMSDK.shared().userManager.fetchUserInfos([user]) { (userArray, error) in
//            if ((userArray?.count) != nil){
//                print("\(userArray)")
//                if let user : NIMUser = userArray?[0] {
//                    self.addContacts(userId: user.userId!)
//                }
//
//            }else{
//                print("no");
//            }
//        }
//    }
//
//    func addContacts(userId: String) {
//        let request : NIMUserRequest = NIMUserRequest()
//        request.userId = userId
//        request.operation = NIMUserOperation.add
//        NIMSDK.shared().userManager .requestFriend(request) { (error) in
//            if  error == nil {
//                FTIndicator.showSuccess(withMessage: "Add friend succeeded.")
//            }else{
//                FTIndicator.showError(withMessage: "Add friend failed.");
//            }
//        }
//    }
