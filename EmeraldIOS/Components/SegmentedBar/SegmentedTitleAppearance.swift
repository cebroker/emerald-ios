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
            return EmeraldTheme.extraLightTextColor
        }
    }
    var colorWhenSelected: UIColor {
        switch self {
        case .primary:
            return EmeraldTheme.whiteColor
        }
    }
    
    var IBInspectable: String {
        return rawValue
    }
    
    init(IBInspectable: String) {
        self.init(stringValue: IBInspectable)
    }
}
