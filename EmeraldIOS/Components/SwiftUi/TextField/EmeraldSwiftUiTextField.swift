//
//  EmeraldSwiftUiTextField.swift
//  Components
//
//  Created by Ronal Fabra on 23/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct EmeraldSwiftUiTextField: View {
    
    public var textFieldType: TextFieldType
    public var textFormat: TextFormat
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
    public var useLegacy: Bool
    @State public var show: Bool
    
    public init(textFieldType: TextFieldType = .normal,
                text: Binding<String>,
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
                useLegacy: Bool = true,
                show: State<Bool> = State(initialValue: false)) {
        self.textFieldType = textFieldType
        self.textFormat = textFieldType.getTextFormat()
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
        self.useLegacy = useLegacy
        self._show = show
    }
    
    public var body: some View {
        switch textFieldType {
        case .password:
            EmeraldSecureTextField(
                text: $text,
                focused: _focused,
                label: label,
                placeholder: placeholder,
                accessibility: accessibility,
                helperText: helperText,
                errorText: errorText,
                maxLength: maxLength,
                hideCounter: hideCounter,
                clearable: clearable,
                disabled: disabled,
                keyboardType: textFieldType.getKeyboardType(),
                show: _show)
        case .currency:
            if useLegacy {
                EmeraldCurrencyTextField(
                    text: $text,
                    focused: _focused,
                    label: label,
                    placeholder: placeholder,
                    accessibility: accessibility,
                    errorText: errorText,
                    maxLength: maxLength,
                    disabled: disabled,
                    keyboardType: textFieldType.getKeyboardType())
            } else {
                EmeraldCurrencyTextFieldNew(
                    text: $text,
                    focused: _focused,
                    label: label,
                    placeholder: placeholder,
                    accessibility: accessibility,
                    helperText: helperText,
                    errorText: errorText,
                    maxLength: maxLength,
                    hideCounter: hideCounter,
                    clearable: clearable,
                    disabled: disabled,
                    keyboardType: textFieldType.getKeyboardType())
            }
        case .shortDate, .longDate:
            EmeraldDateTextField(
                text: $text,
                focused: _focused,
                label: label,
                placeholder: placeholder,
                accessibility: accessibility,
                helperText: helperText,
                errorText: errorText,
                maxLength: maxLength,
                hideCounter: hideCounter,
                clearable: clearable,
                disabled: disabled,
                textFormat: textFormat,
                keyboardType: textFieldType.getKeyboardType())
        default:
            EmeraldNormalTextField(
                text: $text,
                focused: _focused,
                label: label,
                placeholder: placeholder,
                accessibility: accessibility,
                helperText: helperText,
                errorText: errorText,
                maxLength: maxLength,
                hideCounter: hideCounter,
                clearable: clearable,
                disabled: disabled,
                keyboardType: textFieldType.getKeyboardType())
        }
    }
}

@available(iOS 13.0.0, *)
struct EmeraldSwiftUiTextField_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            EmeraldSwiftUiTextField(
                textFieldType: .normal,
                text: $name,
                label: "name asda s sada s asda sdasda s d sdas dasds as dfs dfs df",
                placeholder: "placeholder",
                helperText: "this field is for help you")
        }
    }
}
