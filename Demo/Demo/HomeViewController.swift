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

        let sender1 = FTChatMessageUserModel.init(id: "1", name: "LiuFengting", icon_url: "http://ww2.sinaimg.cn/large/6b24115ejw1f8iqy6hggij20jg0jg75z.jpg", extra_data: nil, isSelf: false)
        let sender2 = FTChatMessageUserModel.init(id: "2", name: "FTChatMessage", icon_url: "http://ww3.sinaimg.cn/mw600/83f596c9gw1f8ia359qygj20ia0bf794.jpg", extra_data: nil, isSelf: false)
        
        let message1 = FTChatMessageModel(data: "I just wrote some fake messages to make it look better. ", time: "", from: sender1, type: .text)
        let message2 = FTChatMessageModel(data: "It is still working in progress. It's a long road ahead. ", time: "", from: sender2, type: .text)
        
        messageArray = [message1,message2]
        
        
        
        if #available(iOS 9.0, *) {
            if (self.traitCollection.forceTouchCapability == UIForceTouchCapability.available){
                
            }
        } else {
            // Fallback on earlier versions
        }
    

    }
    
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
        let cell : ChatListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatListTableViewCellIndentifier") as! ChatListTableViewCell
        
        cell.message = messageArray[(indexPath as NSIndexPath).row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        self.performSegue(withIdentifier: "ToChat", sender: self)
        
//        let chat : FTChatMessageTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "DemoTableViewController") as! FTChatMessageTableViewController
//        self.navigationController?.pushViewController(chat, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
    }
    
    
//    1 - (UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
//    2      NSIndexPath *indexPath = [_tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
//    3　　　　//通过[previewingContext sourceView]拿到对应的cell；
//    4     NewVC *vc = [[FPHNewHouseDetailVC alloc] init];
//    5     newModel *model= [_tableView objectAtIndex:indexPath.row];
//    6     vc.pid = house.id;
//    7
//    8     NSLog(@"%@",location);
//    9     return vc;
//    10 }
//    //pop的代理方法，在此处可对将要进入的vc进行处理，比如隐藏tabBar；
//    11 - (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
//    12 {
//    13     viewControllerToCommit.hidesBottomBarWhenPushed = YES;
//    14     [self showViewController:viewControllerToCommit sender:self];
//    15 }
    
    
    
}

