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
}
