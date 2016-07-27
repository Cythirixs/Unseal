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
    
    let sproutReference = NSBundle.mainBundle().pathForResource( "Sprout", ofType: "sks")
    let flowerReference = NSBundle.mainBundle().pathForResource( "Flower", ofType: "sks")
    let mushroomReference = NSBundle.mainBundle().pathForResource( "Mushroom", ofType: "sks")
    let eyeReference = NSBundle.mainBundle().pathForResource( "Eye", ofType: "sks")
    let frogReference = NSBundle.mainBundle().pathForResource( "Froguana", ofType: "sks")
    
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
    
    func spawnSprout() -> (SKReferenceNode, Monster){
        let sprout = SKReferenceNode(URL: NSURL (fileURLWithPath: sproutReference!))
        sprout.position.x = 150
        sprout.position.y = 510
        sprout.xScale = 0.2
        sprout.yScale = 0.2
        return(sprout, Sprout(health: 1, type: 1 ))
    }
    
    func spawnFlower() -> (SKReferenceNode, Monster){
        let flower = SKReferenceNode(URL: NSURL (fileURLWithPath: flowerReference!))
        flower.position.x = 150
        flower.position.y = 510
        flower.xScale = 0.2
        flower.yScale = 0.2
        return(flower, Flower(health: 1, type: 1 ))
    }
    func spawnMushroom() -> (SKReferenceNode, Monster){
        let mushroom = SKReferenceNode(URL: NSURL (fileURLWithPath: mushroomReference!))
        mushroom.position.x = 150
        mushroom.position.y = 510
        mushroom.xScale = 0.2
        mushroom.yScale = 0.2
        return(mushroom, Mushroom(health: 2, type: 1 ))
    }
    func spawnEye() -> (SKReferenceNode, Monster){
        let eye = SKReferenceNode(URL: NSURL (fileURLWithPath: eyeReference!))
        eye.position.x = 150
        eye.position.y = 510
        eye.xScale = 0.2
        eye.yScale = 0.2
        return(eye, Eye(health: 1, type: 2 ))
    }

}





