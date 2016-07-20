//
//  Flower.swift
//  Unseal
//
//  Created by synaptics on 7/20/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

class Flower : Monster{
 
    //0.5/300
    var yStep : CGFloat
    
    var xStep : CGFloat
    //pt that the monster will stop at divided by num of ticks (300)
    var stepAmmount : CGFloat
    
    init(health : Int){
        yStep = 260/300
        xStep = 0.3
        
        stepAmmount = 0.00167
        
        super.init(health: health, vy: yStep, vx: xStep, scale: stepAmmount)
    }
}