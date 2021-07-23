//
//  SwiftUiView.swift
//  ProofOfConcept
//
//  Created by Daniel Crespo Duarte on 7/22/21.
//  Copyright © 2021 Luis David Goyes Garces. All rights reserved.
//
import EmeraldIOS
import SwiftUI

@available(iOS 13.0.0, *)
struct SwiftUiView: View {
    @State static var text = "Main title"
    @State(initialValue: "") var normal: String
    @State(initialValue: "") var email: String
    @State(initialValue: "") var password: String
    @State(initialValue: "") var currency: String
    @State(initialValue: "") var numeric: String
    @State(initialValue: "") var textView: String
    @State(initialValue: nil) var errorText: String?
    
    init(normal: State<String> = State(initialValue: ""),
         email: State<String> = State(initialValue: ""),
         password: State<String> = State(initialValue: ""),
         currency: State<String> = State(initialValue: ""),
         numeric: State<String> = State(initialValue: ""),
         textView: State<String> = State(initialValue: ""),
         errorText: State<String?> = State(initialValue: nil)) {
        _normal = normal
        _email = email
        _password = password
        _currency = currency
        _numeric = numeric
        _textView = textView
        _errorText = errorText
    }
    
    @ViewBuilder
    var emeraldLabelByStory: some View {
        EmeraldSwiftUiLabel(
            text: SwiftUiView.$text,
            themeStyle: .mainTitle)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                emeraldLabelByStory
                EmeraldSwiftUiTextField(
                    text: $normal,
                    label: "Normal")
                EmeraldSwiftUiTextField(
                    textFieldType: .email,
                    text: $email,
                    label: "Email",
                    placeholder: "correo@mail.com",
                    errorText: errorText)
                    .onReceive(email.publisher.collect()) {
                        errorText = isValidEmail(String($0)) || String($0).isEmpty ?
                            nil :
                            "email invalido"
                    }
                EmeraldSwiftUiTextField(
                    textFieldType: .password,
                    text: $password,
                    label: "Pasword")
                EmeraldSwiftUiTextField(
                    textFieldType: .currency,
                    text: $currency,
                    label: "Currency")
                EmeraldSwiftUiTextField(
                    textFieldType: .numeric,
                    text: $numeric,
                    label: "Numeric")
                EmeraldSwiftUiTextView(
                    text: $textView,
                    label: "Text View")
            }
            .padding()
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

@available(iOS 13.0.0, *)
struct SwiftUiView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var normal: String
        @State(initialValue: "") var email: String
        @State(initialValue: "") var password: String
        @State(initialValue: "") var currency: String
        @State(initialValue: "") var numeric: String
        
        var body: some View {
            SwiftUiView()
        }
    }
}
