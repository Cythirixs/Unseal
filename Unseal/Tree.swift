//
//  Tree.swift
//  Unseal
//
//  Created by synaptics on 8/2/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

class Tree : Monster{
    
    init(health : Int, type : Int){
        
        super.init(health: health, vy: 0, vx: 0, scale: 0, type: type)
    }
    
    
    
    func changeStage() -> String{
        var random = arc4random_uniform(3) + 1
        
        if health == 2{
            super.setType( Int(random) )
            if random == 3{
                return "TreeForm2"
            }
            else if random == 2{
                return "BlueTreeForm2"
            }
            else{
                return "RedTreeForm2"
            }
        }
        else{
            super.setType( Int(random) )
            if random == 3{
                return "TreeForm3"
            }
            else if random == 2 {
                return "BlueTreeForm3"
            }
            else{
                return "RedTreeForm3"
            }
        }
    }
    
}