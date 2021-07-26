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
        static let borderWidthFocused: CGFloat = 2
        static let textFieldHeight: CGFloat = 54
        static let textAreaHeight: CGFloat = 60
        static let leadingContentSpacing: CGFloat = 14
        static let trailingContentSpacing: CGFloat = 14
        static let topContentSpacing: CGFloat = 14
        static let bottomContentSpacing: CGFloat = 5
        static let horizontalLabelSpacing: CGFloat = 4
        static let bottomContentPadding:CGFloat = 5
        static let heightLabel: CGFloat = 15
        static let widthClearButton:CGFloat = ClearButton.widthClearButton
        static let widthShowButton:CGFloat = 50
        static let widthIcon:CGFloat = 20
        static let maximumDateLength = 10
        static let maximumShortDateLength = 7
        static let errorColor: Color = ColorPallete.error.uiColor.suColor
        static let focusColor: Color = ColorPallete.blue.uiColor.suColor
        static let textColor: Color = ColorPallete.black.uiColor.suColor
        static let borderColor: Color = ColorPallete.border.uiColor.suColor
        static let whiteColor: Color = ColorPallete.white.uiColor.suColor
        static let disabledColor: Color = ColorPallete.extraLightGray.uiColor.suColor
        static let hide: String = "hide"
        static let show: String = "show"
    }
}
