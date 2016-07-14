//
//  SigmaGestureRecognizer.swift
//  Unseal
//
//  Created by synaptics on 7/14/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

class SigmaGestureRecognizer{
    
    var path = CGPathCreateMutable()
    var fitResult = SigmaResult()
    
    func isSigma(points : [CGPoint], path : CGMutablePath) -> Bool{
        return false
    }
    
}