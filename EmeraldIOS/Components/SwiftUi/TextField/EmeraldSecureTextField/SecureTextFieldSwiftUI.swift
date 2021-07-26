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
    
    var placeHolder:String = ""
    @Binding var text: String
    var onEditingChanged: (Bool) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.isUserInteractionEnabled = true
        textField.backgroundColor = UIColor.white
        textField.placeholder = placeHolder
        textField.isSecureTextEntry = true
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
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
    }
}

@available(iOS 13.0.0, *)
struct SecureTextFieldSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            SecureTextFieldSwiftUI(placeHolder: "", text: $name) { _ in }
        }
    }
}
