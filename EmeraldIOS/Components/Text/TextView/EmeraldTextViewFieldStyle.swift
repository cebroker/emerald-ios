//
//  EmeraldTextViewFieldStyle.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public enum EmeraldTextViewFieldStyle: String, Inspectable {
    case formField
    case custom
    
    var textColor: UIColor? {
        switch self {
        case .formField:
            return EmeraldTheme.textColor
        default:
            return nil
        }
    }
    
    var font: UIFont? {
        switch self {
        case .formField, .custom:
            return Typography(size: .h5, weight: .semibold).uiFont
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .formField:
            return EmeraldTheme.primaryColor
        default:
            return EmeraldTheme.blackColor
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .formField:
            return EmeraldTheme.defaultCornerRadius
        default:
            return EmeraldTheme.withoutCornerRadius
        }
    }
    
    var borderColor: CGColor {
        switch self {
        case .formField:
            return EmeraldTheme.borderColor.cgColor
        default:
            return UIColor.clear.cgColor
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .formField:
            return EmeraldTheme.defaultBorderWidth
        default:
            return EmeraldTheme.simpleBorderWidth
        }
    }
    
    var IBInspectable: String {
        return rawValue
    }
    
    init(IBInspectable: String) {
        self.init(stringValue: IBInspectable)
    }
}
