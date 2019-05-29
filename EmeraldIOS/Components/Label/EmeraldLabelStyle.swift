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
        default:
            return nil
        }
    }
    
    var font: UIFont? {
        switch self {
        case .largeHeader:
            return Font(size: .h1, weight: .semibold).uiFont
        case .mainTitle:
            return Font(size: .h4, weight: .semibold).uiFont
        case .subtitle:
            return Font(size: .h5, weight: .semibold).uiFont
        case .body:
            return Font(size: .h5, weight: .regular).uiFont
        case .bodyBold:
            return Font(size: .h5, weight: .semibold).uiFont
        case .tableHeader:
            return Font(size: .tableHeader, weight: .semibold).uiFont
        case .link:
            return Font(size: .h4, weight: .bold).uiFont
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
