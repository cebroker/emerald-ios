//
//  EmeraldSecureTextField.swift
//  Components
//
//  Created by Ronal Fabra on 23/07/21.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct EmeraldSecureTextField: View {
    
    @Binding var text: String
    @State(initialValue: false) var focused: Bool
    var label: String = ""
    var placeholder: String = ""
    var accessibility: String = ""
    var helperText: String? = nil
    var errorText: String? = nil
    var maxLength: Int? = nil
    var hideCounter: Bool = false
    var clearable: Bool = true
    var disabled: Bool = false
    var keyboardType: UIKeyboardType = .default
    @State(initialValue: false) var show: Bool
    
    @ViewBuilder
    var textField: some View {
        if $show.wrappedValue {
            TextField(
                placeholder,
                text: $text,
                onEditingChanged: {
                    self.focused = $0
                }, onCommit: {
                    self.focused = false
                })
        } else {
            SecureTextFieldSwiftUI(
                placeHolder: placeholder,
                text: $text) {
                self.focused = $0
            }
        }
    }
    
    var secureTextField: some View {
        textField
            .onReceive(text.publisher.collect()) {
                if maxLength != nil {
                    text = String($0.prefix(maxLength ?? 0))
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
                Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
            .padding(
                .trailing, (
                    clearable ?
                        Constants.EmeraldSwiftUiTextField.trailingContentSpacing +
                        Constants.EmeraldSwiftUiTextField.widthClearButton +
                        Constants.EmeraldSwiftUiTextField.widthShowButton :
                        Constants.EmeraldSwiftUiTextField.widthShowButton))
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
    
    var clearButtonContent: some View {
        ClearButton {
            DispatchQueue.main.async {
                text = ""
            }
        }
        .padding(
            .trailing,
            Constants.EmeraldSwiftUiTextField.widthShowButton)
        .padding(
            .top,
            Constants.EmeraldSwiftUiTextField.textFieldHeight * 0.5 -
                Constants.EmeraldSwiftUiTextField.widthClearButton * 0.5)
    }
    
    var showButtonContent: some View {
        HStack {
            Spacer()
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
                    secureTextField
                    if clearable, !text.isEmpty {
                        clearButtonContent
                    }
                    showButtonContent
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
                helperText: "this field is for help you",
                keyboardType: .default)
        }
    }
}
