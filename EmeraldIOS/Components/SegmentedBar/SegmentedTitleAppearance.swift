//
//  SegmentedTitleAppearance.swift
//  EmeraldIOS
//
//  Created by Felipe Correa on 5/23/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public enum SegmentedTitleStyle: String, Inspectable {
    case primary
    
    var fontWhenHighlighted: UIFont {
        switch self {
        case .primary:
            return Font(size: .h4, weight: .regular).uiFont
        }
    }
    var fontWhenSelected: UIFont {
        switch self {
        case .primary:
            return Font(size: .h4, weight: .regular).uiFont
        }
    }
    var colorWhenHighlighted: UIColor {
        switch self {
        case .primary:
            return UIColor.white.withAlphaComponent(0.59)
        }
    }
    var colorWhenSelected: UIColor {
        switch self {
        case .primary:
            return .white
        }
    }
    
    var IBInspectable: String {
        return rawValue
    }
    
    init(IBInspectable: String) {
        self.init(stringValue: IBInspectable)
    }
}
