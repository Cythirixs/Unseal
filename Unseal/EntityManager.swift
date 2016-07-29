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
    
    /*
    typing
     red = 1
     blue = 2
     yellow = 3
 
     */
    
    //reference path for mobs
    let redSproutReference = NSBundle.mainBundle().pathForResource( "RedSprout", ofType: "sks")
    let blueSproutReference = NSBundle.mainBundle().pathForResource("BlueSprout", ofType: "sks")
    
    let redFlowerReference = NSBundle.mainBundle().pathForResource( "RedFlower", ofType: "sks")
    let blueFlowerReference = NSBundle.mainBundle().pathForResource( "BlueFlower", ofType: "sks")
    let yellowFlowerReference = NSBundle.mainBundle().pathForResource( "YellowFlower", ofType: "sks")
    
    let redMushroomReference = NSBundle.mainBundle().pathForResource( "RedMushroom", ofType: "sks")
    let blueMushroomReference = NSBundle.mainBundle().pathForResource( "BlueMushroom" , ofType: "sks")
    
    let blueEyeReference = NSBundle.mainBundle().pathForResource( "BlueEye", ofType: "sks")
    let yellowEyeReference = NSBundle.mainBundle().pathForResource( "YellowEye" , ofType: "sks")
    
    let blueSpiderReference = NSBundle.mainBundle().pathForResource("BlueSpider", ofType: "sks")
    let yellowSpiderReference = NSBundle.mainBundle().pathForResource("YellowSpider", ofType: "sks")
    
    let blueFrogReference = NSBundle.mainBundle().pathForResource("BlueFroguana", ofType: "sks")
    
    let treeReference = NSBundle.mainBundle().pathForResource("Tree", ofType: "sks")
    
    //Sprout
    func spawnRedSprout() -> (SKReferenceNode, Monster){
        let sprout = SKReferenceNode(URL: NSURL (fileURLWithPath: redSproutReference!))
        sprout.position.x = 150
        sprout.position.y = 510
        sprout.xScale = 0.2
        sprout.yScale = 0.2
        return(sprout, Sprout(health: 1, type: 1 ))
    }
    func spawnBlueSprout() -> (SKReferenceNode, Monster){
        let sprout = SKReferenceNode(URL: NSURL (fileURLWithPath: blueSproutReference!))
        sprout.position.x = 150
        sprout.position.y = 510
        sprout.xScale = 0.2
        sprout.yScale = 0.2
        return(sprout, Sprout(health: 1, type: 2 ))
    }

    
    //Flower
    func spawnRedFlower() -> (SKReferenceNode, Monster){
        let flower = SKReferenceNode(URL: NSURL (fileURLWithPath: redFlowerReference!))
        flower.position.x = 150
        flower.position.y = 510
        flower.xScale = 0.2
        flower.yScale = 0.2
        return(flower, Flower(health: 1, type: 1 ))
    }
    func spawnBlueFlower() -> (SKReferenceNode, Monster){
        let flower = SKReferenceNode(URL: NSURL (fileURLWithPath: blueFlowerReference!))
        flower.position.x = 150
        flower.position.y = 510
        flower.xScale = 0.2
        flower.yScale = 0.2
        return(flower, Flower(health: 1, type: 2 ))
    }
    func spawnYellowFlower() -> (SKReferenceNode, Monster){
        let flower = SKReferenceNode(URL: NSURL (fileURLWithPath: yellowFlowerReference!))
        flower.position.x = 150
        flower.position.y = 510
        flower.xScale = 0.2
        flower.yScale = 0.2
        return(flower, Flower(health: 1, type: 3 ))
    }
    
    //Mushroom
    func spawnRedMushroom() -> (SKReferenceNode, Monster){
        let mushroom = SKReferenceNode(URL: NSURL (fileURLWithPath: redMushroomReference!))
        mushroom.position.x = 150
        mushroom.position.y = 510
        mushroom.xScale = 0.2
        mushroom.yScale = 0.2
        return(mushroom, Mushroom(health: 2, type: 1 ))
    }
    func spawnBlueMushroom() -> (SKReferenceNode, Monster){
        let mushroom = SKReferenceNode(URL: NSURL (fileURLWithPath: blueMushroomReference!))
        mushroom.position.x = 150
        mushroom.position.y = 510
        mushroom.xScale = 0.2
        mushroom.yScale = 0.2
        return(mushroom, Mushroom(health: 2, type: 2 ))
    }
    
    //Eye
    func spawnBlueEye() -> (SKReferenceNode, Monster){
        let eye = SKReferenceNode(URL: NSURL (fileURLWithPath: blueEyeReference!))
        eye.position.x = 150
        eye.position.y = 510
        eye.xScale = 0.2
        eye.yScale = 0.2
        return(eye, Eye(health: 1, type: 2 ))
    }
    func spawnYellowEye() -> (SKReferenceNode, Monster){
        let eye = SKReferenceNode(URL: NSURL (fileURLWithPath: yellowEyeReference!))
        eye.position.x = 150
        eye.position.y = 510
        eye.xScale = 0.2
        eye.yScale = 0.2
        return(eye, Eye(health: 1, type: 3 ))
    }
    
    //Spider
    func spawnBlueSpider() -> (SKReferenceNode, Monster){
        let spider = SKReferenceNode(URL: NSURL (fileURLWithPath: blueSpiderReference!))
        spider.position.x = 150
        spider.position.y = 510
        spider.xScale = 0.3
        spider.yScale = 0.3
        return(spider, Eye(health: 1, type: 2 ))
    }
    
    func spawnYellowSpider() -> (SKReferenceNode, Monster){
        let spider = SKReferenceNode(URL: NSURL (fileURLWithPath: yellowEyeReference!))
        spider.position.x = 150
        spider.position.y = 510
        spider.xScale = 0.3
        spider.yScale = 0.3
        return(spider, Eye(health: 1, type: 3 ))
    }
    
    //Frog
    
    func spawnBlueFrog() -> (SKReferenceNode, Monster){
        let froguana = SKReferenceNode(URL: NSURL (fileURLWithPath: blueFrogReference!))
        froguana.position.x = 120
        froguana.position.y = 510
        froguana.xScale = 0.2
        froguana.yScale = 0.2
        return(froguana, Froguana(health: 3, type: 2 ))
    }
    
    //tree
    func treeSpan() -> (SKReferenceNode, Monster){
        let eye = SKReferenceNode(URL: NSURL (fileURLWithPath: treeReference!))
        eye.position.x = 150
        eye.position.y = 510
        eye.xScale = 0.2
        eye.yScale = 0.2
        return(eye, Eye(health: 1, type: 3 ))
    }
}





