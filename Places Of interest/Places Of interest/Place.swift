//
//  Place.swift
//  Places Of interest
//
//  Created by Trainer on 12/11/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import Foundation
import CoreData
import MapKit

let PlaceEntityName = "Place"
let PlaceAtrributeName = "placeName"
let PlaceAttributeDate = "dateVisited"

class Place: NSManagedObject, MKAnnotation {
    
    var shortDate:String {
        return NSDateFormatter.localizedStringFromDate(
            NSDate(timeIntervalSince1970: dateVisited),
            dateStyle: .ShortStyle,
            timeStyle: .NoStyle
        )
    }
    
    var longDate:String {
        return NSDateFormatter.localizedStringFromDate(
            NSDate(timeIntervalSince1970: dateVisited),
            dateStyle: .FullStyle,
            timeStyle: .NoStyle
        )
    }
    
    func deleteLocalImage() {
        if imagePath != nil && !imagePath!.isEmpty {
            let imagePath = NSHomeDirectory() + self.imagePath!
            do {
                try NSFileManager.defaultManager().removeItemAtPath(imagePath)
            } catch {}
        }
    }
    
    // MARK: - MKAnnotation
    
    var coordinate:CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: geoLat, longitude: geoLong)
    }
    
    var title:String? {
        return placeName
    }
    
    var subtitle:String? {
        return "Visited on \(shortDate)"
    }

}
