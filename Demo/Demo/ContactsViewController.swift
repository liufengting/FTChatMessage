//
//  ContactsViewController.swift
//  Demo
//
//  Created by liufengting on 2016/10/20.
//  Copyright © 2016年 LiuFengting. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var contactsArray : [NIMUser] = {
        return NIMSDK.shared().userManager.myFriends()!
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    
    


    
    /* UITableViewDelegate,UITableViewDataSource */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsArray.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ContactsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCellIdentifier") as! ContactsTableViewCell
        cell.setupWithUser(user: contactsArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.didTappedCell(at: indexPath)
    }

    func didTappedCell(at indexPath: IndexPath)  {
        
        let chat : ChatTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChatTableViewController") as! ChatTableViewController
        let user : NIMUser = contactsArray[indexPath.row]
        chat.session = NIMSession.init(user.userId!, type: NIMSessionType.P2P)
        self.navigationController?.pushViewController(chat, animated: true)
        
    }
    

}
