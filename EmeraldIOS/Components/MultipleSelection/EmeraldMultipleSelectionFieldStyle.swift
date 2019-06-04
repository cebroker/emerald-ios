//
//  EmeraldMultipleSelectionFieldStyle.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public enum EmeraldMultipleSelectionFieldStyle: String, Inspectable {
    case simple
    case bordered
    
    var textColor: UIColor? {
        switch self {
        case .simple, .bordered:
            return EmeraldTheme.textColor
        }
    }
    
    var font: UIFont? {
        switch self {
        case .simple, .bordered:
            return Font(size: .h5, weight: .semibold).uiFont
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .simple, .bordered:
            return EmeraldTheme.primaryColor
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .simple, .bordered:
            return EmeraldTheme.defaultCornerRadius
        }
    }
    
    var borderColor: CGColor {
        switch self {
        case .simple:
            return EmeraldTheme.borderColor.cgColor
        case .bordered:
            return EmeraldTheme.primaryColor.cgColor
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .simple:
            return EmeraldTheme.simpleBorderWidth
        case .bordered:
            return EmeraldTheme.selectableBorderWidth
        }
    }
    
    var IBInspectable: String {
        return rawValue
    }
    
    init(IBInspectable: String) {
        self.init(stringValue: IBInspectable)
    }
}
