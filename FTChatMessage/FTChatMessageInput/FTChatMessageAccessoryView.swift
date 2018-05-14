//
//  FTChatMessageAccessoryView.swift
//  FTChatMessage
//
//  Created by liufengting on 16/4/21.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit

//MARK: - FTChatMessageAccessoryViewDataSource -

@objc protocol FTChatMessageAccessoryViewDataSource : NSObjectProtocol {

    func ftChatMessageAccessoryViewModelArray() -> [FTChatMessageAccessoryViewModel]
}

//MARK: - FTChatMessageAccessoryViewDelegate -

@objc protocol FTChatMessageAccessoryViewDelegate : NSObjectProtocol {
    
    func ftChatMessageAccessoryViewDidTappedOnItemAtIndex(_ index : NSInteger)
    
}

//MARK: - FTChatMessageAccessoryView -

class FTChatMessageAccessoryView: UIView, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var accessoryDataSource : FTChatMessageAccessoryViewDataSource!
    var accessoryDelegate : FTChatMessageAccessoryViewDelegate!

    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.scrollsToTop = false
        scrollView.delegate = self
    }

    //MARK: - setupWithDataSource
    func setupWithDataSource(_ accessoryViewDataSource : FTChatMessageAccessoryViewDataSource , accessoryViewDelegate : FTChatMessageAccessoryViewDelegate) {
        
        self.setNeedsLayout()
        
        accessoryDataSource = accessoryViewDataSource
        accessoryDelegate = accessoryViewDelegate

        if self.accessoryDelegate == nil || self.accessoryDataSource == nil {
            NSException(name: NSExceptionName(rawValue: "Notice"), reason: "FTChatMessageAccessoryView. Missing accessoryDelegate or accessoryDelegate", userInfo: nil).raise()
            return
        }else{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(Double(0.1) * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                self.setupAccessoryView()
            }
        }
    }

    //MARK: - setupAccessoryView
    func setupAccessoryView() {
        
        self.layoutIfNeeded()
        
        for items in self.scrollView.subviews {
            if items.isKind(of: FTChatMessageAccessoryItem.classForCoder()) {
                items.removeFromSuperview()
            }
        }
        
        
        let modelArray = accessoryDataSource.ftChatMessageAccessoryViewModelArray()
        
        let totalCount = modelArray.count
        let totalPage = NSInteger(ceilf(Float(totalCount) / 8))
        self.pageControl.numberOfPages = totalPage
        self.scrollView.contentSize = CGSize(width: self.bounds.width * CGFloat(totalPage), height: self.bounds.height)

        let xMargin : CGFloat = (self.bounds.width - FTDefaultAccessoryViewLeftMargin*2 - FTDefaultAccessoryViewItemWidth*4)/3
        let yMargin : CGFloat = (self.bounds.height - FTDefaultAccessoryViewTopMargin - FTDefaultAccessoryViewBottomMargin - FTDefaultAccessoryViewItemHeight*2)
 
        for i in 0...totalCount-1 {
            let currentPage = i / 8
            let indexForCurrentPage = i % 8
            
            let x = self.bounds.width * CGFloat(currentPage) + FTDefaultAccessoryViewLeftMargin + (xMargin + FTDefaultAccessoryViewItemWidth)*CGFloat(i % 4)
            let y = FTDefaultAccessoryViewTopMargin + (yMargin + FTDefaultAccessoryViewItemHeight) * CGFloat(indexForCurrentPage / 4)

            let item : FTChatMessageAccessoryItem = Bundle.main.loadNibNamed("FTChatMessageAccessoryItem", owner: nil, options: nil)![0] as! FTChatMessageAccessoryItem
            item.frame  =  CGRect(x: x, y: y, width: FTDefaultAccessoryViewItemWidth, height: FTDefaultAccessoryViewItemHeight)
           
            let model = modelArray[i]

            item.setupWithAccessoryViewModel(model, index: i)
            item.addTarget(self, action: #selector(self.buttonItemTapped(_:)), for: UIControlEvents.touchUpInside)
            self.scrollView.addSubview(item)
        }
    }
    
    //MARK: - scrollViewDidEndDecelerating
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = lroundf(Float(scrollView.contentOffset.x/self.bounds.width))
        self.pageControl.currentPage = currentPage
    }

    
    //MARK: - buttonItemTapped
    @objc func buttonItemTapped(_ sender : UIButton) {
        if (accessoryDelegate != nil) {
            accessoryDelegate.ftChatMessageAccessoryViewDidTappedOnItemAtIndex(sender.tag)
        }
    }

}


