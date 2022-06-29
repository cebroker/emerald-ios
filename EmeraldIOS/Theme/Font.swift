//
//  Font.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/3/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import SwiftUI
import UIKit

public enum OpenSansFonts: String, CaseIterable {
    case Light = "OpenSans-Light"
    case Regular = "OpenSans-Regular"
    case SemiBold = "OpenSans-SemiBold"
    case Bold = "OpenSans-Bold"
    case italic = "OpenSans-Italic"
    case BoldItalic = "OpenSans-BoldItalic"
    case LightItalic = "OpenSans-LightItalic"
}

public enum FontSize: String, Inspectable {
    case h1
    case h2
    case h3
    case h4
    case h5
    case h6
    case h7
    case navigationTitleText
    case body
    case button
    case linkButton
    case smallButton
    case largeButton
    case label
    case tableHeader
    case bodyItalic
    case linkItalic
    case linkBold
    case titleBold
    case titleItalic

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
            return 18
        case .h4:
            return 16
        case .h5:
            return 14
        case .h6:
            return 12
        case .h7:
            return 9
        case .body:
            return 16
        case .navigationTitleText:
            return 17
        case .button:
            return 18
        case .linkButton:
            return 16
        case .smallButton:
            return 14
        case .largeButton:
            return 20
        case .label:
            return UIFont.labelFontSize
        case .tableHeader:
            return 14
        case .bodyItalic:
            return 14
        case .titleBold:
            return 16
        case .linkItalic:
            return 14
        case .linkBold:
            return 16
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
    case bold_italic
    case italic
    case light_italic
    case link_italic
    case link_bold
    case title_bold
    case body_italic
    
    var IBInspectable: String {
        return rawValue
    }

    init(IBInspectable: String) {
        self.init(stringValue: IBInspectable)
    }
}

public struct Typography {
    let size: FontSize
    let weight: FontWeight

    public init(size: FontSize, weight: FontWeight) {
        self.size = size
        self.weight = weight
    }

    public var uiFont: UIFont {
        var customFont: UIFont? {
            switch weight {
            case .light:
                return UIFont(
                    name: OpenSansFonts.Light.rawValue,
                    size: size.cgFontSize)
            case .regular:
                return UIFont(
                    name: OpenSansFonts.Regular.rawValue,
                    size: size.cgFontSize)
            case .semibold:
                return UIFont(
                    name: OpenSansFonts.SemiBold.rawValue,
                    size: size.cgFontSize)
            case .bold:
                return UIFont(
                    name: OpenSansFonts.Bold.rawValue,
                    size: size.cgFontSize)
            case .bold_italic:
                return UIFont(
                    name:   OpenSansFonts.BoldItalic.rawValue,
                    size: size.cgFontSize)
            case .light_italic:
                return UIFont(
                    name: OpenSansFonts.LightItalic.rawValue,
                    size: size.cgFontSize)
            case .body_italic:
                return UIFont(
                    name: OpenSansFonts.body_italic.rawValue,
                    size: size.cgFontSize)
            case .link_bold:
                return UIFont(
                    name: OpenSansFonts.linkBold.rawValue,
                    size: size.cgFontSize)
            case .link_italic:
                UIFont(name: OpenSansFonts.linkItalic.rawValue,
                       size: size.cgFontSize)
            }
        }

        var systemFont: UIFont {
            switch weight {
            case .light:
                return UIFont.systemFont(
                    ofSize: size.cgFontSize,
                    weight: .light)
            case .regular:
                return UIFont.systemFont(
                    ofSize: size.cgFontSize,
                    weight: .regular)
            case .semibold:
                return UIFont.systemFont(
                    ofSize: size.cgFontSize,
                    weight: .semibold)
            case .bold:
                return UIFont.systemFont(
                    ofSize: size.cgFontSize,
                    weight: .bold)
            }
        }

        return customFont ?? systemFont
    }

    @available(iOS 13.0, *)
    public var suFont: Font {
        var customSuFont: Font? {
            switch weight {
            case .light:
                return Font.custom(
                    OpenSansFonts.Light.rawValue,
                    size: size.cgFontSize)
            case .regular:
                return Font.custom(
                    OpenSansFonts.Regular.rawValue,
                    size: size.cgFontSize)
            case .semibold:
                return Font.custom(
                    OpenSansFonts.SemiBold.rawValue,
                    size: size.cgFontSize)
            case .bold:
                return Font.custom(
                    OpenSansFonts.Bold.rawValue,
                    size: size.cgFontSize)
            }
        }

        var systemSuFont: Font {
            switch weight {
            case .light:
                return Font.system(
                    size: size.cgFontSize,
                    weight: .light,
                    design: .default)
            case .regular:
                return Font.system(
                    size: size.cgFontSize,
                    weight: .regular,
                    design: .default)
            case .semibold:
                return Font.system(
                    size: size.cgFontSize,
                    weight: .semibold,
                    design: .default)
            case .bold:
                return Font.system(
                    size: size.cgFontSize,
                    weight: .bold,
                    design: .default)
            }
        }

        return customSuFont ?? systemSuFont
    }
}
