//
//  EmeraldCurrencyTextField.swift
//  Components
//
//  Created by Ronal Fabra on 23/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct EmeraldCurrencyTextField: View {
    
    @Binding var text: String
    @State(initialValue: false) var focused: Bool
    var label: String = ""
    var placeholder: String = ""
    var accessibility: String = ""
    var helperText: String? = nil
    var errorText: String? = nil
    var maxLength: Int? = nil
    var hideCounter: Bool = false
    var clearable: Bool = false
    var disabled: Bool = false
    var keyboardType: UIKeyboardType = .default
    
    var textField: some View {
        TextField(
            placeholder,
            text: $text,
            onEditingChanged: {
                self.focused = $0
            }, onCommit: {
                self.focused = false
            })
            .onReceive(text.publisher.collect()) {
                if maxLength != nil {
                    let str = String($0.prefix(maxLength ?? 0))
                    text = str.currencyInputFormatting()
                } else {
                    text = String($0).currencyInputFormatting()
                }
            }
            .disabled(disabled)
            .keyboardType(keyboardType)
            .accessibility(identifier: accessibility)
            .disableAutocorrection(true)
            .font(Typography(
                    size: .h3,
                    weight: .semibold).suFont)
            .foregroundColor(Constants.EmeraldSwiftUiTextField.textColor)
            .padding(
                .leading,
                Constants.EmeraldSwiftUiTextField.leadingContentSpacing +
                    Constants.EmeraldSwiftUiTextField.widthIcon)
            .padding(
                .trailing, (
                    clearable ?
                        Constants.EmeraldSwiftUiTextField.trailingContentSpacing * 1.5 +
                        Constants.EmeraldSwiftUiTextField.widthClearButton :
                        Constants.EmeraldSwiftUiTextField.trailingContentSpacing))
            .frame(height: Constants.EmeraldSwiftUiTextField.textFieldHeight)
            .overlay(RoundedRectangle(cornerRadius: Constants.EmeraldSwiftUiTextField.cornerRadius)
                        .stroke(
                            (errorText != nil ?
                                Constants.EmeraldSwiftUiTextField.errorColor :
                                (focused ?
                                    Constants.EmeraldSwiftUiTextField.focusColor :
                                    Constants.EmeraldSwiftUiTextField.borderColor)),
                            lineWidth: self.focused ?
                                Constants.EmeraldSwiftUiTextField.borderWidthFocused :
                                Constants.EmeraldSwiftUiTextField.borderWidth))
            .introspectTextField { textField in
                if focused {
                    textField.becomeFirstResponder()
                }
            }
    }
    
    var currencyContent: some View {
        CurrencySymbol(disabled: disabled)
            .padding(
                .leading,
                Constants.EmeraldSwiftUiTextField.leadingContentSpacing * 0.5)
    }
    
    var clearButtonContent: some View {
        HStack(spacing: Constants.EmeraldSwiftUiTextField.trailingContentSpacing) {
            Spacer()
            if clearable, !text.isEmpty {
                ClearButton {
                    text = ""
                }
            }
        }
        .frame(alignment: .trailing)
        .padding(.trailing,
                 Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
    }
    
    var helperTextContent: some View {
        HStack(alignment: .top) {
            if errorText != nil || helperText != nil {
                LabelHelperText(
                    disabled: disabled,
                    helperText: helperText,
                    errorText: errorText)
            }
            if maxLength != nil, !hideCounter {
                Spacer()
                LabelTextFieldCounter(
                    text: $text,
                    disabled: disabled,
                    maxLength: maxLength)
            }
        }
        .padding(
            .leading,
            Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
    }
    
    var labelFieldContent: some View {
        HStack(alignment: .top) {
            LabelTextFieldTitle(
                label: label,
                disabled: disabled,
                errorText: errorText,
                focused: $focused)
                .padding(
                    .trailing,
                    Constants.EmeraldSwiftUiTextField.horizontalLabelSpacing)
            Spacer()
        }
        .frame(height: Constants.EmeraldSwiftUiTextField.heightLabel)
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                ZStack {
                    textField
                    currencyContent
                    clearButtonContent
                }
                helperTextContent
            }
            .offset(
                x: .zero,
                y: Constants.EmeraldSwiftUiTextField.heightLabel * 0.5)
            labelFieldContent
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
        .background(Constants.EmeraldSwiftUiTextField.whiteColor)
    }
}

@available(iOS 13.0.0, *)
struct EmeraldCurrencyTextField_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            EmeraldCurrencyTextField(
                text: $name,
                label: "name asda s sada s asda sdasda s d sdas dasds as dfs dfs df",
                placeholder: "placeholder",
                helperText: "this field is for help you",
                clearable: true,
                keyboardType: .default)
        }
    }
}
