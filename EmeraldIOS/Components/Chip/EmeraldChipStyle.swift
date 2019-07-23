//
//  EmeraldChipStyle.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 7/17/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public enum EmeraldChipStyle: String, Inspectable {
    case simpleSuccess
    case simpleWarning
    case simpleError
    case simpleDefault
    case dissmisible
    
    var cornerRadious: CGFloat! {
        switch self {
        case .dissmisible:
            return Constants.Dimens.chipsCornerRadiousDissmissable
        default:
            return Constants.Dimens.chipsCornerRadiousSimple
        }
    }

    var backgroundColor: UIColor! {
        switch self {
        case .simpleSuccess:
            return EmeraldTheme.successColor
        case .simpleWarning:
            return EmeraldTheme.warningColor
        case .simpleError:
            return EmeraldTheme.errorColor
        case .dissmisible, .simpleDefault:
            return EmeraldTheme.pagerBackgroundColor
        }
    }

    var buttonIcon: UIImage? {
        switch self {
        case .simpleSuccess, .simpleDefault, .simpleWarning, .simpleError:
            return nil
        default:
            return getButtonIcon(named: Constants.Icons.error)
        }
    }
    
    var iconColor: UIColor! {
        switch self {
        case .simpleSuccess:
            return EmeraldTheme.successColor
        case .simpleWarning:
            return EmeraldTheme.warningColor
        case .simpleError:
            return EmeraldTheme.errorColor
        case .dissmisible, .simpleDefault:
            return EmeraldTheme.darkGrayColor
        }
    }

    var textColor: UIColor! {
        switch self {
        case .simpleSuccess, .simpleWarning, .simpleError:
            return EmeraldTheme.whiteColor
        default:
            return EmeraldTheme.blackColor
        }
    }

    var font: UIFont! {
        switch self {
        case .simpleError, .simpleWarning, .simpleSuccess:
            return Font(size: .body, weight: .regular).uiFont
        default:
            return Font(size: .h5, weight: .semibold).uiFont
        }
    }
    
    var width: CGFloat! {
        switch self {
        case .dissmisible:
            return 50 // Dissmisible button width = 50
        default:
            return 20 // Padding = 10 ( Left and Right)
        }
    }

    var IBInspectable: String {
        return rawValue
    }

    init(IBInspectable: String) {
        self.init(stringValue: IBInspectable)
    }

    private func getButtonIcon(named: String) -> UIImage {
        let dismissIcon = UIImage(
            named: named,
            in: Bundle(for: EmeraldChipView.self),
            compatibleWith: nil)

        guard let icon = dismissIcon else {
            return UIImage()
        }

        return icon
    }
}
