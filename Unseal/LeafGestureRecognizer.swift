//
//  LeafGestureRecognizer.swift
//  Unseal
//
//  Created by synaptics on 7/14/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

class LeafGestureRecognizer{
    
    var tolerance:CGFloat = 8
    
    var widthLimit:CGFloat = 10
    var fitResult = LineResult()
    
    func isLeaf(points : [CGPoint]) -> Bool{
        fitResult = lineFit(points)
        let isLeaf = calculateLeaf(points)
        return fitResult.error > tolerance && isLeaf
    }
    
    func calculateLeaf(points: [CGPoint]) -> Bool{
        var xL : CGFloat = 0
        var yL : CGFloat = 0
        var xS : CGFloat = 1000
        var yS : CGFloat = 1000
        
        var xSPoint:CGPoint = CGPointZero
        var xLPoint:CGPoint = CGPointZero
        
        for p in points{
            if p.x > xL {
                xL = p.x
                xLPoint = p
            }
            if p.y > yL { yL = p.y}
            if p.x < xS {
                xS = p.x
                xSPoint = p
                
            }
            if p.y < yS { yS = p.y}
        }
        
   //     print("largest X : \(xLPoint)")
   //     print("smallest X : \(xSPoint)")
        
        //width tolerance
        let wT:CGFloat = 20
        
        return (xL - xS) > widthLimit && (xL - xS) < (yL - yS) && (xLPoint.y > yL - wT && xLPoint.y < yL + wT)
        && (xSPoint.y > yS - wT && xSPoint.y < yS + wT)
    }
}