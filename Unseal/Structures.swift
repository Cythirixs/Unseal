//
//  Structures.swift
//  Unseal
//
//  Created by synaptics on 7/12/16.
//  Copyright © 2016 Amino. All rights reserved.
//

import Foundation
import UIKit

struct ShapeResult {
    var center: CGPoint
    var radius: CGFloat
    var error: CGFloat
    var j: Int
    
    init() {
        center = CGPointZero
        radius = 0
        error = 0
        j = 0
    }
}