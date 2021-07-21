//
//  EmeraldButtonStyle.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/3/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public enum EmeraldButtonStyle: String, Inspectable {
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

    var backgroundColor: UIColor? {
        switch self {
        case .primary, .primarySmall, .primaryLarge:
            return EmeraldTheme.primaryButtonColor
        case .secondary, .secondarySmall, .secondaryLarge:
            return EmeraldTheme.secondaryButtonColor
        case .primarySuccess:
            return EmeraldTheme.successColor
        case .primaryWarning:
            return EmeraldTheme.warningColor
        case .primaryError:
            return EmeraldTheme.errorColor
        case .plain, .plainPrimary:
            return EmeraldTheme.whiteColor
        case .witheAndBlueColor:
            return EmeraldTheme.witheAndBlueColor
        default:
            return nil
        }
    }

    var titleColor: UIColor? {
        switch self {
        case .primary, .primarySmall, .primaryLarge, .primarySuccess, .primaryWarning, .primaryError:
            return .white
        case .secondary, .secondarySmall, .secondaryLarge, .plainPrimary:
            return EmeraldTheme.primaryColor
        case .link, .linkButton:
            return EmeraldTheme.linkColor
        case .plain, .witheAndBlueColor:
            return EmeraldTheme.darkTextColor
        case .warning:
            return EmeraldTheme.whiteColor
        }
    }

    var highlightedBackgroundColor: UIColor? {
        switch self {
        case .primary, .primarySmall, .primaryLarge:
            return EmeraldTheme.primaryButtonHighlightedColor
        case .primarySuccess:
            return EmeraldTheme.successButtonHighlightedColor
        case .primaryWarning:
            return EmeraldTheme.warningButtonHighlightedColor
        case .primaryError:
            return EmeraldTheme.errorButtonHighlightedColor
        case .plainPrimary:
            return nil
        case .warning:
            return .clear
        default:
            return backgroundColor
        }
    }

    var highlightedTitleColor: UIColor? {
        switch self {
        case .primary, .primarySmall, .primaryLarge, .primarySuccess, .primaryWarning, .primaryError, .plainPrimary:
            return titleColor
        case .plain:
            return EmeraldTheme.darkTextColor.withAlphaComponent(0.15)
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

    var borderColor: UIColor? {
        switch self {
        case .secondary, .secondarySmall, .secondaryLarge:
            return EmeraldTheme.primaryColor
        case .plain:
            return EmeraldTheme.borderColor
        case .witheAndBlueColor:
            return UIColor.white
        default:
            return nil
        }
    }

    var font: UIFont? {
        switch self {
        case .primarySmall, .secondarySmall:
            return Typography(size: .smallButton,
                weight: .bold).uiFont
        case .primaryLarge, .secondaryLarge:
            return Typography(size: .largeButton,
                weight: .bold).uiFont
        case .link, .plainPrimary:
            return Typography(size: .smallButton,
                weight: .semibold).uiFont
        case .linkButton:
            return Typography(size: .linkButton,
                weight: .semibold).uiFont
        case .warning:
            return Typography(size: .smallButton,
                weight: .bold).uiFont
        default:
            return Typography(size: .button,
                weight: .bold).uiFont
        }
    }

    var IBInspectable: String {
        return rawValue
    }

    init(IBInspectable: String) {
        self.init(stringValue: IBInspectable)
    }
}
