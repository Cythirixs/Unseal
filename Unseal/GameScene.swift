//
//  GameScene.swift
//  Unseal
//
//  Created by synaptics on 7/12/16.
//  Copyright (c) 2016 Amino. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var score : SKLabelNode!
    
    var circle : SKSpriteNode!
    var horizontal : SKSpriteNode!
    var vertical : SKSpriteNode!
    var vUp : SKSpriteNode!
    var vDown : SKSpriteNode!
    var leaf : SKSpriteNode!
    var hourglass : SKSpriteNode!

    
    var currentScore = 0
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        score = childNodeWithName("score") as! SKLabelNode
        
        circle = childNodeWithName("circle") as! SKSpriteNode
        horizontal = childNodeWithName("horizontal") as! SKSpriteNode
        vertical = childNodeWithName("vertical") as! SKSpriteNode
        vUp = childNodeWithName("vUp") as! SKSpriteNode
        vDown = childNodeWithName("vDown") as! SKSpriteNode
        leaf = childNodeWithName("leaf") as! SKSpriteNode
        hourglass = childNodeWithName("hourglass") as! SKSpriteNode

        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
    }
    
    func incramentScore(){
        currentScore += 1
        score.text = "\(currentScore)"
    }
    
    func hideImage(shape : String){
        childNodeWithName(shape)?.zPosition = -2
    }
    
    func showImage(shape: String){
        childNodeWithName(shape)?.zPosition = 2
    }
   
    override func update(currentTime: CFTimeInterval) {
       
    }
}
