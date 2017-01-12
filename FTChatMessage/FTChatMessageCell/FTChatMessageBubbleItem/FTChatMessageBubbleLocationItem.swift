//
//  FTChatMessageBubbleLocationItem.swift
//  FTChatMessage
//
//  Created by liufengting on 16/5/7.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit
import MapKit

class FTChatMessageBubbleLocationItem: FTChatMessageBubbleItem {
    
    var mapView : MKMapView!
    
    convenience init(frame: CGRect, aMessage : FTChatMessageModel, for indexPath: IndexPath) {
        self.init(frame:frame)
        self.backgroundColor = UIColor.clear
        message = aMessage
        
        let mapRect = self.getMapSize(aMessage.isUserSelf)
        mapView = MKMapView(frame : mapRect)
        mapView.isScrollEnabled = false
        mapView.isUserInteractionEnabled = false
        mapView.layer.cornerRadius = FTDefaultMessageRoundCorner
        mapView.layer.borderColor = aMessage.messageSender.isUserSelf ? FTDefaultOutgoingColor.cgColor : FTDefaultIncomingColor.cgColor
        mapView.layer.borderWidth = 0.8
        self.addSubview(mapView)
        
        
        // setRegion
        let coordinate = CLLocationCoordinate2DMake(31.479461477978905, 120.38549624655187);
        let region = MKCoordinateRegionMakeWithDistance(coordinate, Double(mapRect.size.width), Double(mapRect.size.height))
        mapView.setRegion(region, animated: false)
        // addAnnotation
        let string = NSString(format: "%.1f,%.1f",coordinate.latitude,coordinate.longitude)
        let pin = MapPin.init(coordinate: coordinate, title: "My Location", subtitle: string as String)
        mapView.addAnnotation(pin as MKAnnotation)
        
    }
    
    
    fileprivate func getMapSize(_ isUserSelf : Bool) -> CGRect {
        let bubbleRect = CGRect(x: isUserSelf ? 0 : FTDefaultMessageBubbleAngleWidth, y: 0, width: self.bounds.size.width - FTDefaultMessageBubbleAngleWidth , height: self.bounds.size.height)
        return bubbleRect;
    }
    
    
    
}


class MapPin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
