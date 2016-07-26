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
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        playButton = self.childNodeWithName("playButton") as! MSButtonNode
        
        /* Setup restart button selection handler */
        playButton.selectedHandler = {
            
           
        }
        
    }
    
}
