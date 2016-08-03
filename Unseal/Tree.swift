//
//  Tree.swift
//  Unseal
//
//  Created by synaptics on 8/2/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

class Tree : Monster{
    
    //0.5/300
    var yStep : CGFloat
    //pt that the monster will stop at divided by num of ticks (300)
    var xStep : CGFloat
    //scale step ammount
    var stepAmmount : CGFloat
    
    init(health : Int, type : Int){
        yStep = 0
        xStep = 0
        stepAmmount = 0
        
        super.init(health: health, vy: yStep, vx: xStep, scale: stepAmmount, type: type)
    }
    
}