//
//  EmeraldChipStyle.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 7/17/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public enum EmeraldChipStyle: String, Inspectable {
    case success
    case warning
    case error
    case simple
    case dismissable
    
    var cornerRadious: CGFloat! {
        switch self {
        case .dismissable:
            return Constants.Dimens.chipsCornerRadiousDissmissable
        default:
            return Constants.Dimens.chipsCornerRadiousSimple
        }
    }

    var backgroundColor: UIColor! {
        switch self {
        case .success:
            return EmeraldTheme.successColor
        case .warning:
            return EmeraldTheme.warningColor
        case .error:
            return EmeraldTheme.errorColor
        case .dismissable, .simple:
            return EmeraldTheme.pagerBackgroundColor
        }
    }

    var buttonIcon: UIImage? {
        switch self {
        case .success, .simple, .warning, .error:
            return nil
        default:
            return getButtonIcon(named: Constants.Icons.dismiss)
        }
    }
    
    var iconColor: UIColor! {
        switch self {
        case .success:
            return EmeraldTheme.successColor
        case .warning:
            return EmeraldTheme.warningColor
        case .error:
            return EmeraldTheme.errorColor
        default:
            return EmeraldTheme.darkGrayColor
        }
    }

    var textColor: UIColor! {
        switch self {
        case .success, .warning, .error:
            return .white
        default:
            return EmeraldTheme.chipDefaultColor
        }
    }

    var font: UIFont! {
        switch self {
        case .error, .warning, .success:
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
