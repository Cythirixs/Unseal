//
//  HourglassGestureRecognizer.swift
//  Unseal
//
//  Created by synaptics on 7/13/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

class HourglassGestureRecognizer{
 
    var path = CGPathCreateMutable()
    var fitResult = HourglassResult()
    
    func isHourglass(points: [CGPoint], path: CGMutablePath) -> Bool{
        return false
    }
    
}