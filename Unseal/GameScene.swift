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
    var health : SKLabelNode!
    
    //current score
    var currentScore = 0
    
    //reference and information of monsters in 2 arrays
    var entities = [SKReferenceNode]()
    var monsters = [Monster]()
    
    var shapes = [SKShapeNode]()
    
    //restart button
    var restart : MSButtonNode!
    var pause : MSButtonNode!
    
    //spell buttons w:60 h:24
    var spell1 : MSButtonNode!
    var spell2 : MSButtonNode!
    var spell3 : MSButtonNode!
    var spell4 : MSButtonNode!
    var spell5 : MSButtonNode!
    
    var spellNum = 2
    
    
    //total gestures in current spell
    
    //remaing gesture to draw until cast
    var remainingGestures = 1
    
    //damage of spell
    var damage : Int = 1
    
    //player hp
    var playerHealth : Int = 3
    var gameOver = false
    var doRestart = false
    
    //delta
    
    let fixedDelta : CFTimeInterval = 1.0/60.0
    var spawnTimer : CFTimeInterval = 0
    
    var tutorial = true
    
    var spawn = false
    var firstStroke = false
    var secondStoke = false
    var stage2 = false
    
    //reference path for mobs
    let redReference = NSBundle.mainBundle().pathForResource( "red", ofType: "sks")
    let blueReference = NSBundle.mainBundle().pathForResource( "blue", ofType: "sks")
    let yellowReference = NSBundle.mainBundle().pathForResource( "yellow", ofType: "sks")
    
    //dissappear
    let disappear = SKAction.fadeAlphaTo(1.0, duration: 0.1)

    //more or less init stuff
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        score = childNodeWithName("score") as! SKLabelNode
        gesture = childNodeWithName("gesture") as! SKLabelNode
        health = childNodeWithName("health") as! SKLabelNode
        
        //spells
        spell1 = childNodeWithName("spell1") as! MSButtonNode
        spell1.selectedHandler = {
            if self.buttonPressed(1){
                self.damage = 1
            }
            
        }
        spell2 = childNodeWithName("spell2") as! MSButtonNode
        spell2.selectedHandler = {
            if self.buttonPressed(2){
                self.damage = 1
            }
            
        }
        spell3 = childNodeWithName("spell3") as! MSButtonNode
        spell3.selectedHandler = {
            if self.buttonPressed(3){
                self.damage = 1
            }
            
        }
        
        spell4 = childNodeWithName("spell4") as! MSButtonNode
        spell4.selectedHandler = {
            if self.buttonPressed(4){
                self.damage = 7
            }
        }
        
        spell5 = childNodeWithName("spell5") as! MSButtonNode
        spell5.selectedHandler = {
            if self.buttonPressed(5){
                self.damage = 9
            }
        }
        
        restart = childNodeWithName("restart") as! MSButtonNode
        restart.state = .Hidden
        
        pause = childNodeWithName("pause") as! MSButtonNode
        pause.selectedHandler = {
            
        }
        
        //randomizeSpawn()
        beginning()
        
    }
    
    func beginning(){
        let hourglass = childNodeWithName("tutorial") as! SKSpriteNode
        let cursor = childNodeWithName("cursor") as! SKSpriteNode
        
        if !spawn {
            spawnBlue()
            spawn = true
        }
        
        if !firstStroke {
            if !cursor.hasActions(){
                cursor.position = CGPoint(x: 162, y: 265)
                cursor.runAction(SKAction(named: "FingerTrace")!)
            }
        }
        else if !stage2{
            hourglass.zPosition = -4
            cursor.zPosition = -4
            spawnRed()
            stage2 = true
        }
        if stage2 {
        
            cursor.position = CGPoint(x: 45, y: 95)
            cursor.yScale = -0.493
            
            cursor.zPosition = 4
            if secondStoke{
                tutorial = false
                cursor.zPosition = -4
            }
        }
    }
    
    //tab up
    func buttonDown(){
        let button = self.childNodeWithName("spell\(self.spellNum)")?.position
        self.childNodeWithName("spell\(self.spellNum)")?.position.y = button!.y - 8
    }
    
    //tabs down
    func buttonUp(){
        let button = self.childNodeWithName("spell\(self.spellNum)")?.position
        self.childNodeWithName("spell\(self.spellNum)")?.position.y = button!.y + 8
    }
    
    func buttonPressed(spell : Int) -> Bool{
        if spellNum == spell {return false}
        buttonDown()
        spellNum = spell
        remainingGestures = 1
        gesture.text = "\(self.remainingGestures)"
        buttonUp()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
    }
    
    //reduce remaining gestures, if 0 gestures cast a spell and deal damage
    func decrementGesture(){
        remainingGestures -= 1
        if remainingGestures <= 0{
            if monsters.count > 0 && entities.count > 0{
                spell()
                dealDamage()
            }
        }
        if remainingGestures < 0 { remainingGestures = 0}
        gesture.text = "\(remainingGestures)"
    }
    
    //displays a spell
    func spell(){
        let spellReference = NSBundle.mainBundle().pathForResource( "Spell\(spellNum)", ofType: "sks")
        let spell = SKReferenceNode(URL: NSURL (fileURLWithPath: spellReference!))
        
        let entity = entities[0]
        
        spell.position = CGPoint(x: entity.position.x - 35, y: entity.position.y - 35 )
        spell.zPosition = 4
        
        spell.xScale = entity.xScale
        spell.yScale = entity.yScale
        addChild(spell)
        let action = SKAction(named: "Spell\(spellNum)")
        spell.runAction(action!){
            self.childNodeWithName("spell")?.removeFromParent()
        }
    }
    
    func playerDamage(){
        playerHealth -= 1
        health.text = "\(playerHealth)"
    }
    
    //deals damage to the monsters
    func dealDamage(){
        if tutorial && firstStroke && spellNum == 1{
            secondStoke = true
        }
        else if tutorial {
            firstStroke = true
        }
        if spellNum == 5{
            for mob in monsters{
                mob.decrementHealth(damage)
            }
        }
        let mob = monsters[0]
        if spellNum == mob.type{
            mob.decrementHealth(damage)
        }
    }
    
    //resets the gesture count
    func resetGestures(){
        remainingGestures = 1
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
    
    func spawnBlue(){
        let blue = SKReferenceNode(URL: NSURL (fileURLWithPath: blueReference!))
        blue.position.x = 100
        blue.position.y = 290
        blue.xScale = 0.5
        blue.yScale = 0.5
        
        entities.append(blue)
        monsters.append(Sprout(health: 1, type: 2))
        
        blue.zPosition = CGFloat(30 - monsters.count)
        
        addChild(blue)
    }
    
    func spawnRed(){
        let red = SKReferenceNode(URL: NSURL (fileURLWithPath: redReference!))
        red.position.x = 100
        red.position.y = 290
        red.xScale = 0.5
        red.yScale = 0.5
        
        entities.append(red)
        monsters.append(Flower(health: 1, type : 1))
        red.zPosition = CGFloat(30 - monsters.count)
        
        addChild(red)
    }
    
    func spawnYellow(){
        let yellow = SKReferenceNode(URL: NSURL (fileURLWithPath: yellowReference!))
        yellow.position.x = 100
        yellow.position.y = 290
        yellow.xScale = 0.5
        yellow.yScale = 0.5
        
        entities.append(yellow)
        monsters.append(Mushroom(health: 1, type : 3))
        
        yellow.zPosition = CGFloat(30 - monsters.count)
        
        addChild(yellow)
    }
    
    func randomizeSpawn(){
        let random = arc4random_uniform(100)
        if random < 33 { spawnRed() }
        else if random < 66 { spawnYellow() }
        else if random <= 99 { spawnBlue() }
    }
    
    override func update(currentTime: CFTimeInterval) {
        if gameOver { return }
        if tutorial {
            beginning()
            return
        }
        
        var count = 0
        if monsters.count > 0{
            for entity in entities{
            
                //if monster health 0 remove from lists and incrament score
                if !monsters[count].isAlive(){
                    entities.removeAtIndex(count)
                    monsters.removeAtIndex(count)
                    entity.runAction(disappear){
                        entity.removeFromParent()
                    }
                    incramentScore()
                    continue
                }
            
                // some bs limits
                if entity.position.y > 40{
                    entity.position.y -= monsters[count].vy
                }
                else{
                    monsters[count].tickAttack(fixedDelta)
                    if monsters[count].attackTimer >= 1.5{
                        playerDamage()
                        monsters[count].attackTimer = 0
                        if playerHealth <= 0{
                            gameOver = true
                            restart.state = .Active
                        }
                    }
                }
            
                if entity.position.x > 40 {
                    entity.position.x -= monsters[count].vx
                }
                if entity.xScale < 1{
                    entity.xScale += monsters[count].scale
                    entity.yScale += monsters[count].scale
                }
                count += 1
            }
        }
        
        spawnTimer += fixedDelta
        
        let difficult =  Int( Double(currentScore) / 10 )
        var timer = CFTimeInterval( 4 - difficult )
        
        if difficult > 3 {
            timer = 1
        }
       
        
        if spawnTimer >= timer{
            randomizeSpawn()
            spawnTimer = 0
        }
    }
}






