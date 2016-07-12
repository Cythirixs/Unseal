//
//  DrawingHandler.swift
//  Unseal
//
//  Created by synaptics on 7/12/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation


import UIKit
import UIKit.UIGestureRecognizerSubclass

class DrawingHandler: UIGestureRecognizer {
    
    enum shapes{
        case circle
    }
    
    private var touchedPoints = [CGPoint]() // point history
    var tolerance: CGFloat = 0.4 // circle wiggle room
    var isShape = false
    var path = CGPathCreateMutable() // running CGPath - helps with drawing
    
    var currentShape:shapes = .circle
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        print("touch begain")
        if touches.count != 1 {
            state = .Failed
        }
        state = .Began
        
        let window = view?.window
        if let touches = touches as? Set<UITouch>, loc = touches.first?.locationInView(window) {
            CGPathMoveToPoint(path, nil, loc.x, loc.y) // start the path
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        print("touch ended")
        
        state = isShape ? .Ended : .Failed
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        print("moved")
        
        if state == .Failed {
            return
        }
        
        let window = view?.window
        if let touches = touches as? Set<UITouch>, loc = touches.first?.locationInView(window) {
            touchedPoints.append(loc)
            CGPathAddLineToPoint(path, nil, loc.x, loc.y)
            state = .Changed
        }
    }
    
    override func reset() {
        super.reset()
    
        touchedPoints.removeAll(keepCapacity: true)
        path = CGPathCreateMutable()
        isShape = false
        state = .Possible
    }
    
    override func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesCancelled(touches, withEvent: event)
        state = .Cancelled // forward the cancel state
    }
    
}