//
//  EmeraldNormalTextViewNew.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 27/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct EmeraldNormalTextViewNew: View {
    
    @Binding public var text: String
    @State public var focused: Bool
    public var label: String
    public var placeholder: String
    public var accessibility: String
    public var helperText: String?
    public var errorText: String?
    public var maxLength: Int?
    public var hideCounter: Bool
    public var clearable: Bool
    public var disabled: Bool
    public var keyboardType: UIKeyboardType
    
    public init(text: Binding<String>,
                focused: State<Bool> = State(initialValue: false),
                label: String = "",
                placeholder: String = "",
                accessibility: String = "",
                helperText: String? = nil,
                errorText: String? = nil,
                maxLength: Int? = nil,
                hideCounter: Bool = false,
                clearable: Bool = false,
                disabled: Bool = false,
                keyboardType: UIKeyboardType = .default) {
        self._text = text
        self._focused = focused
        self.label = label
        self.placeholder = placeholder
        self.accessibility = accessibility
        self.helperText = helperText
        self.errorText = errorText
        self.maxLength = maxLength
        self.hideCounter = hideCounter
        self.clearable = clearable
        self.disabled = disabled
        self.keyboardType = keyboardType
    }
    
    var textView: some View {
        EmeraldGenericTextView(
            text: $text,
            focused: _focused,
            placeholder: placeholder,
            accessibility: accessibility,
            disabled: disabled,
            keyboardType: keyboardType)
        .onReceive(text.publisher.collect()) {
            if maxLength != nil {
                text = String($0.prefix(maxLength ?? 0))
            }
        }
        .padding(
            .leading,
            Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
        .padding(
            .trailing, (
                clearable ?
                    Constants.EmeraldSwiftUiTextField.trailingContentSpacing +
                    (Constants.EmeraldSwiftUiTextField.widthClearButton * 2.5) :
                    Constants.EmeraldSwiftUiTextField.trailingContentSpacing))
        .padding(
            .top,
            Constants.EmeraldSwiftUiTextField.topContentSpacing)
        .padding(
            .bottom,
            Constants.EmeraldSwiftUiTextField.bottomContentSpacing)
        .overlay(RoundedRectangle(cornerRadius: Constants.EmeraldSwiftUiTextField.cornerRadius)
                    .stroke(
                        (errorText != nil ?
                            Constants.EmeraldSwiftUiTextField.errorColor :
                            (focused ?
                                Constants.EmeraldSwiftUiTextField.focusColor :
                                Constants.EmeraldSwiftUiTextField.borderColor)),
                        lineWidth:
                            self.focused ?
                            Constants.EmeraldSwiftUiTextField.borderWidthFocused :
                            Constants.EmeraldSwiftUiTextField.borderWidth))
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
        .padding(
            .trailing,
            Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
        .padding(
            .top,
            -Constants.EmeraldSwiftUiTextField.topContentSpacing)
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
                    textView
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
        .background(Color.white)
    }
}

@available(iOS 13.0.0, *)
struct EmeraldNormalTextViewNew_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            EmeraldNormalTextViewNew(
                text: $name,
                label: "name asda s sada s asda sdasda s d sdas dasds as dfs dfs df",
                placeholder: "placeholder",
                accessibility: "name",
                helperText: "this field is for help you",
                clearable: true,
                keyboardType: .emailAddress)
        }
    }
}
