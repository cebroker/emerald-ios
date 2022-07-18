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
    case ExtraBold = "OpenSans-ExtraBold"
    case Italic = "OpenSans-Italic"
    case BoldItalic = "OpenSans-BoldItalic"
    case ExtraBoldItalic = "OpenSans-ExtraBoldItalic"
    case LightItalic = "OpenSans-LightItalic"
    case BodyItalic =  "OpenSans-body_italic"
    case LinkBold = "OpenSans-linkBold"
    case LinkItalic = "OpenSans-linkItalic"
    case TitleBold = "OpenSans-title_bold"
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
    case linkNormal
    case linkBold
    case titleBold
    case titleItalic
    case lightItalic
    case titleNormal
    case bodyNormal
    case extraBold
    case extraBoldItalic
    case boldItalic

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
        case .titleItalic:
            return 16
        case .linkNormal:
            return 14
        case .bodyNormal:
            return 14
        case .titleNormal:
            return 14
        case .extraBold:
            return 16
        case .extraBoldItalic:
            return 16
        case .lightItalic:
            return 14
        case .boldItalic:
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
    case boldItalic
    case italic
    case lightItalic
    case linkItalic
    case linkBold
    case titleBold
    case bodyItalic
    case extraBold
    case extraBoldItalic
    
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
            case .boldItalic:
                return UIFont(
                    name: OpenSansFonts.BoldItalic.rawValue,
                    size: size.cgFontSize)
            case .lightItalic:
                return UIFont(
                    name: OpenSansFonts.LightItalic.rawValue,
                    size: size.cgFontSize)
            case .bodyItalic:
                return UIFont(
                    name: OpenSansFonts.BodyItalic.rawValue,
                    size: size.cgFontSize)
            case .linkBold:
                return UIFont(
                    name: OpenSansFonts.LinkBold.rawValue,
                    size: size.cgFontSize)
            case .linkItalic:
                return UIFont(name: OpenSansFonts.LinkItalic.rawValue,
                       size: size.cgFontSize)
            case .italic:
                return UIFont(name: OpenSansFonts.Italic.rawValue,
                       size: size.cgFontSize)
            case .titleBold:
                return UIFont(name: OpenSansFonts.TitleBold.rawValue,
                       size: size.cgFontSize)
            case .extraBold:
                return UIFont(name: OpenSansFonts.ExtraBold.rawValue,
                       size: size.cgFontSize)
            case .extraBoldItalic:
                return UIFont(name: OpenSansFonts.ExtraBoldItalic.rawValue,
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
            case .boldItalic:
                return UIFont.systemFont(
                    ofSize: size.cgFontSize,
                    weight: .bold)
            case .italic:
                return UIFont.systemFont(
                    ofSize: size.cgFontSize,
                    weight: .regular)
            case .lightItalic:
                return UIFont.systemFont(
                    ofSize: size.cgFontSize,
                    weight: .light)
            case .linkItalic:
                return UIFont.systemFont(
                    ofSize: size.cgFontSize,
                    weight: .regular)
            case .linkBold:
                return UIFont.systemFont(
                    ofSize: size.cgFontSize,
                    weight: .bold)
            case .titleBold:
                return UIFont.systemFont(
                    ofSize: size.cgFontSize,
                    weight: .bold)
            case .bodyItalic:
                return UIFont.systemFont(
                    ofSize: size.cgFontSize,
                    weight: .regular)
            case .extraBold:
                return UIFont.systemFont(
                    ofSize: size.cgFontSize,
                    weight: .bold)
            case .extraBoldItalic:
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
            case .boldItalic:
                return Font.custom(
                    OpenSansFonts.BoldItalic.rawValue,
                    size: size.cgFontSize)
            case .italic:
                return Font.custom(
                    OpenSansFonts.Italic.rawValue,
                    size: size.cgFontSize)
            case .lightItalic:
                return Font.custom(
                    OpenSansFonts.LightItalic.rawValue,
                    size: size.cgFontSize)
            case .linkItalic:
                return Font.custom(
                    OpenSansFonts.LinkItalic.rawValue,
                    size: size.cgFontSize)
            case .linkBold:
                return Font.custom(
                    OpenSansFonts.LinkBold.rawValue,
                    size: size.cgFontSize)
            case .titleBold:
                return Font.custom(
                    OpenSansFonts.TitleBold.rawValue,
                    size: size.cgFontSize)
            case .bodyItalic:
                return Font.custom(
                    OpenSansFonts.BodyItalic.rawValue,
                    size: size.cgFontSize)
            case .extraBold:
                return Font.custom(
                    OpenSansFonts.ExtraBold.rawValue,
                    size: size.cgFontSize)
            case .extraBoldItalic:
                return Font.custom(
                    OpenSansFonts.ExtraBoldItalic.rawValue,
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
            case .boldItalic:
                return Font.system(
                    size: size.cgFontSize,
                    weight: .bold,
                    design: .default)
            case .italic:
                return Font.system(
                    size: size.cgFontSize,
                    weight: .regular,
                    design: .default)
            case .lightItalic:
                return Font.system(
                    size: size.cgFontSize,
                    weight: .light,
                    design: .default)
            case .linkItalic:
                return Font.system(
                    size: size.cgFontSize,
                    weight: .light,
                    design: .default)
            case .linkBold:
                return Font.system(
                    size: size.cgFontSize,
                    weight: .bold,
                    design: .default)
            case .titleBold:
                return Font.system(
                    size: size.cgFontSize,
                    weight: .bold,
                    design: .default)
            case .bodyItalic:
                return Font.system(
                    size: size.cgFontSize,
                    weight: .regular,
                    design: .default)
            case .extraBold:
                return Font.system(
                    size: size.cgFontSize,
                    weight: .bold,
                    design: .default)
            case .extraBoldItalic:
                return Font.system(
                    size: size.cgFontSize,
                    weight: .bold,
                    design: .default)
            }
        }

        return customSuFont ?? systemSuFont
    }
}
