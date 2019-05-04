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
        default:
            return nil
        }
    }
    
    var titleColor: UIColor? {
        switch self {
        case .primary, .primarySmall, .primaryLarge:
            return EmeraldTheme.whiteColor
        case .secondary, .secondarySmall, .secondaryLarge:
            return EmeraldTheme.textColor
        case .link:
            return EmeraldTheme.linkColor
        }
    }
    
    var highlightedBackgroundColor: UIColor? {
        switch self {
        case .primary, .primarySmall, .primaryLarge:
            return EmeraldTheme.primaryButtonHighlightedColor
        default:
            return backgroundColor
        }
    }
    
    var highlightedTitleColor: UIColor? {
        switch self {
        case .primary, .primarySmall, .primaryLarge:
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
            return EmeraldTheme.borderColor
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
