//
//  SecureTextFieldSwiftUI.swift
//  Components
//
//  Created by Ronal Fabra on 23/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct SecureTextFieldSwiftUI: UIViewRepresentable {
    
    @State(initialValue: "") var placeholder: String
    @State(initialValue: false) var focused: Bool
    @Binding var text: String
    var onEditingChanged: (Bool) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.isUserInteractionEnabled = true
        textField.backgroundColor = .clear
        textField.placeholder = placeholder
        textField.isSecureTextEntry = true
        textField.font = Typography(size: .h6, weight: .semibold).uiFont
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        if focused {
            uiView.becomeFirstResponder()
        }
    }
    
    class Coordinator : NSObject, UITextFieldDelegate {
        
        var parent: SecureTextFieldSwiftUI
        
        init(_ uiTextField: SecureTextFieldSwiftUI) {
            parent = uiTextField
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.parent.text = textField.text ?? ""
            }
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.onEditingChanged(true)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.onEditingChanged(false)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            parent.onEditingChanged(false)
            textField.resignFirstResponder()
            return true
        }
    }
}

#if DEBUG
@available(iOS 13.0.0, *)
struct SecureTextFieldSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        @State(initialValue: "") var placeholder: String
        
        var body: some View {
            SecureTextFieldSwiftUI(placeholder: _placeholder, text: $name) { _ in }
        }
    }
}
#endif
