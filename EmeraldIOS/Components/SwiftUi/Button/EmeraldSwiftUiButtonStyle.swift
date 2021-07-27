//
//  EmeraldSwiftUiButtonStyle.swift
//  EmeraldIOS
//
//  Created by Jaime Uribe on 26/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public enum EmeraldSwiftUiButtonStyle: String {
    case plain
    case primary
    case primarySuccess
    case primaryWarning
    case primaryError
    case primarySmall
    case primaryLarge
    case secondary
    case secondarySmall
    case secondaryLarge
    case link
    case linkButton
    case plainPrimary
    case witheAndBlueColor
    case warning
    
    
    var backgroundColor: Color? {
        switch self {
        case .primary, .primarySmall, .primaryLarge:
            return EmeraldTheme.primaryButtonColor.suColor
        case .secondary, .secondarySmall, .secondaryLarge:
            return EmeraldTheme.secondaryButtonColor.suColor
        case .primaryWarning:
            return EmeraldTheme.warningColor.suColor
        case .primaryError:
            return EmeraldTheme.errorColor.suColor
        case .plain, .plainPrimary:
            return EmeraldTheme.whiteColor.suColor
        case .witheAndBlueColor:
            return EmeraldTheme.witheAndBlueColor.suColor
        default:
            return nil
        }
    }
    

    var titleColor: Color? {
        switch self {
        case .primary, .primarySmall, .primaryLarge, .primarySuccess, .primaryWarning, .primaryError:
            return .white
        case .secondary, .secondarySmall, .secondaryLarge, .plainPrimary:
            return EmeraldTheme.primaryColor.suColor
        case .link, .linkButton:
            return EmeraldTheme.linkColor.suColor
        case .plain, .witheAndBlueColor:
            return EmeraldTheme.darkTextColor.suColor
        case .warning:
            return EmeraldTheme.whiteColor.suColor
        }
    }
    
    var cornerRadious: CGFloat {
        switch self {
        default:
            return EmeraldTheme.defaultButtonCornerRadius
        }
    }
    
    var highlightedBackgroundColor: Color? {
        switch self {
        case .primary, .primarySmall, .primaryLarge:
            return EmeraldTheme.primaryButtonHighlightedColor.suColor
        case .primarySuccess:
            return EmeraldTheme.successButtonHighlightedColor.suColor
        case .primaryWarning:
            return EmeraldTheme.warningButtonHighlightedColor.suColor
        case .primaryError:
            return EmeraldTheme.errorButtonHighlightedColor.suColor
        case .plainPrimary:
            return nil
        case .warning:
            return .clear
        default:
            return backgroundColor
        }
    }
    

    var highlightedTitleColor: Color? {
        switch self {
        case .primary, .primarySmall, .primaryLarge, .primarySuccess, .primaryWarning, .primaryError, .plainPrimary:
            return titleColor
        case .plain:
            return EmeraldTheme.darkTextColor.withAlphaComponent(0.15).suColor
        default:
            return nil
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .secondary, .secondarySmall, .secondaryLarge, .plain, .witheAndBlueColor:
            return 1
        default:
            return 0
        }
    }

    
    var borderColor: Color? {
        switch self {
        case .secondary, .secondarySmall, .secondaryLarge:
            return EmeraldTheme.primaryColor.suColor
        case .plain:
            return EmeraldTheme.borderColor.suColor
        case .witheAndBlueColor:
            return Color.white
        default:
            return nil
        }
    }

    var font: Font? {
        switch self {
        case .primarySmall, .secondarySmall:
            return Typography(size: .smallButton,
                              weight: .bold).suFont
        case .primaryLarge, .secondaryLarge:
            return Typography(size: .largeButton,
                weight: .bold).suFont
        case .link, .plainPrimary:
            return Typography(size: .smallButton,
                weight: .semibold).suFont
        case .linkButton:
            return Typography(size: .linkButton,
                weight: .semibold).suFont
        case .warning:
            return Typography(size: .smallButton,
                weight: .bold).suFont
        default:
            return Typography(size: .button,
                weight: .bold).suFont
        }
    }
}
