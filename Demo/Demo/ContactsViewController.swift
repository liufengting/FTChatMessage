//
//  ContactsViewController.swift
//  FTChatMessage
//
//  Created by liufengting on 2016/10/20.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    
    


    
    /* UITableViewDelegate,UITableViewDataSource */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.didTappedCell(at: indexPath)
    }

    func didTappedCell(at indexPath: IndexPath)  {
        
        let chat : ChatTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChatTableViewController") as! ChatTableViewController

        self.navigationController?.pushViewController(chat, animated: true)
        
    }
    

}
