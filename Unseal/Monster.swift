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
    
    var x : CGFloat = 150
    var y : CGFloat = 510
    var scale : CGFloat = 0.2
    
    //the x change
    var vx : CGFloat
    //the y change
    var vy : CGFloat
    //the scale step
    var vScale : CGFloat
    
    var attackTimer : CFTimeInterval = 0
    
    var type = -1
    
    //init a monster
    init(health : Int , vy : CGFloat, vx: CGFloat, scale : CGFloat, type : Int){
        self.health = health
        self.vx = vx * 0.75
        self.vy = vy * 0.75
        self.vScale = scale * 0.75
        self.type = type
    }
    
    init(){
        vx = 0
        vy = 0
        vScale = 0
        health = 0
        
    }
    
    //decrease health by damage
    func decrementHealth(damange : Int){
        health -= damange
    }
    
    func incramentX(){
        x -= vx
    }
    
    func imcramentY(){
        y -= vy
    }
    
    func incramentScale(){
        scale += vScale
    }
    
    func tickAttack(tick : CFTimeInterval){
        attackTimer += tick
    }
    
    func isAlive() -> Bool{
        return health > 0
    }
    
}