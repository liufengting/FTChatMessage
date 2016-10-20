//
//  ViewController.swift
//  FTChatMessage
//
//  Created by liufengting on 16/2/15.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit
import FTIndicator

class ChatRoomViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var chatListTableView: UITableView!
    var messageArray : [FTChatMessageModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        self.loadData()

        //add a friend
//        self.searchAndADD(user: "Test05")
        // change icon
//        self.setmyIconUrl(url: "..")
        
    }
    
    func loadData() {
        let sender1 = FTChatMessageUserModel.init(id: "1", name: "LiuFengting", icon_url: "http://ww2.sinaimg.cn/large/6b24115ejw1f8iqy6hggij20jg0jg75z.jpg", extra_data: nil, isSelf: false)
        let sender2 = FTChatMessageUserModel.init(id: "2", name: "FTChatMessage", icon_url: "http://ww3.sinaimg.cn/mw600/83f596c9gw1f8ia359qygj20ia0bf794.jpg", extra_data: nil, isSelf: false)
        
        let message1 = FTChatMessageModel(data: "I just wrote some fake messages to make it look better. ", time: "", from: sender1, type: .text)
        let message2 = FTChatMessageModel(data: "It is still working in progress. It's a long road ahead. ", time: "", from: sender2, type: .text)
        
        messageArray = [message1,message2]
        
        
    }
    

    @IBAction func addItemAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "ChooseContactsToChat", sender: self)
    }
    
    
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
    
    
    
    
    /* UITableViewDelegate,UITableViewDataSource */
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ChatRoomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatRoomTableViewCellIndentifier") as! ChatRoomTableViewCell
        
        cell.message = messageArray[(indexPath as NSIndexPath).row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
    }
    
    
}

