//
//  FTChatMessageAccessoryView.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/4/21.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

//MARK: - FTChatMessageAccessoryViewDataSource -
@objc protocol FTChatMessageAccessoryViewDataSource : NSObjectProtocol {

    func ftChatMessageAccessoryViewItemCount() -> NSInteger
    func ftChatMessageAccessoryViewImageForItemAtIndex(index : NSInteger) -> UIImage
    func ftChatMessageAccessoryViewTitleForItemAtIndex(index : NSInteger) -> String
 
}

//MARK: - FTChatMessageAccessoryViewDelegate -
@objc protocol FTChatMessageAccessoryViewDelegate : NSObjectProtocol {
    
    func ftChatMessageAccessoryViewDidTappedOnItemAtIndex(index : NSInteger)
    
}
//MARK: - FTChatMessageAccessoryView -
class FTChatMessageAccessoryView: UIView, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var accessoryDataSource : FTChatMessageAccessoryViewDataSource!
    var accessoryDelegate : FTChatMessageAccessoryViewDelegate!

    //MARK: - awakeFromNib -
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.scrollsToTop = false
        scrollView.delegate = self
    }

    //MARK: - setupWithDataSource -
    func setupWithDataSource(accessoryViewDataSource : FTChatMessageAccessoryViewDataSource , accessoryViewDelegate : FTChatMessageAccessoryViewDelegate) {
        
        self.setNeedsLayout()
        
        accessoryDataSource = accessoryViewDataSource
        accessoryDelegate = accessoryViewDelegate

        if self.accessoryDelegate == nil || self.accessoryDataSource == nil {
            NSException(name: "Notice", reason: "FTChatMessageAccessoryView. Missing accessoryDelegate or accessoryDelegate", userInfo: nil).raise()
            return
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(Double(0.1) * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                self.setupAccessoryView()
            }
        }
    }

    //MARK: - setupAccessoryView -
    func setupAccessoryView() {


        let totalCount = accessoryDataSource.ftChatMessageAccessoryViewItemCount()
        let totalPage = NSInteger(ceilf(Float(totalCount) / 8))
        self.pageControl.numberOfPages = totalPage
        self.scrollView.contentSize = CGSizeMake(self.bounds.width * CGFloat(totalPage), self.bounds.height)

        let width : CGFloat = 60
        let height : CGFloat = width + 20
        let xMargin : CGFloat = (self.bounds.width - FTDefaultAccessoryViewTopMargin*2 - width*4)/3
        let yMargin : CGFloat = (self.bounds.height - FTDefaultAccessoryViewBottomMargin*2 - height*2)
        
 
        for i in 0...totalCount-1 {
            let currentPage = i / 8
            let indexForCurrentPage = i % 8
            
            let x = self.bounds.width * CGFloat(currentPage) + FTDefaultAccessoryViewTopMargin + (xMargin + width)*CGFloat(i % 4)
            let y = FTDefaultAccessoryViewBottomMargin + (yMargin + height) * CGFloat(indexForCurrentPage / 4)

            let item : FTChatMessageAccessoryItem = NSBundle.mainBundle().loadNibNamed("FTChatMessageAccessoryItem", owner: nil, options: nil)[0] as! FTChatMessageAccessoryItem
            item.frame  =  CGRectMake(x, y, width, height)
            
            let image = accessoryDataSource.ftChatMessageAccessoryViewImageForItemAtIndex(i)
            let string = accessoryDataSource.ftChatMessageAccessoryViewTitleForItemAtIndex(i)
            
            
            item.setupWithImage(image, name: string, index: i)
            item.addTarget(self, action: #selector(self.buttonItemTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.scrollView.addSubview(item)
        }
    }
    
    //MARK: - scrollViewDidEndDecelerating -
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currentPage = lroundf(Float(scrollView.contentOffset.x/self.bounds.width))
        self.pageControl.currentPage = currentPage
    }

    
    //MARK: - buttonItemTapped -
    func buttonItemTapped(sender : UIButton) {
        if (accessoryDelegate != nil) {
            accessoryDelegate.ftChatMessageAccessoryViewDidTappedOnItemAtIndex(sender.tag)
        }
    }

}
