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
        blue.position.x = 150
        blue.position.y = 510
        blue.xScale = 0.2
        blue.yScale = 0.2
    
        return (blue, Sprout(health:1, type: 2))
    }
    
    func spawnRed() -> (SKReferenceNode, Monster){
        let red = SKReferenceNode(URL: NSURL (fileURLWithPath: redReference!))
        red.position.x = 150
        red.position.y = 510
        red.xScale = 0.2
        red.yScale = 0.2
        
        return (red, Sprout(health:1, type: 1))

    }
    
    func spawnYellow() -> (SKReferenceNode, Monster) {
        let yellow = SKReferenceNode(URL: NSURL (fileURLWithPath: yellowReference!))
        yellow.position.x = 150
        yellow.position.y = 510
        yellow.xScale = 0.2
        yellow.yScale = 0.2
        
        return (yellow, Sprout(health:1, type: 3))

    }

}





