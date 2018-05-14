//
//  ChatTableViewController.swift
//  FTChatMessage
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit
import FTIndicator

class ChatTableViewController: FTChatMessageTableViewController,FTChatMessageAccessoryViewDelegate,FTChatMessageAccessoryViewDataSource,FTChatMessageRecorderViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    let sender1 = FTChatMessageUserModel.init(id: "1", name: "Someone", icon_url: "http://ww3.sinaimg.cn/mw600/6cca1403jw1f3lrknzxczj20gj0g0t96.jpg", extra_data: nil, isSelf: false)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.addNewIncomingMessage)), animated: true)
        
        messageRecordView.recorderDelegate = self
        messageAccessoryView.setupWithDataSource(self , accessoryViewDelegate : self)
        
        chatMessageDataArray = self.loadDefaultMessages()

    }

    //MARK: - addNewIncomingMessage
    
    @objc func addNewIncomingMessage() {
        
        let message8 = FTChatMessageModel(data: "New Message added, try something else.", time: "4.12 22:42", from: sender1, type: .text)
        self.addNewMessage(message8)

    }

    func loadDefaultMessages() -> [FTChatMessageModel] {
        
        let message1 = FTChatMessageModel(data: "最近有点无聊，抽点时间写了这个聊天的UI框架。", time: "4.12 21:09:50", from: sender1, type: .text)
        let message2 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "4.12 21:09:51", from: sender1, type: .video)
        let message3 = FTChatMessageImageModel(data: "http://ww2.sinaimg.cn/mw600/6aa09e8fgw1f8iquoznw2j20dw0bv0uk.jpg", time: "4.12 21:09:52", from: sender1, type: .image)
        message3.imageUrl = "http://ww2.sinaimg.cn/mw600/6aa09e8fgw1f8iquoznw2j20dw0bv0uk.jpg"

        
        let message4 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "4.12 21:09:53", from: sender2, type: .text)
        let message5 = FTChatMessageModel(data: "文字背景不是图片，是用贝塞尔曲线画的，效率应该不高，后期优化", time: "4.12 21:09:53", from: sender2, type: .text)
        let message6 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "4.12 21:09:54", from: sender2, type: .text)
        let message8 = FTChatMessageImageModel(data: "http://wx3.sinaimg.cn/mw600/9e745efdly1fbmfs45minj20tg0xcq6v.jpg", time: "4.12 21:09:56", from: sender1, type: .image)
        message8.imageUrl = "http://wx3.sinaimg.cn/mw600/9e745efdly1fbmfs45minj20tg0xcq6v.jpg"

        
        let message7 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "4.12 21:09:55", from: sender1, type: .text)

        
        let array = [message1,message2,message3,message4,message5,message6,message8,message7]

        return array;
        
    }
    
    
    func getAccessoryItemTitleArray() -> [String] {
        return ["Alarm","Camera","Contacts","Mail","Messages","Music","Phone","Photos","Settings","VideoChat","Videos","Weather"]
    }

    
    //MARK: - FTChatMessageAccessoryViewDataSource
    
    func ftChatMessageAccessoryViewModelArray() -> [FTChatMessageAccessoryViewModel] {
        var array : [FTChatMessageAccessoryViewModel] = []
        let titleArray = self.getAccessoryItemTitleArray()
        for i in 0...titleArray.count-1 {
            let string = titleArray[i]
            array.append(FTChatMessageAccessoryViewModel.init(title: string, iconImage: UIImage(named: string)!))
        }
        return array
    }

    //MARK: - FTChatMessageAccessoryViewDelegate
    
    func ftChatMessageAccessoryViewDidTappedOnItemAtIndex(_ index: NSInteger) {
        
        if index == 0 {
            
            let imagePicker : UIImagePickerController = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: { 
                
            })
        }else{
            let string = "I just tapped at accessory view at index : \(index)"
            
            print(string)
            
            //        FTIndicator.showInfo(withMessage: string)
            
            let message2 = FTChatMessageModel(data: string, time: "4.12 21:09:51", from: sender2, type: .text)
            
            self.addNewMessage(message2)
        }
    }
    
    //MARK: - FTChatMessageRecorderViewDelegate
    
    func ft_chatMessageRecordViewDidStartRecording(){
        print("Start recording...")
        FTIndicator.showProgress(withMessage: "Recording...")
    }
    func ft_chatMessageRecordViewDidCancelRecording(){
        print("Recording canceled.")
        FTIndicator.dismissProgress()
    }
    func ft_chatMessageRecordViewDidStopRecording(_ duriation: TimeInterval, file: Data?){
        print("Recording ended!")
        FTIndicator.showSuccess(withMessage: "Record done.")
        
        let message2 = FTChatMessageModel(data: "", time: "4.12 21:09:51", from: sender2, type: .audio)

        self.addNewMessage(message2)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true) {
            
            let image : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let message2 = FTChatMessageImageModel(data: "", time: "4.12 21:09:51", from: self.sender2, type: .image)
            message2.image = image;
            self.addNewMessage(message2)
        }
    }
    
    func saveImageToDisk(image: UIImage) -> String {
        
        
        return ""
    }
    

}
