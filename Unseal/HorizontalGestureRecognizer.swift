//
//  HorizontalGestureRecognizer.swift
//  Unseal
//
//  Created by synaptics on 7/13/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

class HorizontalGestureRecognizer{
    
    var tolerance:CGFloat = 10
    var fitResult = LineResult()
    
    func isHorizontal(points : [CGPoint]) -> Bool{
        fitResult = lineFit(points)
        let isHorizontal = calculateHorizontal(points)
        return fitResult.error <= tolerance && isHorizontal
    }
    
    func calculateHorizontal(points: [CGPoint]) -> Bool{
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
        return (xL - xS) > (yL - yS)
    }
}
