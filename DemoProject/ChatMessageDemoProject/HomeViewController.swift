//
//  ViewController.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/2/15.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var chatListTableView: UITableView!
    var messageArray : [FTChatMessageModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let sender1 = FTChatMessageUserModel.init(id: "", name: "路人甲", icon_url: "", extra_data: nil, isSelf: false)
        let sender2 = FTChatMessageUserModel.init(id: "", name: "路人乙", icon_url: "", extra_data: nil, isSelf: false)
        
        let message1 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "", from: sender1, type: .Text)
        let message2 = FTChatMessageModel(data: "呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵", time: "", from: sender2, type: .Text)
        
        messageArray = [message1,message2]
        
        
        chatListTableView.rowHeight = 70
        chatListTableView.delegate = self
        chatListTableView.dataSource = self

    }
    
    /* UITableViewDelegate,UITableViewDataSource */
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : ChatListTableViewCell = tableView.dequeueReusableCellWithIdentifier("ChatListTableViewCellIndentifier") as! ChatListTableViewCell
        
        cell.message = messageArray[indexPath.row]
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let chat : FTChatMessageTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DemoTableViewController") as! FTChatMessageTableViewController
        self.navigationController?.pushViewController(chat, animated: true)
        
    }
    
}

