//
//  EmeraldSwiftUiTextView.swift
//  Components
//
//  Created by Ronal Fabra on 21/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct EmeraldSwiftUiTextView: View {
    
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
    public var textViewType: TextViewType
    public var useLegacy: Bool
    
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
                textViewType: TextViewType = .normal,
                useLegacy: Bool = true) {
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
        self.textViewType = textViewType
        self.useLegacy = useLegacy
    }
    
    public var body: some View {
        if useLegacy {
            EmeraldNormalTextViewNew(
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
                keyboardType: textViewType.getKeyboardType())
        } else {
            EmeraldNormalTextView(
                text: $text,
                focused: _focused,
                label: label,
                placeholder: placeholder,
                accessibility: accessibility,
                helperText: helperText,
                errorText: errorText,
                maxLength: maxLength,
                disabled: disabled,
                keyboardType: textViewType.getKeyboardType())
        }
    }
}

#if DEBUG
@available(iOS 13.0.0, *)
struct EmeraldSwiftUiTextView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            EmeraldSwiftUiTextView(
                text: $name,
                placeholder: "placeholder",
                accessibility: "name",
                textViewType: .normal)
        }
    }
}
#endif
