//
//  EmeraldTextFieldStyle.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/6/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public enum EmeraldTextFieldStyle: String, Inspectable {
    case formField
    
    var textColor: UIColor? {
        switch self {
        case .formField:
            return EmeraldTheme.textColor
        }
    }
    
    var font: UIFont? {
        switch self {
        case .formField:
            return Font(size: .h4, weight: .regular).uiFont
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .formField:
            return EmeraldTheme.linkColor
        }
    }

    var IBInspectable: String {
        return rawValue
    }
    
    init(IBInspectable: String) {
        self.init(stringValue: IBInspectable)
    }
}
