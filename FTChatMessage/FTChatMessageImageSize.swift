//
//  FTChatMessageImageSize.swift
//  ChatMessageDemoProject
//
//  Created by liufengting on 16/8/19.
//  Copyright © 2016年 liufengting ( https://github.com/liufengting ). All rights reserved.
//

import UIKit

class FTChatMessageImageSize: NSObject {
    
    // MARK: - getImageSize
    internal class func getImageSize(imageURL:String) ->CGSize {
        var URL:NSURL?
        if imageURL.isKindOfClass(NSString) {
            URL = NSURL(string: imageURL)
        }
        if URL == nil {
            return  CGSizeZero
        }
        let request = NSMutableURLRequest(URL: URL!)
        let pathExtendsion = URL?.pathExtension?.lowercaseString
        
        var size = CGSizeZero
        if pathExtendsion == "png" {
            size = self.getPNGImageSize(request)
        } else if pathExtendsion == "gif" {
            size = self.getGIFImageSize(request)
        } else {
            size = self.getJPGImageSize(request)
        }
        if CGSizeEqualToSize(CGSizeZero, size) {
            guard let data = try? NSURLConnection.sendSynchronousRequest(request, returningResponse: nil) else {
                return size
            }
            let image = UIImage(data: data)
            if image != nil {
                size = (image?.size)!
            }
        }
        return size
    }
    
    // MARK: - getPNGImageSize
    private class func getPNGImageSize(request:NSMutableURLRequest) -> CGSize {
        request.setValue("bytes=16-23", forHTTPHeaderField: "Range")
        guard let data = try? NSURLConnection.sendSynchronousRequest(request, returningResponse: nil) else {
            return CGSizeZero
        }
        if data.length == 8 {
            var w1:Int = 0
            var w2:Int = 0
            var w3:Int = 0
            var w4:Int = 0
            data.getBytes(&w1, range: NSMakeRange(0, 1))
            data.getBytes(&w2, range: NSMakeRange(1, 1))
            data.getBytes(&w3, range: NSMakeRange(2, 1))
            data.getBytes(&w4, range: NSMakeRange(3, 1))
            
            let w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4
            var h1:Int = 0
            var h2:Int = 0
            var h3:Int = 0
            var h4:Int = 0
            data.getBytes(&h1, range: NSMakeRange(4, 1))
            data.getBytes(&h2, range: NSMakeRange(5, 1))
            data.getBytes(&h3, range: NSMakeRange(6, 1))
            data.getBytes(&h4, range: NSMakeRange(7, 1))
            let h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4
            
            return CGSizeMake(CGFloat(w), CGFloat(h));
        }
        return CGSizeZero;
    }
   
    // MARK: - getGIFImageSize
    private class func getGIFImageSize(request:NSMutableURLRequest) -> CGSize {
        request.setValue("bytes=6-9", forHTTPHeaderField: "Range")
        guard let data = try? NSURLConnection.sendSynchronousRequest(request, returningResponse: nil) else {
            return CGSizeZero
        }
        if data.length == 4 {
            var w1:Int = 0
            var w2:Int = 0
            
            data.getBytes(&w1, range: NSMakeRange(0, 1))
            data.getBytes(&w2, range: NSMakeRange(1, 1))
            
            let w = w1 + (w2 << 8)
            var h1:Int = 0
            var h2:Int = 0
            
            data.getBytes(&h1, range: NSMakeRange(2, 1))
            data.getBytes(&h2, range: NSMakeRange(3, 1))
            let h = h1 + (h2 << 8)
            
            return CGSizeMake(CGFloat(w), CGFloat(h));
        }
        return CGSizeZero;
    }
    
    // MARK: - getJPGImageSize
    private class func getJPGImageSize(request:NSMutableURLRequest) -> CGSize {
        request.setValue("bytes=0-209", forHTTPHeaderField: "Range")
        guard let data = try? NSURLConnection.sendSynchronousRequest(request, returningResponse: nil) else {
            return CGSizeZero
        }
        if data.length <= 0x58 {
            return CGSizeZero
            
        }
        if data.length < 210 {
            var w1:Int = 0
            var w2:Int = 0
            
            data.getBytes(&w1, range: NSMakeRange(0x60, 0x1))
            data.getBytes(&w2, range: NSMakeRange(0x61, 0x1))
            
            let w = (w1 << 8) + w2
            var h1:Int = 0
            var h2:Int = 0
            
            data.getBytes(&h1, range: NSMakeRange(0x5e, 0x1))
            data.getBytes(&h2, range: NSMakeRange(0x5f, 0x1))
            let h = (h1 << 8) + h2
            
            return CGSizeMake(CGFloat(w), CGFloat(h));
            
        } else {
            var word = 0x0
            data.getBytes(&word, range: NSMakeRange(0x15, 0x1))
            if word == 0xdb {
                data.getBytes(&word, range: NSMakeRange(0x5a, 0x1))
                if word == 0xdb {
                    var w1:Int = 0
                    var w2:Int = 0
                    
                    data.getBytes(&w1, range: NSMakeRange(0xa5, 0x1))
                    data.getBytes(&w2, range: NSMakeRange(0xa6, 0x1))
                    
                    let w = (w1 << 8) + w2
                    var h1:Int = 0
                    var h2:Int = 0
                    
                    data.getBytes(&h1, range: NSMakeRange(0xa3, 0x1))
                    data.getBytes(&h2, range: NSMakeRange(0xa4, 0x1))
                    let h = (h1 << 8) + h2
                    
                    return CGSizeMake(CGFloat(w), CGFloat(h));
                } else {
                    var w1:Int = 0
                    var w2:Int = 0
                    
                    data.getBytes(&w1, range: NSMakeRange(0x60, 0x1))
                    data.getBytes(&w2, range: NSMakeRange(0x61, 0x1))
                    
                    let w = (w1 << 8) + w2
                    var h1:Int = 0
                    var h2:Int = 0
                    
                    data.getBytes(&h1, range: NSMakeRange(0x5e, 0x1))
                    data.getBytes(&h2, range: NSMakeRange(0x5f, 0x1))
                    let h = (h1 << 8) + h2
                    
                    return CGSizeMake(CGFloat(w), CGFloat(h));
                }
            } else {
                return CGSizeZero;
            }
        }
    }
}
