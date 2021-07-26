//
//  EmeraldGenericTextField.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 26/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

import SwiftUI
import Introspect

@available(iOS 13.0.0, *)
public struct EmeraldGenericTextField: View {
    
    @Binding var text: String
    @State(initialValue: false) var focused: Bool
    var placeholder: String = ""
    var accessibility: String = ""
    var errorText: String? = nil
    var disabled: Bool = false
    var keyboardType: UIKeyboardType = .default
    
    public var body: some View {
        TextField(
            placeholder,
            text: $text,
            onEditingChanged: {
                self.focused = $0
            }, onCommit: {
                self.focused = false
            })
            .disabled(disabled)
            .keyboardType(keyboardType)
            .accessibility(identifier: accessibility)
            .disableAutocorrection(true)
            .font(Typography(
                    size: .h5,
                    weight: .semibold).suFont)
            .foregroundColor(Constants.EmeraldSwiftUiTextField.textColor)
            .frame(height: Constants.EmeraldSwiftUiTextField.textFieldHeight)
            .introspectTextField { textField in
                if focused {
                    textField.becomeFirstResponder()
                }
            }
    }
}

@available(iOS 13.0.0, *)
struct EmeraldGenericTextField_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            EmeraldGenericTextField(
                text: $name,
                placeholder: "placeholder",
                keyboardType: .default)
        }
    }
}
