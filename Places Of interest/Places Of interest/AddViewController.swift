//
//  AddViewController.swift
//  Places Of interest
//
//  Created by Trainer on 12/11/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class AddViewController: ToolbarViewController,
        UIActionSheetDelegate, UINavigationControllerDelegate,
        UIImagePickerControllerDelegate, CLLocationManagerDelegate {
    
    // outlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var imagePreview: UIImageView!
    
    private var locationManager:CLLocationManager! = CLLocationManager()
    private var location:CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserverForName(
            UIKeyboardWillShowNotification,
            object: nil,
            queue: nil,
            usingBlock: keyboardHasAppeared
        )
        
        if !CLLocationManager.locationServicesEnabled() {
            showMessage("Location Service Disabled", message: "This app needs to use the location service, please enable", button: "OK", viewController: self)
            navigationController?.popViewControllerAnimated(true)
            return
        }
        
        // listen for geo locations
        if #available(iOS 8.0, *) {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.delegate = self
        locationManager.distanceFilter = 20
        locationManager.startUpdatingLocation()
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Keyboard methods
    
    func keyboardHasAppeared(notice:NSNotification) {
        if (self.navigationItem.rightBarButtonItem == nil) {
            let done = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "removeKeyboard:")
            self.navigationItem.setRightBarButtonItem(done, animated: true)
        }
    }
    
    func removeKeyboard(sender:AnyObject) {
        nameTF.resignFirstResponder()
        descriptionTV.resignFirstResponder()
        navigationItem.setRightBarButtonItem(nil, animated: true)
    }
    
    // MARK: - Action Methods
    var cameraButton:UIBarButtonItem?
    
    @IBAction func pickImageSource(sender: AnyObject) {
        cameraButton = sender as? UIBarButtonItem
        
        if #available(iOS 8.0, *) {
            let choice = UIAlertController(title: "Pick image source:", message: "Choose where you want to capture the image from", preferredStyle: .ActionSheet)
            if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                choice.addAction(
                    UIAlertAction(title: "Camera", style: .Default, handler: createPickerFromSource)
                )
            }
            choice.addAction(
                UIAlertAction(title: "Photo Library", style: .Default, handler: createPickerFromSource)
            )
            choice.addAction(
                UIAlertAction(title: "Camera Roll", style: .Default, handler: createPickerFromSource)
            )
            choice.addAction(
                UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            )
            
            if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
                presentViewController(choice, animated: true, completion: nil)
            } else {
                let popover = UIPopoverController(contentViewController: choice)
                popover.presentPopoverFromBarButtonItem(sender as! UIBarButtonItem, permittedArrowDirections: .Any, animated: true)
            }
        } else {
            // Fallback on earlier versions
            let choice = UIActionSheet(
                title: "Pick image source:",
                delegate: self,
                cancelButtonTitle: "Cancel",
                destructiveButtonTitle: nil,
                otherButtonTitles: "Photo Library", "Camera", "Camera Roll"
            )
            if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
                choice.showInView(view)
            } else {
                choice.showFromBarButtonItem(sender as! UIBarButtonItem, animated: true)
            }
        }
        
    }
    
    @available(iOS 8.0, *)
    func createPickerFromSource(action:UIAlertAction) {
        let choice = action.title == "Photo Library" ? 0 : action.title == "Camera" ? 1 : 2
        getImageFromSource(UIImagePickerControllerSourceType(rawValue: choice)!)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        var choice = UIImagePickerControllerSourceType(rawValue: buttonIndex)!
        if choice == .Camera && !UIImagePickerController.isSourceTypeAvailable(.Camera) {
            choice = .PhotoLibrary
        }
        getImageFromSource(choice)
    }
    
    func getImageFromSource(source:UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.allowsEditing = true
        picker.delegate = self
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            presentViewController(picker, animated: true, completion: nil)
        } else {
            let popover = UIPopoverController(contentViewController: picker)
            popover.presentPopoverFromBarButtonItem(cameraButton!, permittedArrowDirections: .Any, animated: true)
        }
    }

    @IBAction func save(sender: AnyObject) {
        if nameTF.text == nil || (nameTF.text != nil && nameTF.text!.isEmpty) || descriptionTV.text.isEmpty {
            showMessage("Validation Error", message: "You need to enter a name and description", button: "OK", viewController: self)
            return
        }
        
        let place = NSEntityDescription.insertNewObjectForEntityForName(PlaceEntityName, inManagedObjectContext: AppDelegate.getContext()) as! Place
        place.placeName = nameTF.text
        place.placeDescription = descriptionTV.text
        
        if let location = self.location {
            place.geoLat = location.coordinate.latitude
            place.geoLong = location.coordinate.longitude
        }
        
        place.dateVisited = NSDate().timeIntervalSince1970
        
        if let image = imagePreview.image, imageData = UIImageJPEGRepresentation(image, 1.0)  {
            let filepath = "/Documents/image-\(place.dateVisited).jpg"
            let fullPath = NSHomeDirectory() + filepath
            if imageData.writeToFile(fullPath, atomically: true) {
                place.imagePath = filepath
            } else {
                showMessage("Image Error", message: "Couldn't save image data!", button: "Oops", viewController: self)
            }
        }
        
        AppDelegate.getDelegate().saveContext()
        
        nameTF.text = ""
        descriptionTV.text = ""
        imagePreview.image = nil
    }
    
    // MARK: - Image Picker Delegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        imagePreview.image = info[UIImagePickerControllerEditedImage] as? UIImage
    }
    
    // MARK: - Core Location Delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        print("Found location: \(location!.description)")
    }
}



