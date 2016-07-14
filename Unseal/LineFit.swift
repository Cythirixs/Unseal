//
//  HorizontalFit.swift
//  Unseal
//
//  Created by synaptics on 7/13/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

struct LineResult {
    var center : CGPoint
    var width: CGFloat
    var height: CGFloat
    var error : CGFloat
    init(){
        center = CGPointZero
        width = 0
        height = 0
        error = 0
    }
}

func lineFit(points : [CGPoint]) -> LineResult{
    
    var dataCount = CGFloat(points.count)
    var mean = CGPointZero
    
    for p in points{
        mean.x += p.x
        mean.y += p.y
    }
    
    mean.x /= dataCount
    mean.y /= dataCount
    
    var xL : CGFloat = 0
    var yL : CGFloat = 0
    var xS : CGFloat = 1000
    var yS : CGFloat = 1000
    
    var pivotPoint:CGPoint = CGPointZero
    
    for p in points{
        if p.x > xL { xL = p.x}
        if p.y > yL { yL = p.y}
        if p.x < xS {
            xS = p.x
            pivotPoint = p
        }
        if p.y < yS { yS = p.y}
    }

    let width = xL - xS
    let height = yL - yS
    
//    print("pivot point: \(pivotPoint)")
//    print("center: \(mean)")
    
    let A:CGFloat = (mean.x - pivotPoint.x)
    let B:CGFloat = (mean.y - pivotPoint.y)
    
    let bfSlope = B / A
    let bfB = mean.y - (bfSlope * mean.x)
    
    let C = bfB * A
        
    var error:CGFloat = 0
    
//    print("line eqn : y = \(bfSlope) x + \(bfB)")
//    print("standar form: \(B)x + \(A)y + \(C) = 0")
    
    for p in points{
        
        let absolute = abs( -(B * p.x) + (A * p.y) -  C)
        let square =  sqrt( (A * A) + (B * B) )
        let distance = absolute / square
        
//        print("\(p) is \(distance) from line")
        
        error += distance
    }
    error /= dataCount
//    print("error: \(error)")
    
    var line = LineResult()
    line.center = CGPoint(x: mean.x, y: mean.y)
    line.width = width
    line.height = height
    line.error = error
    
    return line
}








