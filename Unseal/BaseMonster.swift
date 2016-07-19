//
//  BaseMonster.swift
//  Unseal
//
//  Created by synaptics on 7/18/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

class BaseMonster{
    
    var health : Int

    var speed : CGFloat
    
    var currentPos : CGPoint
    
    init(health : Int, speed : CGFloat, position : CGPoint){
        self.health = health
        self.speed = speed
        currentPos = position
    }
    
    func decrementHealth(damage : Int){
        health -= health
    }
    
    func updatePos(){
        currentPos.y += speed
    }
    
    func isAlive() -> Bool {
        return health > 0
    }
    
}