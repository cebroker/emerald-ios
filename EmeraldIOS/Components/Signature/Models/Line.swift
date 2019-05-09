/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Contains the `Line` and `LinePoint` types used to represent and draw lines derived from touches.
 */

import UIKit

struct Line {
    let strokeWidth: Float
    let color: UIColor
    var points: [CGPoint]
}
