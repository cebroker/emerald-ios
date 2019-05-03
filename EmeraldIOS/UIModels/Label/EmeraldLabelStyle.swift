//
//  EmeraldLabelStyle.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/3/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public enum EmeraldLabelStyle: String, Inspectable {
    case mainTitle
    case subtitle
    case body
    case tableHeader
    case custom
    
    var textColor: UIColor? {
        switch self {
        case .mainTitle:
            return EmeraldTheme.textColor
        case .subtitle:
            return EmeraldTheme.lightTextColor
        case .body:
            return EmeraldTheme.textColor
        case .tableHeader:
            return EmeraldTheme.textColor
        default:
            return nil
        }
    }
    
    var font: UIFont? {
        switch self {
        case .mainTitle:
            return Font(size: .h3, weight: .regular).uiFont
        case .subtitle:
            return Font(size: .h4, weight: .regular).uiFont
        case .body:
            return Font(size: .h4, weight: .regular).uiFont
        case .tableHeader:
            return Font(size: .tableHeader, weight: .bold).uiFont
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
