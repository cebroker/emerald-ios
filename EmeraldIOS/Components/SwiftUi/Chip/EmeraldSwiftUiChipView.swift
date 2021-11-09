//
//  EmeraldSwiftUiChipView.swift
//  EmeraldIOS
//
//  Created by Daniel Crespo Duarte on 7/23/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

protocol EmeraldSwiftUiChipDismissable {
    func didTapButton()
}

@available(iOS 13.0.0, *)
public struct EmeraldSwiftUiChipView: View {
    private struct InnerConstant {
        static let dismissPadding = CGFloat(integerLiteral: 7)
    }

    @Binding public var text: String
    public var themeStyle: EmeraldSwiftUiChipViewStyle

    var delegate: EmeraldSwiftUiChipDismissable?

    public init(text: Binding<String>,
                themeStyle: EmeraldSwiftUiChipViewStyle = .simple)
    {
        _text = text
        self.themeStyle = themeStyle
    }

    public var body: some View {
        Button {
            self.delegate?.didTapButton()
        } label: {
            HStack(spacing: 10) {
                EmeraldSwiftUiLabel(
                    text: $text,
                    themeStyle: .custom,
                    themeColor: themeStyle.textColor,
                    themeFontSize: themeStyle.fontSize,
                    themeFontWeight: themeStyle.fontWeight)
                themeStyle.buttonIcon?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            }
        }
        .padding(InnerConstant.dismissPadding)
        .background(themeStyle.backgroundColor?.uiColor.suColor)
        .cornerRadius(themeStyle.cornerRadious)
        .buttonStyle(PlainButtonStyle())
        
    }
}

#if DEBUG
    @available(iOS 13.0.0, *)
    struct EmeraldSwiftUiChipView_Previews: PreviewProvider {
        @State static var text = "test"
        static var previews: some View {
            EmeraldSwiftUiChipView(text: $text)
        }
    }
#endif
