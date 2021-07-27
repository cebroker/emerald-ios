//
//  EmeraldSwiftUiChipViewStyle.swift
//  EmeraldIOS
//
//  Created by Daniel Crespo Duarte on 7/23/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

public enum EmeraldSwiftUiChipViewStyle: String {
    case success
    case warning
    case error
    case simple
    case dismissable

    var cornerRadious: CGFloat {
        switch self {
        case .dismissable:
            return Constants.Dimens.chipsCornerRadiousDissmissable
        default:
            return Constants.Dimens.chipsCornerRadiousSimple
        }
    }

    @available(iOS 13.0, *)
    var backgroundColor: ColorPallete? {
        switch self {
        case .success:
            return .success
        case .warning:
            return .warning
        case .error:
            return .error
        case .dismissable, .simple:
            return .pagerBackgroundColor
        }
    }

    var textColor: ColorPallete {
        switch self {
        case .success, .warning, .error:
            return .white
        default:
            return .chipDefaultColor
        }
    }
    
    var fontSize: FontSize {
        switch self {
        case .error, .warning, .success:
           return .body
        default:
            return .h5
        }
    }
    
    var fontWeight: FontWeight {
        switch self {
        case .error, .warning, .success:
           return .regular
        default:
            return .semibold
        }
    }

    @available(iOS 13.0, *)
    var buttonIcon: Image? {
        switch self {
        case .success, .simple, .warning, .error:
            return nil
        default:
            return getButtonIcon(named: Constants.Icons.dismiss)
        }
    }

    @available(iOS 13.0, *)
    private func getButtonIcon(named: String) -> Image? {
        let dismissIcon = UIImage(
            named: named,
            in: Bundle(for: EmeraldChipView.self),
            compatibleWith: nil)

        guard let icon = dismissIcon else {
            return nil
        }

        return Image(uiImage: icon)
    }
}
