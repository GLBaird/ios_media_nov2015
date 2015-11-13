//
//  ViewController.swift
//  Circle Draw
//
//  Created by Trainer on 10/11/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ColorMixerViewControllerDelegate {
    
    // outlets
    @IBOutlet weak var circleView: CircleView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segue Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ColorMixer" {
            let mixer = segue.destinationViewController as! ColorMixerViewController
            mixer.mixedColor = circleView.circleColor
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
                mixer.delegate = self
            }
        }
    }
    
    // Unwind Segues
    
    @IBAction func closeColorMixer(segue:UIStoryboardSegue) {
        let mixer = segue.sourceViewController as! ColorMixerViewController
        circleView.circleColor = mixer.mixedColor!
    }
    
    // MARK: - Color Mixer Delegate Methods
    
    func colorMixerHasMixedNewColor(mixer: ColorMixerViewController, newColor: UIColor) {
        circleView.circleColor = newColor
    }

}

