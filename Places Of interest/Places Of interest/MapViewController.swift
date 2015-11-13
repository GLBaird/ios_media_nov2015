//
//  MapViewController.swift
//  Places Of interest
//
//  Created by Trainer on 13/11/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: ToolbarViewController {
    
    var place:Place?
    
    // outlet
    @IBOutlet weak var mapView:MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let place = self.place {
            mapView.addAnnotation(place)
            mapView.setRegion(
                MKCoordinateRegion(
                    center: place.coordinate,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.3,
                        longitudeDelta: 0.3
                    )
                ),
                animated: true
            )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action Methods
    
    @IBAction func changeMapType(sender:UIBarButtonItem) {
        mapView.mapType = MKMapType(rawValue: UInt(sender.tag))!
    }

}
