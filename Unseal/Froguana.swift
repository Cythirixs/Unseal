//
//  Froguana.swift
//  Unseal
//
//  Created by synaptics on 7/20/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

class Froguana : Monster{
    //0.5/300
    var yStep : CGFloat
    //pt that the monster will stop at divided by num of ticks (300)
    var xStep : CGFloat
    //scale step ammount
    var stepAmmount : CGFloat
    
    init(health : Int, type : Int){
        yStep = 260/300
        xStep = 0.166
        
        stepAmmount = 0.00167
        
        super.init(health: health, vy: yStep, vx: xStep, scale: stepAmmount, type : type)
    }

}