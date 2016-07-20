//
//  Monster.swift
//  Unseal
//
//  Created by synaptics on 7/20/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

class Monster{
    
    //health of monster
    var health : Int
    
    //the x change
    var vx : CGFloat
    //the y change
    var vy : CGFloat
    //the scale step
    var scale : CGFloat
    
    //init a monster
    init(health : Int , vy : CGFloat, vx: CGFloat, scale : CGFloat){
        self.health = health
        self.vx = vx
        self.vy = vy
        self.scale = scale
    }
    
    //decrease health by damage
    func decrementHealth(damange : Int){
        health -= damange
    }
    
    func isAlive() -> Bool{
        return health > 0
    }
    
}