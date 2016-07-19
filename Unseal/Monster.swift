//
//  Monster.swift
//  Unseal
//
//  Created by synaptics on 7/19/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Monster : BaseMonster{
    
    var health : Int
    
    var movement : CGFloat
    
    var currentPos : CGPoint
    
    var maxWidth : CGFloat = 244
    var maxHeight : CGFloat = 295
    
    var currentWidth : CGFloat = 50
    var currentHeight : CGFloat = 50
    
    
    var vx : CGFloat
    var vy : CGFloat
    
    override init(health : Int, speed : CGFloat, position : CGPoint){
        vx = (maxWidth - currentWidth) / speed
        vy = (maxHeight - currentHeight) / speed
        
        super.init(health: health, speed: speed, position: position)
        
    }
    
     required init?(coder aDecoder: NSCoder, health : Int, speed : CGFloat, position : CGPoint) {
        super.init(aDecoder)
    }
    
    func update() {
        currentWidth += vx
        currentHeight += vy
    }
    
    func decrementHealth(damage : Int){
        health -= health
    }
    
    func isAlive() -> Bool {
        return health > 0
    }
    
    
}