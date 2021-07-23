//
//  EmeraldSwiftUiTextField.swift
//  Components
//
//  Created by Ronal Fabra on 23/07/21.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct EmeraldSwiftUiTextField: View {
    
    public var textFieldType: TextFieldType = .normal
    @Binding public var text: String
    @State public var focused: Bool
    public var label: String = ""
    public var placeholder: String = ""
    public var accessibility: String = ""
    public var helperText: String? = nil
    public var errorText: String? = nil
    public var maxLength: Int? = nil
    public var hideCounter: Bool = false
    public var clearable: Bool = false
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
                show: State<Bool> = State(initialValue: false)) {
        self.textFieldType = textFieldType
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
                keyboardType: textFieldType.getKeyboardType(),
                show: _show)
        case .currency:
            EmeraldCurrencyTextField(
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
                keyboardType: textFieldType.getKeyboardType())
        default:
            EmeraldGeneralTextField(
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
