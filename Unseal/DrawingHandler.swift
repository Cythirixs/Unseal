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
    
    //all possible shapes
    enum shapes{
        case circle, horizontal, vertical, leaf, vUp, vDown, hourglass, lightning, infinity
    }
    
    
    private var touchedPoints = [CGPoint]() // point history
    var isShape = false
    var path = CGPathCreateMutable() // running CGPath - helps with drawing
    
    //current shape
    var currentShape:shapes = .hourglass
    
    
    //recognizers
    var CircleGesture = CircleGestureRecognizer()
    var HoizontalGesture = HorizontalGestureRecognizer()
    var VerticalGesture = VerticalGestureRecognizer()
    var LeafGesture = LeafGestureRecognizer()
    var vUpGesture = VUpGestureRecognizer()
    var vDownGesture = VDownGestureRecognizer()
    var HourglassGesture = HourglassGestureRecognizer()
    var LightningGesture = LightningGestureRecognizer()
    var InfinityGesture = InfinityGestureRecognizer()
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        if touches.count != 1 {
            state = .Failed
        }
        state = .Began
        
        let window = view?.window
        if let touches = touches as? Set<UITouch>, loc = touches.first?.locationInView(window) {
            CGPathMoveToPoint(path, nil, loc.x, loc.y) // start the path
        }
    }
    
    //when touch ends calculate if line drawn is the respective shape
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        
        var result = false
        switch currentShape{
        case .circle:
            result = CircleGesture.isCircle(touchedPoints, path: path)
        case .horizontal:
            result = HoizontalGesture.isHorizontal(touchedPoints)
        case.vertical:
            result = VerticalGesture.isVertical(touchedPoints)
        case .leaf:
            result = LeafGesture.isLeaf(touchedPoints)
        case .vUp:
            result = vUpGesture.isV(touchedPoints)
        case .vDown:
            result = vDownGesture.isV(touchedPoints)
        case .hourglass:
            result = HourglassGesture.isHourglass(touchedPoints)
        case .lightning:
            result = LightningGesture.isLightning(touchedPoints)
        case .infinity:
            result = InfinityGesture.isInfinity(touchedPoints)
        }
        isShape = result

        state = isShape ? .Ended : .Failed
        
    }
    
    //randomizes next shape
    func randomize(){
        let n = arc4random_uniform(9)
        if n == 0{
            currentShape = .circle
        }
        else if n == 1{
            currentShape = .horizontal
        }
        else if n == 2{
            currentShape = .hourglass
        }
        else if n == 3{
            currentShape = .vertical
        }
        else if n == 4{
            currentShape = .vUp
        }
        else if n == 5{
            currentShape = .vDown
        }
        else if n == 6{
            currentShape = .leaf
        }
        else if n == 7{
            currentShape = .lightning
        }
        else{
            currentShape = .infinity
        }
        
    }
    
    //when finger moves add point to array
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        
        if touches.count != 1{
            state = .Failed
        }
        
        if state == .Failed {
            return
        }
        
        let window = view?.window
        if let touches = touches as? Set<UITouch>, loc = touches.first?.locationInView(window) {
           // print("new point at: \(loc)")
            touchedPoints.append(loc)
            CGPathAddLineToPoint(path, nil, loc.x, loc.y)
            state = .Changed
        }
    }
    
    //resets everything
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