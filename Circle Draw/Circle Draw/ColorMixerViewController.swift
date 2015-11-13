//
//  ColorMixerViewController.swift
//  Circle Draw
//
//  Created by Trainer on 11/11/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ColorMixerViewController: UIViewController {
    
    var mixedColor:UIColor?
    
    var delegate:ColorMixerViewControllerDelegate?
    
    // outlets
    @IBOutlet weak var sliderRed:UISlider!
    @IBOutlet weak var sliderGreen:UISlider!
    @IBOutlet weak var sliderBlue:UISlider!
    @IBOutlet weak var colorPreview:UIView!
    @IBOutlet weak var titleInfo: UINavigationItem!
    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var itemsToRemove: [AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let color = mixedColor {
            colorPreview.backgroundColor = color
            var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0
            color.getRed(&r, green: &g, blue: &b, alpha: nil)
            sliderRed.value = Float(r)
            sliderGreen.value = Float(g)
            sliderBlue.value = Float(b)
        }
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            titleInfo.rightBarButtonItem = nil
            titleHeightConstraint.constant = 44
            for item in itemsToRemove {
                if let v = item as? UIView {
                    v.removeFromSuperview()
                } else if let c = item as? NSLayoutConstraint {
                    view.removeConstraint(c)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Action methods
    
    @IBAction func sliderValueHasChanged(sender:UISlider) {
        mixedColor = UIColor(
            red: CGFloat(sliderRed.value),
            green: CGFloat(sliderGreen.value),
            blue: CGFloat(sliderBlue.value),
            alpha: 1.0
        )
        colorPreview.backgroundColor = mixedColor
        delegate?.colorMixerHasMixedNewColor(self, newColor: mixedColor!)
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            ColorMixerHasMixedNewColorNotification,
            object: self,
            userInfo: [ColorMixerNewColorKey: mixedColor!]
        )
    }

}

//  Keys for notifications
let ColorMixerHasMixedNewColorNotification = "com.leonbaird.circlecolor.newcolor"
let ColorMixerNewColorKey = "NewColor"

// MARK: - Protocols

protocol ColorMixerViewControllerDelegate {
    
    func colorMixerHasMixedNewColor(mixer:ColorMixerViewController, newColor:UIColor)
    
}
