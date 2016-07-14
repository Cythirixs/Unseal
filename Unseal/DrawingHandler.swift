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
        case circle, horizontal, vertical, leaf
    }
    
    private var touchedPoints = [CGPoint]() // point history
    var fitResult = LineResult()
    var isShape = false
    var path = CGPathCreateMutable() // running CGPath - helps with drawing
    
    var currentShape:shapes = .circle
    
    //recognizers
    var CircleGesture = CircleGestureRecognizer()
    var HoizontalGesture = HorizontalGestureRecognizer()
    var VerticalGesture = VerticalGestureRecognizer()
    var LeafGesture = LeafGestureRecognizer()
    
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
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        var result = false
        switch currentShape{
        case .circle:
            result = CircleGesture.isCircle(touchedPoints, path: path)
        case .horizontal:
            result = HoizontalGesture.isHorizontal(touchedPoints, path: path)
        case.vertical:
            result = VerticalGesture.isVertical(touchedPoints, path: path)
        case .leaf:
            result = LeafGesture.isLeaf(touchedPoints, path: path)
        }
        isShape = result

        print(isShape)
        state = isShape ? .Ended : .Failed
    }
    
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