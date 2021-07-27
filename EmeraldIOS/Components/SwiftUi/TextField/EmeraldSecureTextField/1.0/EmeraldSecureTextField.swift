//
//  EmeraldSecureTextField.swift
//  Components
//
//  Created by Ronal Fabra on 23/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct EmeraldSecureTextField: View {
    
    @Binding var text: String
    @State(initialValue: false) var focused: Bool
    var label: String = ""
    var placeholder: String = ""
    var accessibility: String = ""
    var errorText: String? = nil
    var maxLength: Int? = nil
    var disabled: Bool = false
    var keyboardType: UIKeyboardType = .default
    @State(initialValue: false) var show: Bool
    
    @ViewBuilder
    var field: some View {
        if $show.wrappedValue {
            EmeraldGenericTextField(
                text: $text,
                focused: _focused,
                placeholder: focused ?
                    placeholder :
                    "",
                accessibility: accessibility,
                errorText: errorText,
                disabled: disabled,
                keyboardType: keyboardType)
        } else {
            SecureTextFieldSwiftUI(
                placeholder: focused ?
                    placeholder :
                    "",
                text: $text) {
                self.focused = $0
            }
            .disabled(disabled)
            .frame(height: Constants.EmeraldSwiftUiTextField.textFieldHeight)
        }
    }
    
    var secureTextField: some View {
        field
            .onReceive(text.publisher.collect()) {
                if maxLength != nil {
                    text = String($0.prefix(maxLength ?? 0))
                }
            }
            .padding(
                .leading,
                Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
            .padding(
                .trailing,
                Constants.EmeraldSwiftUiTextField.trailingContentSpacing +
                Constants.EmeraldSwiftUiTextField.widthShowButton)
            .padding(
                .top, focused || !text.isEmpty ?
                    Constants.EmeraldSwiftUiTextField.heightLabel * 0.7 :
                    .zero)
            .overlay(RoundedRectangle(cornerRadius: Constants.EmeraldSwiftUiTextField.cornerRadius)
                        .stroke((errorText != nil ?
                                    Constants.EmeraldSwiftUiTextField.errorColor :
                                    (focused ?
                                        Constants.EmeraldSwiftUiTextField.focusColor :
                                        (disabled ?
                                        Constants.EmeraldSwiftUiTextField.placeHolderColor.opacity(0.5) :
                                        Constants.EmeraldSwiftUiTextField.placeHolderColor))),
                                lineWidth: self.focused ?
                                    Constants.EmeraldSwiftUiTextField.borderWidthFocused :
                                    Constants.EmeraldSwiftUiTextField.borderWidth))
    }
    
    var errorTextContent: some View {
        HStack(alignment: .top) {
            if errorText != nil {
                LabelHelperText(
                    disabled: disabled,
                    helperText: nil,
                    errorText: errorText)
            }
        }
        .padding(
            .leading,
            Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
    }
    
    var showButtonContent: some View {
        Button(action: {
            DispatchQueue.main.async {
                self.show.toggle()
            }
        }) {
            if $show.wrappedValue {
                Text(Constants.EmeraldSwiftUiTextField.hide)
                    .animation(.easeOut)
            } else {
                Text(Constants.EmeraldSwiftUiTextField.show)
                    .animation(.easeIn)
            }
        }
        .frame(width: Constants.EmeraldSwiftUiTextField.widthShowButton)
        .font(Typography(
                size: .h4,
                weight: .semibold).suFont)
        .foregroundColor(disabled ?
                            Constants.EmeraldSwiftUiTextField.disabledColor :
                            Constants.EmeraldSwiftUiTextField.textColor)
    }
    
    var labelFieldContent: some View {
        HStack {
            LabelTextFieldTitle(
                label: label,
                text: text,
                errorText: errorText,
                focused: $focused)
            Spacer()
        }
        .frame(height: Constants.EmeraldSwiftUiTextField.heightLabel)
        .padding(
            .leading,
            Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
        .padding(
            .trailing,
            Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
        .offset(
            x: .zero,
            y: focused ?
                -Constants.EmeraldSwiftUiTextField.heightLabel :
                text.isEmpty ?
                .zero :
                -Constants.EmeraldSwiftUiTextField.topContentSpacing)
        .animation(.spring(
                    response: 0.2,
                    dampingFraction: 1,
                    blendDuration: .zero))
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                secureTextField
                labelFieldContent
                    .onTapGesture {
                        if !disabled {
                            self.focused = true
                        }
                    }
                HStack {
                    Spacer()
                    showButtonContent
                }
                .frame(alignment: .trailing)
                .padding(
                    .trailing,
                    Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
            }
            errorTextContent
        }
        .fixedSize(
            horizontal: false,
            vertical: true)
        .padding(
            .horizontal,
            Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
        .padding(
            .bottom,
            Constants.EmeraldSwiftUiTextField.bottomContentPadding)
    }
}

@available(iOS 13.0.0, *)
struct EmeraldSecureTextField_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            EmeraldSecureTextField(
                text: $name,
                label: "name asda s sada s asda sdasda s d sdas dasds as dfs dfs df",
                placeholder: "placeholder",
                keyboardType: .default)
        }
    }
}
