//
//  PlaceListTableViewController.swift
//  Places Of interest
//
//  Created by Trainer on 12/11/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit
import CoreData

class PlaceListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    lazy var places:NSFetchedResultsController! = {
        let request = NSFetchRequest(entityName: PlaceEntityName)
        request.sortDescriptors = [
            NSSortDescriptor(key: PlaceAtrributeName, ascending: true),
            NSSortDescriptor(key: PlaceAttributeDate, ascending: false)
        ]
        
        let controller = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: AppDelegate.getContext(),
            sectionNameKeyPath: nil,
            cacheName: "Places"
        )
        
        do {
            try controller.performFetch()
        } catch {
            showMessage("DB Error", message: "Can't load data", button: "OK", viewController: self)
            return nil
        }
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            controller.delegate = self
        }
        
        return controller

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        places = nil
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if places != nil && places.sections != nil {
            return places.sections!.count
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.sections![section].numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell", forIndexPath: indexPath) as! PlaceCell
        let place = places.objectAtIndexPath(indexPath) as! Place

        // Configure the cell...
        cell.placeName.text = place.placeName
        cell.placeDate.text = place.shortDate
        if let path = place.imagePath {
            let fullPath = NSHomeDirectory() + path
            cell.placeImage.image = UIImage(contentsOfFile: fullPath)
            cell.placeImage.contentMode = .ScaleAspectFill
            cell.placeImage.backgroundColor = nil
        } else {
            cell.placeImage.backgroundColor = UIColor.lightGrayColor()
            cell.placeImage.image = UIImage(named: "About")
            cell.placeImage.contentMode = .Center
        }

        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let place = places.objectAtIndexPath(indexPath) as! Place
            place.deleteLocalImage()
            AppDelegate.getContext().deleteObject(place)
            do { try places.performFetch() } catch {}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let place = places.objectAtIndexPath(tableView.indexPathForSelectedRow!) as! Place
        let detailVC = segue.destinationViewController as! DetailViewController
        detailVC.place = place
    }
    
    // MARK: - NSFetchedResults Controller Delegate Methods
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        do { try controller.performFetch() } catch {}
        tableView.reloadData()
    }
    

}
