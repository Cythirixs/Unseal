//
//  LightningGestureRecognizer.swift
//  Unseal
//
//  Created by synaptics on 7/15/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

class LightningGestureRecognizer{
    
    
    var tolerance:CGFloat = 8
    
    var heightLimit:CGFloat = 30
    var fitResult = LineResult()
    
    func isLightning(points : [CGPoint]) -> Bool{
        fitResult = lineFit(points)
        let isLeaf = calculateLightning(points)
        return fitResult.error > tolerance && isLeaf
    }
    
    func calculateLightning(points: [CGPoint]) -> Bool{
        var xL : CGFloat = 0
        var yL : CGFloat = 0
        var xS : CGFloat = 1000
        var yS : CGFloat = 1000
        
        var ySPoint:CGPoint = CGPointZero
        var yLPoint:CGPoint = CGPointZero
        
        for p in points{
            if p.x > xL {xL = p.x}
            if p.y > yL {
                yL = p.y
                yLPoint = p
            }
            if p.x < xS { xS = p.x}
            if p.y < yS {
                yS = p.y
                ySPoint = p
            }
        }
        
        //     print("largest X : \(xLPoint)")
        //     print("smallest X : \(xSPoint)")
        
        //width tolerance
        let lT:CGFloat = 20
        
        return (yL - yS) > heightLimit && (xL - xS) < (yL - yS) && (yLPoint.x > xL - lT && yLPoint.x < xL + lT)
            && (ySPoint.x > xS - lT && ySPoint.x < xS + lT)
    }

    
}