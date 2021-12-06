//
//  EmeraldSwiftUIButtonView.swift
//  EmeraldIOS
//
//  Created by Jaime Uribe on 26/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct EmeraldSwiftUIButton: View {
    
    private struct InnerConstant {
        static let minOpacity = 0.65
        static let maxOpacity = 1.0
        static let buttonPadding = CGFloat(integerLiteral: 12)
    }
    
    @State private var buttonName: String
    @Binding public var isEnabled: Bool
    @Binding public var isHighlighted: Bool
    public var themeStyle: EmeraldSwiftUiButtonStyle
    private var didTapButton: () -> ()
    
    public init(buttonName: State<String>,
                isEnabled: Binding<Bool>,
                isHighlighted: Binding<Bool>,
                themeStyle: EmeraldSwiftUiButtonStyle = .primaryError,
                didTapButton: @escaping () -> ()) {
        self._buttonName = buttonName
        self._isEnabled = isEnabled
        self._isHighlighted = isHighlighted
        self.themeStyle = themeStyle
        self.didTapButton = didTapButton
    }
    
    public var body: some View {
        Button {
            if isEnabled {
                didTapButton()
            }
            
        } label: {
            Text(buttonName)
                .font(themeStyle.font)
                .padding(InnerConstant.buttonPadding)
                .foregroundColor(themeStyle.highlightedTitleColor)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(isHighlighted ? themeStyle.highlightedBackgroundColor : themeStyle.backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: themeStyle.cornerRadious)
                .stroke(themeStyle.borderColor ?? Color.white, lineWidth: themeStyle.borderWidth)
        )
        .cornerRadius(themeStyle.cornerRadious)
        .opacity(isEnabled ? InnerConstant.maxOpacity : InnerConstant.minOpacity)
    }
    
}

#if DEBUG
@available(iOS 13.0.0, *)
struct ContentView_Previews: PreviewProvider {
    @State static var buttonName = "test"
    @State static var isEnabled = false
    @State static var isHighlighted = true
    
    static var previews: some View {
        EmeraldSwiftUIButton(
            buttonName: _buttonName,
            isEnabled: $isEnabled,
            isHighlighted: $isHighlighted) {}
    }
}
#endif
