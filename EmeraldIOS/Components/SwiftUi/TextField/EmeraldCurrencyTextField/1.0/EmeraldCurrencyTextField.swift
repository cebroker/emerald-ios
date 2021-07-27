//
//  EmeraldCurrencyTextField.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 26/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct EmeraldCurrencyTextField: View {
    
    @Binding var text: String
    @State(initialValue: false) var focused: Bool
    var label: String = ""
    var placeholder: String = ""
    var accessibility: String = ""
    var errorText: String? = nil
    var maxLength: Int? = nil
    var disabled: Bool = false
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        EmeraldNormalTextField(
            text: $text,
            focused: _focused,
            label: label,
            placeholder: placeholder,
            accessibility: accessibility,
            errorText: errorText,
            maxLength: maxLength,
            disabled: disabled,
            keyboardType: keyboardType)
            .onReceive(text.publisher.collect()) {
                if maxLength != nil {
                    let str = String($0.prefix(maxLength ?? .zero))
                    text = str.currencyInputFormatting(with: Constants.Values.dollar)
                } else {
                    text = String($0).currencyInputFormatting(with: Constants.Values.dollar)
                }
            }
    }
}

#if DEBUG
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
                label: "name asda s sada s asda name asda s sada s asda name asda s sada s asda ",
                placeholder: "placeholder",
                keyboardType: .default)
        }
    }
}
#endif
