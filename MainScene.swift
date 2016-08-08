//
//  MainMenu.swift
//  Unseal
//
//  Created by synaptics on 7/25/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import SpriteKit

class MainScene: SKScene {
    
    /* UI Connections */
    var playButton: MSButtonNode!
    var creditButton : MSButtonNode!
    
    var credits : SKSpriteNode!
    var back : MSButtonNode!
    var next : MSButtonNode!
    
    var thanks : SKSpriteNode!
    var backthanks : MSButtonNode!
    
    var gameStart = false
    
    var bottom : SKSpriteNode!
    var top : SKSpriteNode!
    var logo : SKSpriteNode!
    var eye : SKSpriteNode!
    var eyeEnd : SKSpriteNode!
    
    var timer : NSTimer!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        credits = childNodeWithName("credits") as! SKSpriteNode
        thanks = childNodeWithName("thanks") as! SKSpriteNode
        
        /* Set UI connections */
        
        bottom = childNodeWithName("menu bottom") as! SKSpriteNode
        top = childNodeWithName("menu top") as! SKSpriteNode
        logo = childNodeWithName("logo") as! SKSpriteNode
        eye = childNodeWithName("eye") as! SKSpriteNode
        eyeEnd = childNodeWithName("eyeEnd") as! SKSpriteNode
        
        bottom.runAction(SKAction(named: "RightMoveIn")!)
        top.runAction(SKAction(named: "LeftMoveIn")!)
        eyeEnd.runAction(SKAction(named : "MenuStart")!)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2.9, target: self, selector: "logo:", userInfo: nil, repeats: false)
        
        playButton = childNodeWithName("//play") as! MSButtonNode

        /* Setup restart button selection handler */
        playButton.selectedHandler = {
            self.gameStart = true
            self.bottom.runAction(SKAction(named: "LeftMoveOut")!)
            self.top.runAction(SKAction(named: "RightMoveOut")!)
            self.eye.zPosition = 4
            self.eye.runAction(SKAction(named: "MenuSpell")!)
            self.logo.runAction(SKAction.fadeAlphaTo(0, duration: 1.10))
        }
        
        creditButton = childNodeWithName("creditsButton") as! MSButtonNode
        creditButton.selectedHandler = {
            self.credits.position.x -= 315
        }

        back = childNodeWithName("//back") as! MSButtonNode
        back.selectedHandler = {
            self.credits.position.x += 315
        }
        
        next = childNodeWithName("//next") as! MSButtonNode
        next.selectedHandler = {
            self.thanks.position.x -= 295
        }
        backthanks = childNodeWithName("//backthanks") as! MSButtonNode
        backthanks.selectedHandler = {
            self.thanks.position.x += 295
        }
        
        
    }
    
    func logo(timer : NSTimer){
        logo.zPosition = -1
    }
    
}
