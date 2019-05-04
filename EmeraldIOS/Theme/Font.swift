//
//  Font.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/3/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public enum OpenSansFonts: String, CaseIterable {
    case Light = "OpenSans-Light"
    case Regular = "OpenSans-Regular"
    case SemiBold = "OpenSans-SemiBold"
    case Bold = "OpenSans-Bold"
}

public enum FontSize: String, Inspectable {
    case h1
    case h2
    case h3
    case h4
    case h5
    case h6
    case navigationTitleText
    case body
    case button
    case smallButton
    case largeButton
    case label
    case tableHeader
    
    var IBInspectable: String {
        return rawValue
    }
    
    init(IBInspectable: String) {
        self.init(stringValue: IBInspectable)
    }
    
    var cgFontSize: CGFloat {
        switch self {
        case .h1:
            return 30
        case .h2:
            return 24
        case .h3:
            return 16
        case .h4:
            return 14
        case .h5:
            return 12
        case .h6:
            return 9
        case .body:
            return 16
        case .navigationTitleText:
            return 17
        case .button:
            return 18
        case .smallButton:
            return 12
        case .largeButton:
            return 20
        case .label:
            return UIFont.labelFontSize
        case .tableHeader:
            return 14
        }
    }
    
    static func cgFontSize(_ IBInspectable: InspectableType) -> CGFloat {
        return FontSize(IBInspectable: IBInspectable).cgFontSize
    }
}

public enum FontWeight: String, Inspectable {
    case light
    case regular
    case semibold
    case bold
    
    var IBInspectable: String {
        return rawValue
    }
    
    init(IBInspectable: String) {
        self.init(stringValue: IBInspectable)
    }
}

public struct Font {
    let size: FontSize
    let weight: FontWeight
    
    var uiFont: UIFont {
        var customFont: UIFont? {
            switch weight {
            case .light:
                return UIFont(name: OpenSansFonts.Light.rawValue,
                              size: size.cgFontSize)
            case .regular:
                return UIFont(name: OpenSansFonts.Regular.rawValue,
                              size: size.cgFontSize)
            case .semibold:
                return UIFont(name: OpenSansFonts.SemiBold.rawValue,
                              size: size.cgFontSize)
            case .bold:
                return UIFont(name: OpenSansFonts.Bold.rawValue,
                              size: size.cgFontSize)
            }
        }
        
        var systemFont: UIFont {
            switch weight {
            case .light:
                return UIFont.systemFont(ofSize: size.cgFontSize, weight: .light)
            case .regular:
                return UIFont.systemFont(ofSize: size.cgFontSize, weight: .regular)
            case .semibold:
                return UIFont.systemFont(ofSize: size.cgFontSize, weight: .semibold)
            case .bold:
                return UIFont.systemFont(ofSize: size.cgFontSize, weight: .bold)
            }
        }
        
        return customFont ?? systemFont
    }
}
