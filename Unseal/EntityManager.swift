//
//  EntityManager.swift
//  Unseal
//
//  Created by synaptics on 7/25/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import SpriteKit

class EntityManager {
    
    
    //reference path for mobs
    let redReference = NSBundle.mainBundle().pathForResource( "red", ofType: "sks")
    let blueReference = NSBundle.mainBundle().pathForResource( "blue", ofType: "sks")
    let yellowReference = NSBundle.mainBundle().pathForResource( "yellow", ofType: "sks")
    
    func spawnBlue() -> (SKReferenceNode, Monster){
        let blue = SKReferenceNode(URL: NSURL (fileURLWithPath: blueReference!))
        blue.position.x = 100
        blue.position.y = 290
        blue.xScale = 0.5
        blue.yScale = 0.5
    
        return (blue, Sprout(health:1, type: 2))
    }
    
    func spawnRed() -> (SKReferenceNode, Monster){
        let red = SKReferenceNode(URL: NSURL (fileURLWithPath: redReference!))
        red.position.x = 100
        red.position.y = 290
        red.xScale = 0.5
        red.yScale = 0.5
        
        return (red, Sprout(health:1, type: 1))

    }
    
    func spawnYellow() -> (SKReferenceNode, Monster) {
        let yellow = SKReferenceNode(URL: NSURL (fileURLWithPath: yellowReference!))
        yellow.position.x = 100
        yellow.position.y = 290
        yellow.xScale = 0.5
        yellow.yScale = 0.5
        
        return (yellow, Sprout(health:1, type: 3))

    }

}





