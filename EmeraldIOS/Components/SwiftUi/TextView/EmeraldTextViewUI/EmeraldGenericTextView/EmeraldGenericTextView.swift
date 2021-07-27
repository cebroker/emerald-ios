//
//  EmeraldGenericTextView.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 27/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct EmeraldGenericTextView: View {
    
    @Binding public var text: String
    @State public var focused: Bool
    public var placeholder: String
    public var accessibility: String
    public var disabled: Bool
    public var keyboardType: UIKeyboardType
    
    public init(text: Binding<String>,
                focused: State<Bool> = State(initialValue: false),
                placeholder: String = "",
                accessibility: String = "",
                disabled: Bool = false,
                keyboardType: UIKeyboardType = .default) {
        self._text = text
        self._focused = focused
        self.placeholder = placeholder
        self.accessibility = accessibility
        self.disabled = disabled
        self.keyboardType = keyboardType
    }
    
    public var body: some View {
        TextViewSwiftUi(
            text: $text,
            disabled: disabled,
            placeHolder: placeholder) {
            self.focused = $0
        }
        .keyboardType(keyboardType)
        .accessibility(identifier: accessibility)
        .font(Typography(
                size: .h5,
                weight: .semibold).suFont)
        .foregroundColor(Constants.EmeraldSwiftUiTextField.textColor)
        .frame(height: Constants.EmeraldSwiftUiTextField.textAreaHeight)
        .introspectTextView { textView in
            if focused {
                textView.becomeFirstResponder()
            }
        }
    }
}

#if DEBUG
@available(iOS 13.0.0, *)
struct EmeraldGenericTextView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            EmeraldGenericTextView(
                text: $name,
                placeholder: "placeholder",
                accessibility: "name")
        }
    }
}
#endif
