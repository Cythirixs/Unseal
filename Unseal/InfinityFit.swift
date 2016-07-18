//
//  InfinityFit.swift
//  Unseal
//
//  Created by synaptics on 7/14/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

struct InfinityResult {
    var circleError:CGFloat
    var error1:CGFloat
    var error2:CGFloat
    var error3:CGFloat
    
    init(){
        circleError = 0
        error1 = 0
        error2 = 0
        error3 = 0
    }
}

func fitInfinity(points: [CGPoint]) -> InfinityResult{
    var infinity = InfinityResult()
    
    var xL : CGFloat = 0
    var yL : CGFloat = 0
    var xS : CGFloat = 1000
    var yS : CGFloat = 1000
    
    var N:CGPoint = CGPointZero
    var E:CGPoint = CGPointZero
    var S:CGPoint = CGPointZero
    var W:CGPoint = CGPointZero
    
    for p in points{
        if p.x > xL{
            xL = p.x
            E = p
        }
        if p.y > yL {
            yL = p.y
            S = p
        }
        if p.x < xS {
            xS = p.x
            W = p
        }
        if p.y < yS {
            yS = p.y
            N = p
        }
        
        
    }

    
    let x1:CGFloat = (N.x - S.x)
    let y1:CGFloat = (N.y - S.y)
    
    let slope1 = y1 / x1
    let b1 = N.y - (slope1 * N.x)
    
    
    let x2:CGFloat = (W.x - E.x)
    let y2:CGFloat = (W.y - E.y)
    
    let slope2 = y2 / x2
    let b2 = W.y - (slope2 * W.x)
    
    let b = b1 - b2
    let slope = slope1 - slope2
    
    let xIntersect =  b / -slope
    let yIntersect = slope1 * xIntersect + b1
    
    var dis:CGFloat = 1000
    
    for p in points{
        let temp = sqrt( (xIntersect - p.x) + (yIntersect - p.y) )
        if temp < dis{ dis = temp}
    }
    
    var vFit = [CGPoint]()
    var linePt = [CGPoint]()
    var circleFit = [CGPoint]()
    
    var change = false
    var isCircle = false
    
    for p in points{
        
        if p.x < xIntersect + 20 && p.y < yIntersect + 20{ isCircle = true}
        else if isCircle == true {
            isCircle = false
            change = true
        }
        
        if isCircle{
            circleFit.append(p)
        }
        else{
            if change { vFit.append(p)}
            else { linePt.append(p) }
        }
    }
    
    if linePt.contains(S) {
        let temp = linePt
        linePt = vFit
        vFit = temp
    }
    
    
    let line = lineFit(linePt)
    let v = vDownFit(vFit)
    let circle = fitCircle(circleFit)
    
    infinity.circleError = circle.error
    infinity.error1 = line.error
    infinity.error2 = v.error1
    infinity.error3 = v.error2
    
    
    return infinity
}








