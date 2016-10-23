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
    var recentChats : [NIMRecentSession] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        self.chatListTableView.addSubview(refreshControl);

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.reloadConversations()
    }
    
    func reloadConversations() {
        self.recentChats = NIMSDK.shared().conversationManager.allRecentSessions()!
        self.chatListTableView.reloadData()
    }
    
    
    
    lazy var refreshControl : UIRefreshControl = {
        let refresh : UIRefreshControl = UIRefreshControl.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 60))
        refresh.addTarget(self, action: #selector(self.onPullToRefreshTriggered), for: UIControlEvents.valueChanged)
        return refresh;
    }()

    @objc func onPullToRefreshTriggered() {
        self.reloadConversations()
        DispatchQueue.main.asyncAfter( deadline: DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            self.refreshControl.endRefreshing()
        }
    }


    @IBAction func addItemAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "ChooseContactsToChat", sender: self)
    }
    
    /* UITableViewDelegate,UITableViewDataSource */
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recentChats.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ChatRoomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatRoomTableViewCellIndentifier") as! ChatRoomTableViewCell
        cell.conversation = self.recentChats[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.didTappedCell(at: indexPath)
    }
    
    func didTappedCell(at indexPath: IndexPath)  {
    
        let chat : ChatTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChatTableViewController") as! ChatTableViewController
        chat.session = (self.recentChats[indexPath.row]).session
        self.navigationController?.pushViewController(chat, animated: true)
        
    }
    

}

