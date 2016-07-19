//
//  HorizontalFit.swift
//  Unseal
//
//  Created by synaptics on 7/13/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

//structure that stores the information gained from the lineFit func
struct LineResult {
    //center of the line
    var center : CGPoint
    //width of the line
    var width: CGFloat
    //height of the line
    var height: CGFloat
    // the error is a value that shows how far off the shape is from a "true line"
    var error : CGFloat
    
    //init values
    init(){
        center = CGPointZero
        width = 0
        height = 0
        error = 0
    }
}


//calculates the line by creating a best fit line which uses the first point and the average of all the points as a second point, it then calculates the average of all the distanced from the best fit line. the average returned is the error
func lineFit(points : [CGPoint]) -> LineResult{
    
    //number of points in data set
    let dataCount = CGFloat(points.count)
    var mean = CGPointZero
    
    //calculate mean
    for p in points{
        mean.x += p.x
        mean.y += p.y
    }
    
    mean.x /= dataCount
    mean.y /= dataCount
    
    //get the furthes X and Y and the smallest X and Y
    
    // largest X
    var xL : CGFloat = 0
    // largest Y
    var yL : CGFloat = 0
    // smalled X
    var xS : CGFloat = 1000
    // smalled Y
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
  //  print("error: \(error)")
    
    var line = LineResult()
    line.center = CGPoint(x: mean.x, y: mean.y)
    line.width = width
    line.height = height
    line.error = error
    
    return line
}








