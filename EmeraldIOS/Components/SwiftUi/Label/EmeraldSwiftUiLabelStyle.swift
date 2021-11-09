//
//  EmeraldSwiftUiLabelStyle.swift
//  EmeraldIOS
//
//  Created by Daniel Crespo Duarte on 7/21/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

public enum EmeraldSwiftUiLabelStyle: String {
    case largeHeader
    case mainTitle
    case subtitle
    case body
    case bodyBold
    case tableHeader
    case link
    case custom
    case warning

    @available(iOS 13.0, *)
    var textColor: Color? {
        switch self {
        case .largeHeader:
            return EmeraldTheme.textColor.suColor
        case .mainTitle:
            return EmeraldTheme.textColor.suColor
        case .subtitle:
            return EmeraldTheme.lightTextColor.suColor
        case .body:
            return EmeraldTheme.textColor.suColor
        case .bodyBold:
            return EmeraldTheme.textColor.suColor
        case .tableHeader:
            return EmeraldTheme.darkTextColor.suColor
        case .link:
            return EmeraldTheme.primaryColor.suColor
        case .warning:
            return EmeraldTheme.whiteColor.suColor
        default:
            return nil
        }
    }
    
    @available(iOS 13.0, *)
    var font: Font? {
        switch self {
        case .largeHeader:
            return Typography(size: .h1, weight: .semibold).suFont
        case .mainTitle:
            return Typography(size: .h4, weight: .semibold).suFont
        case .subtitle:
            return Typography(size: .h5, weight: .semibold).suFont
        case .body:
            return Typography(size: .body, weight: .regular).suFont
        case .bodyBold:
            return Typography(size: .h5, weight: .semibold).suFont
        case .tableHeader:
            return Typography(size: .tableHeader, weight: .semibold).suFont
        case .link:
            return Typography(size: .h4, weight: .bold).suFont
        case .warning:
            return Typography(size: .h6, weight: .regular).suFont
        default:
            return nil
        }
    }
}
