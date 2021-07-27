//
//  EmeraldNormalTextView.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 27/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct EmeraldNormalTextView: View {
    
    @Binding public var text: String
    @State public var focused: Bool
    public var placeholder: String
    public var accessibility: String
    public var errorText: String?
    public var maxLength: Int?
    public var disabled: Bool
    public var keyboardType: UIKeyboardType
    
    public init(text: Binding<String>,
                focused: State<Bool> = State(initialValue: false),
                placeholder: String = "",
                accessibility: String = "",
                errorText: String? = nil,
                maxLength: Int? = nil,
                disabled: Bool = false,
                keyboardType: UIKeyboardType = .default) {
        self._text = text
        self._focused = focused
        self.placeholder = placeholder
        self.accessibility = accessibility
        self.errorText = errorText
        self.maxLength = maxLength
        self.disabled = disabled
        self.keyboardType = keyboardType
    }
    
    @ViewBuilder
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
                .trailing,
                Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
            .padding(
                .top,
                Constants.EmeraldSwiftUiTextField.topContentSpacing)
            .padding(
                .bottom,
                Constants.EmeraldSwiftUiTextField.bottomContentSpacing)
            .overlay(RoundedRectangle(cornerRadius: Constants.EmeraldSwiftUiTextField.cornerRadius)
                        .stroke(EmeraldSwiftUiTextView.getBorderColor(
                                    errorText: errorText,
                                    focused: focused,
                                    disabled: disabled),
                                lineWidth: EmeraldSwiftUiTextView.getBorderWidth(focused: focused)))
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
    
    public var body: some View {
        VStack(alignment: .leading) {
            textView
            errorTextContent
        }
        .padding(
            .leading,
            Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
        .padding(
            .trailing,
            Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
        .padding(
            .bottom,
            Constants.EmeraldSwiftUiTextField.bottomContentPadding)
        .fixedSize(
            horizontal: false,
            vertical: true)
    }
}

#if DEBUG
@available(iOS 13.0.0, *)
struct EmeraldNormalTextView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            EmeraldNormalTextView(
                text: $name,
                placeholder: "placeholder",
                accessibility: "name",
                keyboardType: .emailAddress)
        }
    }
}
#endif
