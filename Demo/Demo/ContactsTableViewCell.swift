//
//  ContactsTableViewCell.swift
//  Demo
//
//  Created by liufengting on 2016/10/20.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

//    open func setupWithUser(user : NIMUser) {
//        if let iconUrl : String = user.userInfo?.avatarUrl {
//            self.iconImageView.kf.setImage(with: URL(string: iconUrl)!)
//        }
//        self.nameLabel.text = user.userInfo?.nickName
//    }
    
}
