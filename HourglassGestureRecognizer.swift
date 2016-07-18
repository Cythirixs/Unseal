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
 
    var fitResult = HourglassResult()
    
    var tolerance:CGFloat = 15
    
    func isHourglass(points: [CGPoint]) -> Bool{
        
        fitResult = HourglassFit(points)
        
        return fitResult.vertError < tolerance && fitResult.diagError < tolerance && fitResult.horizError < tolerance
    }
    
}