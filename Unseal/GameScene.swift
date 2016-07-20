//
//  GameScene.swift
//  Unseal
//
//  Created by synaptics on 7/12/16.
//  Copyright (c) 2016 Amino. All rights reserved.
//

import SpriteKit
import SceneKit

class GameScene: SKScene {
    
    //labels
    var score : SKLabelNode!
    var gesture : SKLabelNode!
    
    //current score
    var currentScore = 0
    
    //reference and information of monsters in 2 arrays
    var entities = [SKReferenceNode]()
    var monsters = [Monster]()
    
    //spell buttons w:60 h:24
    var spell1 : MSButtonNode!
    var spell2 : MSButtonNode!
    var spell3 : MSButtonNode!
    var spell4 : MSButtonNode!
    var spell5 : MSButtonNode!
    
    //total gestures in current spell
    var gestureNum = 1
    
    //remaing gesture to draw until cast
    var remainingGestures = 1
    
    //damage of spell
    var damage : Int = 1
    
    
    //reference path for mobs
    let flowerReference = NSBundle.mainBundle().pathForResource( "Flower", ofType: "sks")
    let sproutReference = NSBundle.mainBundle().pathForResource( "Sprout", ofType: "sks")
    let mushroomReference = NSBundle.mainBundle().pathForResource( "Mushroom", ofType: "sks")
    let froguanaReference = NSBundle.mainBundle().pathForResource( "Froguana", ofType: "sks")

    //more or less init stuff
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        score = childNodeWithName("score") as! SKLabelNode
        gesture = childNodeWithName("gesture") as! SKLabelNode
        
        //spells
        spell1 = childNodeWithName("spell1") as! MSButtonNode
        spell1.selectedHandler = {
            if self.gestureNum == 1 {return}
            
            self.buttonDown()
            self.gestureNum = 1
            self.remainingGestures = 1
            self.gesture.text = "\(self.remainingGestures)"
            self.buttonUp()
            
            self.damage = 1
            
        }
        spell2 = childNodeWithName("spell2") as! MSButtonNode
        spell2.selectedHandler = {
            if self.gestureNum == 2 {return}
            
            self.buttonDown()
            self.gestureNum = 2
            self.remainingGestures = 2
            self.gesture.text = "\(self.remainingGestures)"
            self.buttonUp()
            
            self.damage = 3
            
        }
        spell3 = childNodeWithName("spell3") as! MSButtonNode
        spell3.selectedHandler = {
            if self.gestureNum == 3 {return}
            self.buttonDown()

            self.gestureNum = 3
            self.remainingGestures = 3
            self.gesture.text = "\(self.remainingGestures)"
            self.buttonUp()
            
            self.damage = 5
        }
        
        spell4 = childNodeWithName("spell4") as! MSButtonNode
        spell4.selectedHandler = {
            if self.gestureNum == 4 {return}
            self.buttonDown()
            
            self.gestureNum = 4
            self.remainingGestures = 4
            self.gesture.text = "\(self.remainingGestures)"
            self.buttonUp()
            
            self.damage = 7
        }
        
        spell5 = childNodeWithName("spell5") as! MSButtonNode
        spell5.selectedHandler = {
            if self.gestureNum == 5 {return}
            self.buttonDown()
            
            self.gestureNum = 5
            self.remainingGestures = 5
            self.gesture.text = "\(self.remainingGestures)"
            self.buttonUp()
            
            self.damage = 9
        }
        
        spawnFlower()
        
    }
    
    //tab up
    func buttonDown(){
        let button = self.childNodeWithName("spell\(self.gestureNum)")?.position
        self.childNodeWithName("spell\(self.gestureNum)")?.position.y = button!.y - 5
    }
    
    //tabs down
    func buttonUp(){
        let button = self.childNodeWithName("spell\(self.gestureNum)")?.position
        self.childNodeWithName("spell\(self.gestureNum)")?.position.y = button!.y + 5
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
    }
    
    //reduce remaining gestures, if 0 gestures cast a spell and deal damage
    func decrementGesture(){
        remainingGestures -= 1
        if remainingGestures == 0{
            spell()
            dealDamage()
        }
        gesture.text = "\(remainingGestures)"
    }
    
    //displays a spell
    func spell(){
        let spellReference = NSBundle.mainBundle().pathForResource( "Spell\(gestureNum)", ofType: "sks")
        let spell = SKReferenceNode(URL: NSURL (fileURLWithPath: spellReference!))
        
        let entity = entities[0]
        
        spell.position = CGPoint(x: entity.position.x, y: entity.position.y)
        spell.zPosition = 4
        
        spell.xScale = entity.xScale
        spell.yScale = entity.yScale
        addChild(spell)
        let action = SKAction(named: "Spell\(gestureNum)")
        spell.runAction(action!){
            self.childNodeWithName("spell")?.removeFromParent()
        }
    }
    
    //deals damage to the monsters
    func dealDamage(){
        monsters[0].decrementHealth(damage)
    }
    
    //resets the gesture count
    func resetGestures(){
        remainingGestures = gestureNum
        gesture.text = "\(remainingGestures)"
    }
    
    //increase score by one
    func incramentScore(){
        currentScore += 1
        score.text = "\(currentScore)"
    }
    
    //hides gesture image
    func hideImage(shape : String){
        childNodeWithName(shape)?.zPosition = -2
    }
    
    //shows the gesture image
    func showImage(shape: String){
        childNodeWithName(shape)?.zPosition = 2
    }
    
    //spawning functions
    func spawnFlower(){
        let flower = SKReferenceNode(URL: NSURL (fileURLWithPath: flowerReference!))
        flower.position.x = 100
        flower.position.y = 290
        flower.xScale = 0.5
        flower.yScale = 0.5
        flower.zPosition = 2
        
        entities.append(flower)
        monsters.append(Flower(health: 4))
        
        addChild(flower)
    }
   
    override func update(currentTime: CFTimeInterval) {
        
        var count = 0
        if monsters.count > 0{
            for entity in entities{
            
                //if monster health 0 remove from lists and incrament score
                if !monsters[count].isAlive(){
                    entities.removeAtIndex(count)
                    monsters.removeAtIndex(count)
                    entity.removeFromParent()
                    spawnFlower()
                    incramentScore()
                    continue
                }
            
                // some bs limits
                if entity.position.y > 40{
                    entity.position.y -= monsters[count].vy
                }
            
                if entity.position.x > 70 {
                    entity.position.x -= monsters[count].vx
                }
                if entity.xScale < 1{
                    entity.xScale += monsters[count].scale
                    entity.yScale += monsters[count].scale
                }
                count += 1
            }
        }
        
    }
}
