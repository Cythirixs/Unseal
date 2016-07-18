//
//  InfinityGestureRecognizer.swift
//  Unseal
//
//  Created by synaptics on 7/14/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

class InfinityGestureRecognizer {

    let circleTolerance:CGFloat = 0.4
    let tolerance:CGFloat = 8
    
    let vTolerance:CGFloat = 10
    
    var fitResult = InfinityResult()
    
    func isInfinity(points: [CGPoint]) -> Bool{
        
        fitResult = fitInfinity(points)
        
        return fitResult.circleError < circleTolerance && fitResult.error1 < tolerance && fitResult.error2 < vTolerance &&
        fitResult.error3 < vTolerance
    }
    
}