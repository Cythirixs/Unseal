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
    
    var path = CGPathCreateMutable()
    var tolerance:CGFloat = 10
    var fitResult = VResult()
    
    func isV(points : [CGPoint], path : CGMutablePath) -> Bool{
        self.path = path
        fitResult = vDownFit(points)
        if fitResult.qualify {
            return fitResult.error1 <= tolerance && fitResult.error2 <= tolerance && fitResult.direction == -1
        }
        return false
    }
    
}

class VUpGestureRecognizer{
    
    var path = CGPathCreateMutable()
    var tolerance:CGFloat = 10
    var fitResult = VResult()
    
    func isV(points : [CGPoint], path : CGMutablePath) -> Bool{
        self.path = path
        fitResult = vUpFit(points)
        if fitResult.qualify {
            return fitResult.error1 <= tolerance && fitResult.error2 <= tolerance && fitResult.direction == 1
        }
        return false
    }
    
}
