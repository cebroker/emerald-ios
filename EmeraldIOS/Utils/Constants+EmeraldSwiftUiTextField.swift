//
//  Constants+EmeraldSwiftUiTextField.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 23/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
extension Constants {
    public struct EmeraldSwiftUiTextField {
        static let cornerRadius: CGFloat = 3
        static let borderWidth: CGFloat = 1
        static let borderWidthFocused: CGFloat = 1
        static let textFieldHeight: CGFloat = 44
        static let textAreaHeight: CGFloat = 60
        static let leadingContentSpacing: CGFloat = 10
        static let trailingContentSpacing: CGFloat = 10
        static let topContentSpacing: CGFloat = 14
        static let spaceBetweenContent: CGFloat = 42
        static let spaceBottomContent: CGFloat = 30
        static let bottomContentSpacing: CGFloat = 5
        static let horizontalLabelSpacing: CGFloat = 4
        static let bottomContentPadding:CGFloat = 5
        static let heightLabel: CGFloat = 15
        static let widthClearButton:CGFloat = ClearButton.widthClearButton
        static let widthShowButton:CGFloat = 50
        static let widthIcon:CGFloat = 20
        static let maximumDateLength = 10
        static let maximumShortDateLength = 7
        static let errorColor: UIColor = ColorPallete.error.uiColor
        static let focusColor: UIColor = EmeraldTheme.primaryColor
        static let textColor: UIColor = ColorPallete.black.uiColor
        static let borderColor: UIColor = ColorPallete.border.uiColor
        static let whiteColor: UIColor = ColorPallete.white.uiColor
        static let disabledColor: UIColor = ColorPallete.extraLightGray.uiColor
        static let placeHolderColor: UIColor = ColorPallete.border.uiColor
        static let lightTextColor: UIColor = ColorPallete.lightText.uiColor
        static let primaryColor: UIColor = EmeraldTheme.primaryColor
        static let hide: String = "hide"
        static let show: String = "show"
    }
}
