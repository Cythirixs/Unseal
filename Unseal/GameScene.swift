//
//  GameScene.swift
//  Unseal
//
//  Created by synaptics on 7/12/16.
//  Copyright (c) 2016 Amino. All rights reserved.
//

import SpriteKit
import SceneKit

//SAVED 

class GameScene: SKScene {
    
    //labels
    var score : SKLabelNode!
    var health : SKLabelNode!
    var endScore : SKLabelNode!
    
    //current score
    var currentScore = 0
        
    //restart button
    var restart : MSButtonNode!
    var over : SKSpriteNode!
    
    var pause : MSButtonNode!
    var menu : SKSpriteNode!
    
    var block : SKSpriteNode!
    
    var isStopped = false
    
    var reset : MSButtonNode!
    var play : MSButtonNode!
    
    //spell buttons w:60 h:24
    var spell1 : MSButtonNode!
    var spell2 : MSButtonNode!
    var spell3 : MSButtonNode!
    var spell4 : MSButtonNode!
    var spell5 : MSButtonNode!
    
    var spellNum = 2
    
    //damage of spell
    var damage : Int = 1
    
    //mobs
    let entity = EntityManager()
    var monsters = [Monster]()
    
    var redMonsters = [Monster]()
    var blueMonsters = [Monster]()
    var yellowMonsters = [Monster]()
    
    var entities = [SKReferenceNode]()
    
    
    //player hp
    var playerHealth : Int = 3
    var gameOver = false
    
    var fade : SKSpriteNode!
    
    var doRestart = false
    
    //delta
    
    let fixedDelta : CFTimeInterval = 1.0/60.0
    var spawnTimer : CFTimeInterval = 0
    
    //tutorial vars
    var tutorial = false
    
    var spawn = false
    var firstStroke = false
    var secondStoke = false
    var stage2 = false
    

    
    //dissappear
    let disappear = SKAction.fadeAlphaTo(1.0, duration: 0.1)

    //more or less init stuff
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        score = childNodeWithName("score") as! SKLabelNode
        health = childNodeWithName("health") as! SKLabelNode
        fade = childNodeWithName("fade") as! SKSpriteNode
        
        block = childNodeWithName("block") as! SKSpriteNode
        
        //spells
        spell1 = childNodeWithName("spell1_off") as! MSButtonNode
        spell1.selectedHandler = {
            if self.buttonPressed(1){
                self.damage = 1
            }
            
        }
        spell2 = childNodeWithName("spell2_off") as! MSButtonNode
        spell2.selectedHandler = {
            if self.buttonPressed(2){
                self.damage = 1
            }
            
        }
        spell3 = childNodeWithName("spell3_off") as! MSButtonNode
        spell3.selectedHandler = {
            if self.buttonPressed(3){
                self.damage = 1
            }
            
        }
        
        menu = childNodeWithName("menu") as! SKSpriteNode
        
        pause = childNodeWithName("pause") as! MSButtonNode
        pause.selectedHandler = {
            self.isStopped = true
            self.fade.zPosition = 34
            self.menu.position.y -= 350
        }
        
        reset = childNodeWithName("//reset") as! MSButtonNode
        reset.selectedHandler = {
            self.doRestart = true
        }
        play = childNodeWithName("//play") as! MSButtonNode
        play.selectedHandler = {
            self.isStopped = false
            self.fade.zPosition = -2
            self.menu.position.y += 350
        }
        
        over = childNodeWithName("GameOver") as! SKSpriteNode
        
        endScore = childNodeWithName("//EndScore") as! SKLabelNode
        
        restart = childNodeWithName("//restart") as! MSButtonNode
        
        restart.selectedHandler = {
            self.doRestart = true
        }
        beginning()
        
    }
    
    func beginning(){
        let hourglass = childNodeWithName("tutorial") as! SKSpriteNode
        let cursor = childNodeWithName("cursor") as! SKSpriteNode
        
        if !tutorial {
            hourglass.zPosition = -2
            cursor.zPosition = -2
            block.zPosition = -2
            return
        }

        
        if !spawn {
            spawnEye()
            for _ in 1...200{
                entities[0].position.y -= monsters[0].vy
                entities[0].position.x -= monsters[0].vx
                entities[0].xScale += monsters[0].vScale
                entities[0].yScale += monsters[0].vScale

                monsters[0].incramentScale()
                monsters[0].incramentX()
                monsters[0].imcramentY()
            }
            spawn = true
        }
        
        if !firstStroke {
            if !cursor.hasActions(){
                cursor.position = CGPoint(x: 162, y: 320)
                cursor.runAction(SKAction(named: "FingerTrace")!)
            }
        }
        else if !stage2{
            hourglass.zPosition = -4
            cursor.zPosition = -4
            spawnFlower()
            block.zPosition = -3
            for _ in 1...200{
                entities[0].position.y -= monsters[0].vy
                entities[0].position.x -= monsters[0].vx
                entities[0].xScale += monsters[0].vScale
                entities[0].yScale += monsters[0].vScale
                
                monsters[0].incramentScale()
                monsters[0].incramentX()
                monsters[0].imcramentY()
            }
            stage2 = true
        }
        if stage2 {
        
            cursor.position = CGPoint(x: 58, y: 140)
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
        self.childNodeWithName("spell\(self.spellNum)_on")?.zPosition = -2
        self.childNodeWithName("spell\(self.spellNum)_off")?.zPosition = 2

    }
    
    //tabs down
    func buttonUp(){
        self.childNodeWithName("spell\(self.spellNum)_on")?.zPosition = 2
        self.childNodeWithName("spell\(self.spellNum)_off")?.zPosition = -2

    }
    
    func buttonPressed(spell : Int) -> Bool{
        if spellNum == spell {return false}
        buttonDown()
        spellNum = spell
        buttonUp()
        return true
    }
    
    
    //reduce remaining gestures, if 0 gestures cast a spell and deal damage
    func decrementGesture(){
        if monsters.count > 0 && entities.count > 0{
            dealDamage()
        }
    }
    
    //displays a spell
    func spell(entity : Monster){
        let spellReference = NSBundle.mainBundle().pathForResource( "Spell\(spellNum)", ofType: "sks")
        let spell = SKReferenceNode(URL: NSURL (fileURLWithPath: spellReference!))
        
        spell.position = CGPoint(x: entity.x - 35, y: entity.y - 35 )
        spell.zPosition = 32
        
        spell.xScale = entity.scale
        spell.yScale = entity.scale
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
            spell(monsters[0])
            removeAtZero()
            redMonsters.removeAtIndex(0)
            secondStoke = true
            return
        }
        else if tutorial && spellNum == 2 && !firstStroke{
            spell(monsters[0])
            firstStroke = true
            removeAtZero()
            blueMonsters.removeAtIndex(0)
            return
        }
        else if tutorial{
            return
        }


        var initialized = true
        var array = [Monster]()
        if redMonsters.count > 0 && spellNum == 1{
            array = redMonsters
        }
        else if blueMonsters.count > 0 && spellNum == 2{
            array = blueMonsters
        }
        else if yellowMonsters.count > 0 && spellNum == 3{
            array = yellowMonsters
        }
        else{
            initialized = false
        }
        if initialized{
            var count = 0
            var index = 0
            var smallest : CGFloat = 769
            var monster = Monster()
            for mob in array{
                if mob.y < smallest {
                    smallest = mob.y
                    monster = mob
                    index = count
                }
                count += 1
            }
            monster.decrementHealth(1)
            spell(monster)
            if !monster.isAlive(){
                
                if spellNum == 1{
                    redMonsters.removeAtIndex(index)
                }
                else if spellNum == 2{
                    blueMonsters.removeAtIndex(index)
                }
                else {
                    yellowMonsters.removeAtIndex(index)
                }
                
            }
        }
    }
    
    func removeAtZero(){
        entities[0].removeFromParent()
        monsters.removeAtIndex(0)
        entities.removeAtIndex(0)
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
        childNodeWithName(shape)?.zPosition = 32
    }
    
    //spawning functions
    
    func spawnSprout(){
        let sprout : (SKReferenceNode, Monster)
        
        let random = arc4random_uniform(2)
        if random == 0{
            sprout = entity.spawnRedSprout()
        }
        else{
            sprout = entity.spawnBlueSprout()
        }
        entities.append(sprout.0)
        monsters.append(sprout.1)
        addToArray(sprout.1)
        
        sprout.0.zPosition = CGFloat(30 - entities.count)
        addChild(sprout.0)
    }
    func spawnFlower(){
        let flower : (SKReferenceNode, Monster)
        
        if tutorial {
            flower = entity.spawnRedFlower()
        }
        else{
            let random = arc4random_uniform(3)
            if random == 0{
                flower = entity.spawnRedFlower()
            }
            else if random == 1 {
                flower = entity.spawnBlueFlower()
            }
            else{
                flower = entity.spawnYellowFlower()
            }
        }
        
        entities.append(flower.0)
        monsters.append(flower.1)
        addToArray(flower.1)
        
        flower.0.zPosition = CGFloat(30 - entities.count)
        addChild(flower.0)
    }
    func spawnMushroom(){
        let mushroom : (SKReferenceNode, Monster)
        let random = arc4random_uniform(2)
        if random == 0 {
            mushroom = entity.spawnRedMushroom()
        }
        else {
            mushroom = entity.spawnBlueMushroom()
        }
        
        entities.append(mushroom.0)
        monsters.append(mushroom.1)
        addToArray(mushroom.1)
        
        mushroom.0.zPosition = CGFloat(30 - entities.count)
        addChild(mushroom.0)
    }
    func spawnEye(){
        let eye : (SKReferenceNode, Monster)
        if tutorial {
            eye = entity.spawnBlueEye()
        }
        else{
            let random = arc4random_uniform(2)
            if random == 0{
                eye = entity.spawnBlueEye()
            }
            else {
                eye = entity.spawnYellowEye()
            }
        }
        entities.append(eye.0)
        monsters.append(eye.1)
        addToArray(eye.1)

        eye.0.zPosition = CGFloat(30 - entities.count)
        addChild(eye.0)
    }
    
    func spawnSpider(){
        let spider : (SKReferenceNode, Monster)
        
        let random = arc4random_uniform(2)
        if random == 0{
            spider = entity.spawnBlueSpider()
        }
        else {
            spider = entity.spawnYellowSpider()
        }
        
        entities.append(spider.0)
        monsters.append(spider.1)
        addToArray(spider.1)
        
        spider.0.zPosition = CGFloat(30 - entities.count)
        addChild(spider.0)
    }
    
    func spawnFrog(){
        let frog = entity.spawnBlueFrog()
        
        entities.append(frog.0)
        monsters.append(frog.1)
        addToArray(frog.1)
        
        frog.0.zPosition = CGFloat(30 - entities.count)
        addChild(frog.0)
    }

    
    func addToArray(entity : Monster){
        if entity.type == 1{
            redMonsters.append(entity)
        }
        else if entity.type == 2 {
            blueMonsters.append(entity)
        }
        else{
            yellowMonsters.append(entity)
        }
    }
    
    func randomizeSpawn(){
        let random = arc4random_uniform(100)
        if random < 20 { spawnSprout() }
        else if random < 40 { spawnFlower() }
        else if random < 60 { spawnEye() }
        else if random < 80{ spawnSpider() }
        else if random < 100 { spawnMushroom() }
    }
    
    override func update(currentTime: CFTimeInterval) {
        if gameOver || isStopped { return }
        if tutorial {
            beginning()
            return
        }
        var count = 0
        if monsters.count > 0{
            for entity in entities{
                
                if !monsters[count].isAlive() {
                    
                    entities.removeAtIndex(count)
                    monsters.removeAtIndex(count)
                    
                    entity.runAction(disappear){
                        entity.removeFromParent()
                    }
                    incramentScore()
                    continue
                }
                if entity.position.y > 100{
                        entity.position.y -= monsters[count].vy
                        monsters[count].imcramentY()
                    }
                    else{
                        monsters[count].tickAttack(fixedDelta)
                        if monsters[count].attackTimer >= 1.5{
                            playerDamage()
                            monsters[count].attackTimer = 0
                            if playerHealth <= 0{
                            gameOver = true
                            fade.zPosition = 34
                            over.position.x += 274
                                endScore.text = "\(currentScore)"
                            }
                        }
                    }
            
                    if entity.position.x > 40 {
                        entity.position.x -= monsters[count].vx
                        monsters[count].incramentX()
                    }
                        if entity.xScale < 1{
                            entity.xScale += monsters[count].vScale
                            entity.yScale += monsters[count].vScale
                        monsters[count].incramentScale()
                    }
                
                count += 1
            }
        }
        
        spawnTimer += fixedDelta
        
        let difficult =  Int( Double(currentScore) / 10 )
        var timer = CFTimeInterval( 4 - difficult )
        
        if difficult > 3 {
            timer = 1.5
        }
       
        
        if spawnTimer >= timer{
            spawnMushroom()
            spawnTimer = 0
        }
    }
}






