//
//  VerticalGestureRecognizer.swift
//  Unseal
//
//  Created by synaptics on 7/14/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

class VerticalGestureRecognizer{
    
    var path = CGPathCreateMutable()
    var tolerance:CGFloat = 8
    var fitResult = LineResult()
    
    func isVertical(points : [CGPoint], path : CGMutablePath) -> Bool{
        self.path = path
        fitResult = lineFit(points)
        let isVertical = calculateVertical(points)
        return fitResult.error <= tolerance && isVertical
    }
    
    func calculateVertical(points: [CGPoint]) -> Bool{
        var xL : CGFloat = 0
        var yL : CGFloat = 0
        var xS : CGFloat = 1000
        var yS : CGFloat = 1000
        
        for p in points{
            if p.x > xL { xL = p.x}
            if p.y > yL { yL = p.y}
            if p.x < xS {xS = p.x}
            if p.y < yS { yS = p.y}
        }
        return (xL - xS) < (yL - yS)
    }
}