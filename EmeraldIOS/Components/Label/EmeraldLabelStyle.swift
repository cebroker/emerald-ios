//
//  EmeraldLabelStyle.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/3/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public enum EmeraldLabelStyle: String, Inspectable {
    case largeHeader
    case mainTitle
    case subtitle
    case body
    case bodyBold
    case tableHeader
    case link
    case custom
    case warning
    
    var textColor: UIColor? {
        switch self {
        case .largeHeader:
            return EmeraldTheme.textColor
        case .mainTitle:
            return EmeraldTheme.textColor
        case .subtitle:
            return EmeraldTheme.lightTextColor
        case .body:
            return EmeraldTheme.textColor
        case .bodyBold:
            return EmeraldTheme.textColor
        case .tableHeader:
            return EmeraldTheme.darkTextColor
        case .link:
            return EmeraldTheme.primaryColor
        case .warning:
            return EmeraldTheme.whiteColor
        default:
            return nil
        }
    }
    
    var font: UIFont? {
        switch self {
        case .largeHeader:
            return Typography(size: .h1, weight: .semibold).uiFont
        case .mainTitle:
            return Typography(size: .h4, weight: .semibold).uiFont
        case .subtitle:
            return Typography(size: .h5, weight: .semibold).uiFont
        case .body:
            return Typography(size: .body, weight: .regular).uiFont
        case .bodyBold:
            return Typography(size: .h5, weight: .semibold).uiFont
        case .tableHeader:
            return Typography(size: .tableHeader, weight: .semibold).uiFont
        case .link:
            return Typography(size: .h4, weight: .bold).uiFont
        case .warning:
            return Typography(size: .h6, weight: .regular).uiFont
        default:
            return nil
        }
    }
    
    var IBInspectable: String {
        return rawValue
    }
    
    init(IBInspectable: String) {
        self.init(stringValue: IBInspectable)
    }
}
