//
//  VGestureRecognition.swift
//  Unseal
//
//  Created by synaptics on 7/14/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

class VDownGestureRecognizer{
    
    var tolerance:CGFloat = 15
    var fitResult = VResult()
    
    func isV(points : [CGPoint]) -> Bool{
        fitResult = vDownFit(points)
        if fitResult.qualify {
            return fitResult.error1 <= tolerance && fitResult.error2 <= tolerance && fitResult.direction == -1
        }
        return false
    }
    
}

class VUpGestureRecognizer{
    
    var tolerance:CGFloat = 10
    var fitResult = VResult()
    
    func isV(points : [CGPoint]) -> Bool{
        fitResult = vUpFit(points)
        if fitResult.qualify {
            return fitResult.error1 <= tolerance && fitResult.error2 <= tolerance && fitResult.direction == 1
        }
        return false
    }
    
}
