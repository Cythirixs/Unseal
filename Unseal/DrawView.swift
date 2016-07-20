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
    private var isShape = false
    
    var ended = false
    private var color = UIColor.greenColor().CGColor
    
    
    func updateFit(madeShape: Bool) {
        isShape = madeShape
        setNeedsDisplay()
    }
    
    func updatePath(p: CGPath?) {
        path = p
        setNeedsDisplay()
    }
    
    func clear() {
        updateFit(false)
        updatePath(nil)
    }
    
    override func drawRect(rect: CGRect) {
        
        if ended { // draw a thick yellow line for the user touch path
            if isShape{
                color = UIColor.greenColor().CGColor
            }
            else{
                color = UIColor.redColor().CGColor
            }
            
            let context = UIGraphicsGetCurrentContext()
            CGContextAddPath(context, path)
            CGContextSetStrokeColorWithColor(context, color)
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

 
    }
}
