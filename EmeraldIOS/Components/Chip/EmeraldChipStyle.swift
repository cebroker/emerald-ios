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
    case avatar

    var backgroundColor: UIColor! {
        switch self {
        case .simpleSuccess:
            return EmeraldTheme.successColor
        case .simpleWarning:
            return EmeraldTheme.warningColor
        case .simpleError:
            return EmeraldTheme.errorColor
        case .dissmisible, .avatar, .simpleDefault:
            return EmeraldTheme.pagerBackgroundColor
        }
    }

    var buttonIcon: UIImage! {
        switch self {
        case .simpleSuccess:
            return getButtonIcon(named: Constants.Icons.success)
        case .simpleWarning:
            return getButtonIcon(named: Constants.Icons.failure)
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
        case .dissmisible, .avatar, .simpleDefault:
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
