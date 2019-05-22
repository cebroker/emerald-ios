//
//  EmeraldTextFieldStyle.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/6/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

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
            return Font(size: .h4, weight: .semibold).uiFont
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .formField:
            return EmeraldTheme.primaryColor
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .formField:
            return EmeraldTheme.defaultCornerRadius
        }
    }
    
    var borderColor: CGColor {
        switch self {
        case .formField:
            return EmeraldTheme.borderColor.cgColor
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .formField:
            return EmeraldTheme.defaultBorderWidth
        }
    }
    
    var IBInspectable: String {
        return rawValue
    }
    
    init(IBInspectable: String) {
        self.init(stringValue: IBInspectable)
    }
}
