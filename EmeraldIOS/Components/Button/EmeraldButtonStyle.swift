//
//  EmeraldButtonStyle.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/3/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public enum EmeraldButtonStyle: String, Inspectable {
    
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
        default:
            return nil
        }
    }
    
    var titleColor: UIColor? {
        switch self {
        case .primary, .primarySmall, .primaryLarge, .primarySuccess, .primaryWarning, .primaryError:
            return EmeraldTheme.whiteColor
        case .secondary, .secondarySmall, .secondaryLarge:
            return EmeraldTheme.primaryColor
        case .link:
            return EmeraldTheme.linkColor
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
        default:
            return backgroundColor
        }
    }
    
    var highlightedTitleColor: UIColor? {
        switch self {
        case .primary, .primarySmall, .primaryLarge, .primarySuccess, .primaryWarning, .primaryError:
            return titleColor
        default:
            return nil
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .secondary, .secondarySmall, .secondaryLarge:
            return 1
        default:
            return 0
        }
    }
    
    var borderColor: UIColor? {
        switch self {
        case .secondary, .secondarySmall, .secondaryLarge:
            return EmeraldTheme.primaryColor
        default:
            return nil
        }
    }
    
    var font: UIFont? {
        switch self {
        case .primarySmall, .secondarySmall:
            return Font(size: .smallButton,
                        weight: .bold).uiFont
        case .primaryLarge, .secondaryLarge:
            return Font(size: .largeButton,
                        weight: .bold).uiFont
        case .link:
            return Font(size: .button,
                        weight: .semibold).uiFont
        default:
            return Font(size: .button,
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
