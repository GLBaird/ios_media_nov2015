//
//  CircleView.swift
//  Circle Draw
//
//  Created by Trainer on 11/11/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {

    lazy var circlePosition:CGPoint = {
        return CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
    }()
    
    @IBInspectable var circleColor:UIColor = UIColor.blueColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var circleDiameter:CGFloat = UIDevice.currentDevice().userInterfaceIdiom == .Phone ? 100.0 : 200
    
    var circleFrame:CGRect {
        return CGRect(
            x: circlePosition.x - circleDiameter/2.0,
            y: circlePosition.y - circleDiameter/2.0,
            width: circleDiameter,
            height: circleDiameter
        )
    }
    
    let shadowColor = UIColor(white: 0.0, alpha: 0.5).CGColor

    override func drawRect(rect: CGRect) {
        // Drawing code
        let ctx = UIGraphicsGetCurrentContext()
        circleColor.setFill()
        CGContextSetShadowWithColor(ctx, CGSize(width: 3.0, height: 3.0), 3.0, shadowColor)
        CGContextFillEllipseInRect(ctx, circleFrame)
    }
    
    // MARK: - Responder Methods
    
    var trackedTouches = Set<UITouch>()
   
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (trackedTouches.count == 0 && touches.count <= 2) || (trackedTouches.count == 1 && touches.count == 1) {
            trackedTouches.unionInPlace(touches)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if trackedTouches.count == 1 {
            // move
            circlePosition = trackedTouches.first!.locationInView(self)
        } else {
            // pinch
            let tracked = Array<UITouch>(trackedTouches)
            let finger1Pos = tracked[0].locationInView(self)
            let finger2Pos = tracked[1].locationInView(self)
            let diffX = finger1Pos.x - finger2Pos.x
            let diffY = finger1Pos.y - finger2Pos.y

            circleDiameter = sqrt( diffX*diffX + diffY*diffY )
            circlePosition.x = finger1Pos.x - diffX/2.0
            circlePosition.y = finger1Pos.y - diffY/2.0
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        trackedTouches.subtractInPlace(touches)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if touches != nil {
            touchesEnded(touches!, withEvent: event)
        }
    }

}
