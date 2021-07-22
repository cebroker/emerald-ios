//
//  EmeraldSwiftUiLabel.swift
//  EmeraldIOS
//
//  Created by Daniel Crespo Duarte on 7/21/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//
import SwiftUI

@available(iOS 13.0.0, *)
public struct EmeraldSwiftUiLabel: View {
    @Binding public var text: String
    public var themeStyle: EmeraldSwiftUiLabelStyle
    public var themeColor: ColorPallete
    public var themeFontSize: FontSize
    public var themeFontWeight: FontWeight
    private var themeTypography: Typography?

    public init(text: Binding<String>,
                themeStyle: EmeraldSwiftUiLabelStyle = .custom,
                themeColor: ColorPallete = .text,
                themeFontSize: FontSize = .body,
                themeFontWeight: FontWeight = .regular) {
        _text = text
        self.themeStyle = themeStyle
        self.themeColor = themeColor
        self.themeFontSize = themeFontSize
        self.themeFontWeight = themeFontWeight
        themeTypography = getThemeTypography(
            themeFontSize: themeFontSize,
            themeFontWeight: themeFontWeight)
    }

    private func getThemeTypography(themeFontSize: FontSize,
                                    themeFontWeight: FontWeight) -> Typography? {
        return Typography(size: themeFontSize, weight: themeFontWeight)
    }

    public var body: some View {
        if case .custom = themeStyle {
            Text(text)
                .font(themeTypography?.suFont)
                .foregroundColor(themeColor.uiColor.suColor)
        } else {
            Text(text)
                .font(themeStyle.font)
                .foregroundColor(themeStyle.textColor)
        }
    }
}

#if DEBUG
    @available(iOS 13.0.0, *)
    struct EmeraldSwiftUiLabel_Previews: PreviewProvider {
        @State static var text = "test"
        static var previews: some View {
            EmeraldSwiftUiLabel(text: $text)
        }
    }
#endif
