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
    
    

    
    return hourglass
}