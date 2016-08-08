//
//  UserData.swift
//  Unseal
//
//  Created by synaptics on 8/8/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation

class UserData{
    
    var highScore : Int = NSUserDefaults.standardUserDefaults().integerForKey("HighScore") ?? 0 {
        didSet{
            NSUserDefaults.standardUserDefaults().setInteger(highScore, forKey: "HighScore")
            
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
}
