//
//  DrawView.swift
//  Unseal
//
//  Created by synaptics on 7/12/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation

import UIKit

// special view to draw the circles
class DrawView: UIView {
    
    override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }
    
    private var path: CGPath?
    private var fitResult: LineResult?
    private var isShape = false
    
    var drawDebug = true // set to true show additional information about the fit
    
    func updateFit(fit: LineResult?, madeShape: Bool) {
        fitResult = fit
        isShape = madeShape
        setNeedsDisplay()
    }
    
    func updatePath(p: CGPath?) {
        path = p
        setNeedsDisplay()
    }
    
    func clear() {
        updateFit(nil, madeShape: false)
        updatePath(nil)
    }
    
    override func drawRect(rect: CGRect) {
        
        if isShape { // draw a thick yellow line for the user touch path
            let context = UIGraphicsGetCurrentContext()
            CGContextAddPath(context, path)
            CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
            CGContextSetLineWidth(context, 10)
            CGContextSetLineCap(context, CGLineCap.Round)
            CGContextSetLineJoin(context, CGLineJoin.Round)
            CGContextStrokePath(context)
            return
        }
        
        if let path = path { // draw a thick yellow line for the user touch path
            let context = UIGraphicsGetCurrentContext()
            CGContextAddPath(context, path)
            CGContextSetStrokeColorWithColor(context, UIColor.yellowColor().CGColor)
            CGContextSetLineWidth(context, 10)
            CGContextSetLineCap(context, CGLineCap.Round)
            CGContextSetLineJoin(context, CGLineJoin.Round)
            CGContextStrokePath(context)
        }
        
        if let fit = fitResult where drawDebug { // if there is a fit and drawDebug is turned on
            if !fit.error.isNaN { // if error has been defined, draw the fit
                let fitRect = CGRect(
                    x: fit.center.x - fit.width/2,
                    y: fit.center.y - fit.height/2,
                    width: fit.width,
                    height: fit.height
                )
                let fitPath = UIBezierPath(ovalInRect: fitRect)
                fitPath.lineWidth = 3
                
                // fit is the circle (green if the circle matched, red was the fit circle but did not recognize as a circle)
                let circleColor = isShape ? UIColor.greenColor() : UIColor.redColor()
                circleColor.setStroke()
                fitPath.stroke()
            }
            
            // draw a black bounding box around the user touch path
            let boundingBox = UIBezierPath(rect: CGPathGetBoundingBox(path))
            boundingBox.lineWidth = 1
            UIColor.blackColor().setStroke()
            boundingBox.stroke()
            
//            // draw a blue square inside as the touch exclusion area
//            let fitInnerRadius = fit.radius / sqrt(2)
//            let innerBoxRect = CGRect(
//                x: fit.center.x - fitInnerRadius,
//                y: fit.center.y - fitInnerRadius,
//                width: 2 * fitInnerRadius,
//                height: 2 * fitInnerRadius
//            )
//            let modifiedInnerBox = CGRectInset(innerBoxRect, fitInnerRadius*0.2, fitInnerRadius*0.2)
//            
//            let innerBox = UIBezierPath(rect: modifiedInnerBox)
//            UIColor.blueColor().colorWithAlphaComponent(0.5).setFill()
//            innerBox.fill()
        }
    }
}