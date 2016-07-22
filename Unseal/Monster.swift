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
    
    var attackTimer : CFTimeInterval = 0
    
    var type = -1
    
    //init a monster
    init(health : Int , vy : CGFloat, vx: CGFloat, scale : CGFloat, type : Int){
        self.health = health
        self.vx = vx * 0.75
        self.vy = vy * 0.75
        self.scale = scale * 0.75
        self.type = type
    }
    
    //decrease health by damage
    func decrementHealth(damange : Int){
        health -= damange
    }
    
    func tickAttack(tick : CFTimeInterval){
        attackTimer += tick
    }
    
    func isAlive() -> Bool{
        return health > 0
    }
    
}