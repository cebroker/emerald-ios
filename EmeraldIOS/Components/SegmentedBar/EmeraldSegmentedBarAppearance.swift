//
//  EmeraldSegmentedBarAppearance.swift
//  EmeraldIOS
//
//  Created by Felipe Correa on 5/23/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public struct EmeraldSegmentedBarAppearance {
    var backgroundColor: UIColor
    var selectionBarColor: UIColor
    
    public init(backgroundColor: UIColor, selectionBarColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.selectionBarColor = selectionBarColor
    }
}
