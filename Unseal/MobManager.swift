//
//  MobManager.swift
//  Unseal
//
//  Created by synaptics on 7/22/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import SpriteKit

class MobManager{

    //reference and information of monsters in 2 arrays
    var entities : [SKReferenceNode]
    var monsters : [Monster]
        
    //reference path for mobs
    let redReference = NSBundle.mainBundle().pathForResource( "red", ofType: "sks")
    let blueReference = NSBundle.mainBundle().pathForResource( "blue", ofType: "sks")
    let yellowReference = NSBundle.mainBundle().pathForResource( "yellow", ofType: "sks")
    
    init(){
        entities = [SKReferenceNode]()
        monsters = [Monster]()
    }
    
    
    func spawnBlue() -> SKReferenceNode{
        let blue = SKReferenceNode(URL: NSURL (fileURLWithPath: blueReference!))
        blue.position.x = 100
        blue.position.y = 290
        blue.xScale = 0.5
        blue.yScale = 0.5
        blue.zPosition = 0
        
        entities.append(blue)
        monsters.append(Sprout(health: 1, type: 2))
        
        return blue
    }
    
    func spawnRed() -> SKReferenceNode{
        let red = SKReferenceNode(URL: NSURL (fileURLWithPath: redReference!))
        red.position.x = 100
        red.position.y = 290
        red.xScale = 0.5
        red.yScale = 0.5
        red.zPosition = 0
        
        entities.append(red)
        monsters.append(Flower(health: 1, type : 1))
        
        return red
    }
    
    func spawnYellow() -> SKReferenceNode{
        let yellow = SKReferenceNode(URL: NSURL (fileURLWithPath: yellowReference!))
        yellow.position.x = 100
        yellow.position.y = 290
        yellow.xScale = 0.5
        yellow.yScale = 0.5
        yellow.zPosition = 0
        
        entities.append(yellow)
        monsters.append(Mushroom(health: 1, type : 3))

        return yellow
    }
    

}
