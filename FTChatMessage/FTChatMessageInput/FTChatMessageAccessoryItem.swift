//
//  FTChatMessageAccessoryItem.swift
//  FTChatMessage
//
//  Created by liufengting on 16/9/22.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit

//MARK: - FTChatMessageAccessoryItem -

class FTChatMessageAccessoryItem : UIButton {
    
    @IBOutlet weak var accessoryImageView: UIImageView!
    @IBOutlet weak var accessoryNameLabel: UILabel!
    
    func setupWithAccessoryViewModel(_ viewModel : FTChatMessageAccessoryViewModel, index : NSInteger) {
        
        self.tag = index
        self.accessoryImageView.image = viewModel.iconImage
        self.accessoryNameLabel.text = viewModel.title
    }
    
}

//MARK: - FTChatMessageAccessoryViewModel -

class FTChatMessageAccessoryViewModel: NSObject {
    var title : String = ""
    var iconImage : UIImage? = nil
    
    convenience init(title: String, iconImage: UIImage?) {
        self.init()
        self.title = title
        self.iconImage = iconImage
    }
}
