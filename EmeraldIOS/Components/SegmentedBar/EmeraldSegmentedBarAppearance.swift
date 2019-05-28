//
//  EmeraldSegmentedBarAppearance.swift
//  EmeraldIOS
//
//  Created by Felipe Correa on 5/23/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public enum EmeralSegmentedBarStyle: String, Inspectable {
    case primary
    
    var backgroundColor: UIColor {
        switch self {
        case .primary:
            return EmeraldTheme.secondaryColor
        }
    }
    
    var selectionBarColor: UIColor {
        switch self {
        case .primary:
            return EmeraldTheme.greenColor
        }
    }
    
    var titlesStyle: SegmentedTitleStyle {
        switch self {
        case .primary:
            return .primary
        }
    }
    
    var IBInspectable: String {
        return rawValue
    }
    
    init(IBInspectable: String) {
        self.init(stringValue: IBInspectable)
    }
}
