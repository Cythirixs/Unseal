//
//  HourglassFit.swift
//  Unseal
//
//  Created by synaptics on 7/13/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

struct HourglassResult {
    var horizError: CGFloat
    var vertError: CGFloat
    var diagError: CGFloat
    
    init(){
        horizError = 0
        vertError = 0
        diagError = 0
    }
}

func HourglassFit(points: [CGPoint]) -> HourglassResult{
    
    var hourglass = HourglassResult()
    
    
    var xL : CGFloat = 0
    var yL : CGFloat = 0
    var xS : CGFloat = 1000
    var yS : CGFloat = 1000
    
    var N:CGPoint = CGPointZero
    var W:CGPoint = CGPointZero
    
    for p in points{
        if p.x > xL{xL = p.x}
        if p.y > yL {yL = p.y}
        if p.x < xS {
            xS = p.x
            W = p
        }
        if p.y < yS {
            yS = p.y
            N = p
        }
    }
    
    var lineA = [CGPoint]()
    var lineB = [CGPoint]()
    
    var change = false
    var swap = false
    
    for p in points{
        
        if p == W{
            if !lineA.contains(N) {
                swap = true
            }
            
            change = true
        }
        
        if change{
            lineB.append(p)
        }
        else{
            lineA.append(p)
        }
    }
    
    if swap {
        let temp = lineA
        lineA = lineB
        lineB = temp
    }
    
    let v = vDownFit(lineA)
    let line = lineFit(lineB)
    
    hourglass.vertError = v.error1
    hourglass.diagError = v.error2
    hourglass.horizError = line.error
    
    return hourglass
}