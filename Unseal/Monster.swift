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
    
    var health : Int
    var vx : CGFloat
    var vy : CGFloat
    var scale : CGFloat
    
    init(health : Int , vy : CGFloat, vx: CGFloat, scale : CGFloat){
        self.health = health
        self.vx = vx
        self.vy = vy
        self.scale = scale
    }
    
    func decrementHealth(damange : Int){
        health -= damange
    }
    
}