//
//  EmeraldSecureTextFieldNew.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 26/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct EmeraldSecureTextFieldNew: View {
    
    @Binding var text: String
    @State(initialValue: false) var focused: Bool
    var label: String = ""
    var placeholder: String = ""
    @State(initialValue: "") var placeholderState: String
    var accessibility: String = ""
    var helperText: String? = nil
    var errorText: String? = nil
    var maxLength: Int? = nil
    var hideCounter: Bool = false
    var clearable: Bool = false
    var disabled: Bool = false
    var keyboardType: UIKeyboardType = .default
    @State(initialValue: false) var show: Bool
    
    @ViewBuilder
    var textField: some View {
        if $show.wrappedValue {
            EmeraldGenericTextField(
                text: $text,
                focused: _focused,
                placeholder: placeholder,
                accessibility: accessibility,
                errorText: errorText,
                disabled: disabled,
                keyboardType: keyboardType)
        } else {
            SecureTextFieldSwiftUI(
                placeholder: _placeholderState,
                text: $text) {
                self.focused = $0
            }
            .disabled(disabled)
            .frame(height: Constants.EmeraldSwiftUiTextField.textFieldHeight)
        }
    }
    
    var secureTextField: some View {
        textField
            .onReceive(text.publisher.collect()) {
                if maxLength != nil {
                    text = String($0.prefix(maxLength ?? .zero))
                }
            }
            .padding(
                .leading,
                Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
            .padding(
                .trailing, (
                    clearable ?
                        Constants.EmeraldSwiftUiTextField.trailingContentSpacing * 3 +
                        Constants.EmeraldSwiftUiTextField.widthShowButton +
                        Constants.EmeraldSwiftUiTextField.widthClearButton :
                        Constants.EmeraldSwiftUiTextField.trailingContentSpacing +
                        Constants.EmeraldSwiftUiTextField.widthShowButton))
            .overlay(RoundedRectangle(cornerRadius: Constants.EmeraldSwiftUiTextField.cornerRadius)
                        .stroke(EmeraldSwiftUiTextField.getBorderColor(
                                    errorText: errorText,
                                    focused: focused,
                                    disabled: disabled),
                                lineWidth: EmeraldSwiftUiTextField.getBorderWidth(focused: focused)))
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
        HStack(alignment: .top) {
            LabelTextFieldTitleNew(
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
                    secureTextField
                    HStack(spacing: Constants.EmeraldSwiftUiTextField.trailingContentSpacing) {
                        Spacer()
                        if clearable, !text.isEmpty {
                            ClearButton {
                                text = ""
                            }
                        }
                        showButtonContent
                    }
                    .frame(alignment: .trailing)
                    .padding(
                        .trailing,
                             Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
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
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            self.placeholderState = self.focused ? "" : placeholder
            self.focused = false
        }
    }
}

#if DEBUG
@available(iOS 13.0.0, *)
struct EmeraldSecureTextFieldNew_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            EmeraldSecureTextFieldNew(
                text: $name,
                label: "name asda s sada s asda sdasda s d sdas dasds as dfs dfs df",
                placeholder: "placeholder",
                helperText: "this field is for help you",
                keyboardType: .default)
        }
    }
}
#endif
