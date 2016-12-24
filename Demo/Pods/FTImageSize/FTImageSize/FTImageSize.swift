//
//  FTImageSize.swift
//  FTImageSize
//
//  Created by liufengting on 02/12/2016.
//  Copyright © 2016 LiuFengting (https://github.com/liufengting) . All rights reserved.
//

import UIKit

public extension FTImageSize {
    
    /// get image size, with perfered width
    ///
    /// - Parameters:
    ///   - imageURL: image url
    ///   - perferdWidth: perferd Width
    /// - Returns: image size
    public static func getImageSizeFromImageURL(_ imageURL:String, perferdWidth: CGFloat) -> CGSize {
        return self.convertSize(size: self.getImageSize(imageURL), perferdWidth: perferdWidth, maxHeight: CGFloat(MAXFLOAT))
    }
    
    /// get image size, with perfered width and max height
    ///
    /// - Parameters:
    ///   - imageURL: image url
    ///   - perferdWidth: perferd Width
    ///   - maxHeight: max height
    /// - Returns: image size
    public static func getImageSizeFromImageURL(_ imageURL:String, perferdWidth: CGFloat, maxHeight: CGFloat) -> CGSize {
        return self.convertSize(size: self.getImageSize(imageURL), perferdWidth: perferdWidth, maxHeight: maxHeight)
    }
    
    /// private function: convertImageSize
    ///
    /// - Parameters:
    ///   - size: original image size
    ///   - perferdWidth: perfered width
    ///   - maxHeight: max height
    /// - Returns: image size
    fileprivate static func convertSize(size :CGSize, perferdWidth: CGFloat, maxHeight: CGFloat) -> CGSize {
        var convertedSize : CGSize = CGSize.zero
        if size.width == 0 || size.height == 0 {
            return CGSize(width: perferdWidth, height: perferdWidth)
        }
        convertedSize.width = perferdWidth
        convertedSize.height = min((size.height * perferdWidth) / size.width, maxHeight)
        return convertedSize
    }
}

public class FTImageSize: NSObject {
    
    
    /// get remote image original size with image url
    ///
    /// - Parameter imageURL: image url
    /// - Returns: image original size
    public class func getImageSize(_ imageURL:String) ->CGSize {
        var URL:Foundation.URL?
        if imageURL.isKind(of: NSString.self) {
            URL = Foundation.URL(string: imageURL)
        }
        if URL == nil {
            return  CGSize.zero
        }
        let request = NSMutableURLRequest(url: URL!)
        let pathExtendsion = URL?.pathExtension.lowercased()
        
        var size = CGSize.zero
        if pathExtendsion == "png" {
            size = self.getPNGImageSize(request)
        } else if pathExtendsion == "gif" {
            size = self.getGIFImageSize(request)
        } else {
            size = self.getJPGImageSize(request)
        }
        if CGSize.zero.equalTo(size) {
            guard let data = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil) else {
                return size
            }
            let image = UIImage(data: data)
            if image != nil {
                size = (image?.size)!
            }
        }
        return size
    }
    
    
    /// private function: getPNGImageSize
    ///
    /// - Parameter request: image request
    /// - Returns: image original size
    fileprivate class func getPNGImageSize(_ request:NSMutableURLRequest) -> CGSize {
        request.setValue("bytes=16-23", forHTTPHeaderField: "Range")
        guard let data = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil) else {
            return CGSize.zero
        }
        if data.count == 8 {
            var w1:Int = 0
            var w2:Int = 0
            var w3:Int = 0
            var w4:Int = 0
            (data as NSData).getBytes(&w1, range: NSMakeRange(0, 1))
            (data as NSData).getBytes(&w2, range: NSMakeRange(1, 1))
            (data as NSData).getBytes(&w3, range: NSMakeRange(2, 1))
            (data as NSData).getBytes(&w4, range: NSMakeRange(3, 1))
            
            let w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4
            var h1:Int = 0
            var h2:Int = 0
            var h3:Int = 0
            var h4:Int = 0
            (data as NSData).getBytes(&h1, range: NSMakeRange(4, 1))
            (data as NSData).getBytes(&h2, range: NSMakeRange(5, 1))
            (data as NSData).getBytes(&h3, range: NSMakeRange(6, 1))
            (data as NSData).getBytes(&h4, range: NSMakeRange(7, 1))
            let h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4
            
            return CGSize(width: CGFloat(w), height: CGFloat(h));
        }
        return CGSize.zero;
    }
    
    /// private function: getGIFImageSize
    ///
    /// - Parameter request: image request
    /// - Returns: image original size
    fileprivate class func getGIFImageSize(_ request:NSMutableURLRequest) -> CGSize {
        request.setValue("bytes=6-9", forHTTPHeaderField: "Range")
        guard let data = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil) else {
            return CGSize.zero
        }
        if data.count == 4 {
            var w1:Int = 0
            var w2:Int = 0
            
            (data as NSData).getBytes(&w1, range: NSMakeRange(0, 1))
            (data as NSData).getBytes(&w2, range: NSMakeRange(1, 1))
            
            let w = w1 + (w2 << 8)
            var h1:Int = 0
            var h2:Int = 0
            
            (data as NSData).getBytes(&h1, range: NSMakeRange(2, 1))
            (data as NSData).getBytes(&h2, range: NSMakeRange(3, 1))
            let h = h1 + (h2 << 8)
            
            return CGSize(width: CGFloat(w), height: CGFloat(h));
        }
        return CGSize.zero;
    }
    
    /// private function: getJPGImageSize
    ///
    /// - Parameter request: image request
    /// - Returns: image original size
    fileprivate class func getJPGImageSize(_ request:NSMutableURLRequest) -> CGSize {
        request.setValue("bytes=0-209", forHTTPHeaderField: "Range")
        guard let data = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil) else {
            return CGSize.zero
        }
        if data.count <= 0x58 {
            return CGSize.zero
            
        }
        if data.count < 210 {
            var w1:Int = 0
            var w2:Int = 0
            
            (data as NSData).getBytes(&w1, range: NSMakeRange(0x60, 0x1))
            (data as NSData).getBytes(&w2, range: NSMakeRange(0x61, 0x1))
            
            let w = (w1 << 8) + w2
            var h1:Int = 0
            var h2:Int = 0
            
            (data as NSData).getBytes(&h1, range: NSMakeRange(0x5e, 0x1))
            (data as NSData).getBytes(&h2, range: NSMakeRange(0x5f, 0x1))
            let h = (h1 << 8) + h2
            
            return CGSize(width: CGFloat(w), height: CGFloat(h));
            
        } else {
            var word = 0x0
            (data as NSData).getBytes(&word, range: NSMakeRange(0x15, 0x1))
            if word == 0xdb {
                (data as NSData).getBytes(&word, range: NSMakeRange(0x5a, 0x1))
                if word == 0xdb {
                    var w1:Int = 0
                    var w2:Int = 0
                    
                    (data as NSData).getBytes(&w1, range: NSMakeRange(0xa5, 0x1))
                    (data as NSData).getBytes(&w2, range: NSMakeRange(0xa6, 0x1))
                    
                    let w = (w1 << 8) + w2
                    var h1:Int = 0
                    var h2:Int = 0
                    
                    (data as NSData).getBytes(&h1, range: NSMakeRange(0xa3, 0x1))
                    (data as NSData).getBytes(&h2, range: NSMakeRange(0xa4, 0x1))
                    let h = (h1 << 8) + h2
                    
                    return CGSize(width: CGFloat(w), height: CGFloat(h));
                } else {
                    var w1:Int = 0
                    var w2:Int = 0
                    
                    (data as NSData).getBytes(&w1, range: NSMakeRange(0x60, 0x1))
                    (data as NSData).getBytes(&w2, range: NSMakeRange(0x61, 0x1))
                    
                    let w = (w1 << 8) + w2
                    var h1:Int = 0
                    var h2:Int = 0
                    
                    (data as NSData).getBytes(&h1, range: NSMakeRange(0x5e, 0x1))
                    (data as NSData).getBytes(&h2, range: NSMakeRange(0x5f, 0x1))
                    let h = (h1 << 8) + h2
                    
                    return CGSize(width: CGFloat(w), height: CGFloat(h));
                }
            } else {
                return CGSize.zero;
            }
        }
    }
}
