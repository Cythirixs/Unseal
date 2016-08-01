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
    var optionButton : MSButtonNode!
    var creditButton : MSButtonNode!
    
    var credits : SKSpriteNode!
    var back : MSButtonNode!
    
    var gameStart = false
    
    var eyes : SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        credits = childNodeWithName("credits") as! SKSpriteNode
        
        /* Set UI connections */
        playButton = childNodeWithName("play") as! MSButtonNode
                
        /* Setup restart button selection handler */
        playButton.selectedHandler = {
            self.gameStart = true
        }
        
        creditButton = childNodeWithName("creditsButton") as! MSButtonNode
        creditButton.selectedHandler = {
            self.credits.position.x -= 180
        }
        
        back = childNodeWithName("back") as! MSButtonNode
        back.selectedHandler = {
            self.credits.position.x += 180
        }
        
        
    }
    
}
