//
//  DetailViewController.swift
//  Places Of interest
//
//  Created by Trainer on 12/11/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit
import Social

class DetailViewController: ToolbarViewController {
    
    // Outlets
    @IBOutlet weak var placeDate: UILabel!
    @IBOutlet weak var placeDescription: UITextView!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet var mapViewController: MapViewController!
    
    var place:Place?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let place = self.place {
            navigationItem.title = place.placeName
            placeDate.text = place.longDate
            placeDescription.text = place.placeDescription
            if let path = place.imagePath {
                let fullPath = NSHomeDirectory() + path
                placeImage.image = UIImage(contentsOfFile: fullPath)
            }
            
            if mapViewController != nil {
                mapViewController.place = place
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let mapVC = segue.destinationViewController as! MapViewController
        mapVC.place = place
    }
    
    // MARK: - Actions
    
    @IBAction func postToSocial(sender: UIBarButtonItem) {
        let service = sender.tag == 0 ? SLServiceTypeFacebook : SLServiceTypeTwitter
        let post = SLComposeViewController(forServiceType: service)
        post.setInitialText("I visited \(place!.placeName!) on \(place?.shortDate)")
        post.addImage(placeImage.image)
        presentViewController(post, animated: true, completion: nil)
    }

}
