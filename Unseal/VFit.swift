//
//  VFit.swift
//  Unseal
//
//  Created by synaptics on 7/14/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

let restriction:CGFloat = 40

struct VResult{
    //splits the V in to two parts anc calculates the errors for each line
    var qualify:Bool // checks to see if this "V" qualifies as a V, via coordinates
    var error1 : CGFloat
    var error2 : CGFloat
    var direction:CGFloat //1 is point upward, -1 is point downward

    init(){
        qualify = false
        error1 = 0
        error2 = 0
        direction = 0
    }
    
}

func vDownFit(points: [CGPoint]) -> VResult{
    
    var vresult = VResult()
    
    var xL : CGFloat = 0
    var yL : CGFloat = 0
    var xS : CGFloat = 1000
    var yS : CGFloat = 1000
    
    var pivotPoint:CGPoint = CGPointZero
    
    var xLPoint:CGPoint = CGPointZero
    var xSPoint:CGPoint = CGPointZero
    
    
    for p in points{
        if p.x > xL {
            xL = p.x
            xLPoint = p
        }
        if p.y > yL {
            yL = p.y
            pivotPoint = p
        }
        if p.x < xS {
            xS = p.x
            xSPoint = p
        }
        if p.y < yS { yS = p.y}
    }
    print("pivot point: \(pivotPoint)")
    print("x large point: \(xLPoint)")
    print("y small point: \(xSPoint)")
    let lowPoint = xLPoint.y > xSPoint.y ? xSPoint.y : xLPoint.y
    print("low point: \(lowPoint)")
    let yDif = lowPoint - pivotPoint.y
    if abs(yDif) > restriction{
        vresult.qualify = true
        var line1 = [CGPoint]()
        var line2 = [CGPoint]()
        line2.append(pivotPoint)
        
        for p in points{
            if p.x >= xSPoint.x && p.x <= pivotPoint.x{
                line1.append(p)
            }
            else{
                line2.append(p)
            }
        }
        
        
        vresult.error1 = lineFit(line1).error
        vresult.error2 = lineFit(line2).error
        
        if yDif < 0{
            vresult.direction = -1
        }
        else{
            vresult.direction = 1
        }
        print("direction: \(vresult.direction)")
    }
    
    return vresult
}

func vUpFit(points: [CGPoint]) -> VResult{
    
    var vresult = VResult()
    
    var xL : CGFloat = 0
    var yL : CGFloat = 0
    var xS : CGFloat = 1000
    var yS : CGFloat = 1000
    
    var pivotPoint:CGPoint = CGPointZero
    
    var xLPoint:CGPoint = CGPointZero
    var xSPoint:CGPoint = CGPointZero
    
    
    for p in points{
        if p.x > xL {
            xL = p.x
            xLPoint = p
        }
        if p.y > yL {
            yL = p.y
        }
        if p.x < xS {
            xS = p.x
            xSPoint = p
        }
        if p.y < yS {
            yS = p.y
            pivotPoint = p
        }
    }
    print("pivot point: \(pivotPoint)")
    print("x large point: \(xLPoint)")
    print("y small point: \(xSPoint)")
    let lowPoint = xLPoint.y > xSPoint.y ? xSPoint.y : xLPoint.y
    print("low point: \(lowPoint)")
    let yDif = lowPoint - pivotPoint.y
    if abs(yDif) > restriction {
        vresult.qualify = true
        var line1 = [CGPoint]()
        var line2 = [CGPoint]()
        line2.append(pivotPoint)
        
        for p in points{
            if p.x >= xSPoint.x && p.x <= pivotPoint.x{
                line1.append(p)
            }
            else{
                line2.append(p)
            }
        }
        
        
        vresult.error1 = lineFit(line1).error
        vresult.error2 = lineFit(line2).error
        
        if yDif < 0{
            vresult.direction = -1
        }
        else{
            vresult.direction = 1
        }
        print("direction: \(vresult.direction)")
    }
    
    return vresult
}








