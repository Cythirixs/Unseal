//
//  LightningFit.swift
//  Unseal
//
//  Created by synaptics on 7/15/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

struct  LightningResult {
    var error1 : CGFloat
    var error2 : CGFloat
    var width : CGFloat
    var height : CGFloat
    
    init(){
        error1 = 0
        error2 = 0
        width = 0
        height = 0
    }
}

func lightningFit(points: [CGPoint]) -> LightningResult{
    var lightning = LightningResult()
    
    var xL : CGFloat = 0
    var yL : CGFloat = 0
    var xS : CGFloat = 1000
    var yS : CGFloat = 1000

    
    for p in points{
        if p.x > xL { xL = p.x}
        if p.y > yL { yL = p.y}
        if p.x < xS { xS = p.x}
        if p.y < yS { yS = p.y}
    }

    lightning.width = xL - xS
    lightning.height = yL - yS
    
    
    
    return lightning
}
