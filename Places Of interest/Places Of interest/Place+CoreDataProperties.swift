//
//  Place+CoreDataProperties.swift
//  Places Of interest
//
//  Created by Trainer on 12/11/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Place {

    @NSManaged var placeName: String?
    @NSManaged var placeDescription: String?
    @NSManaged var imagePath: String?
    @NSManaged var geoLat: Double
    @NSManaged var geoLong: Double
    @NSManaged var dateVisited: NSTimeInterval

}
