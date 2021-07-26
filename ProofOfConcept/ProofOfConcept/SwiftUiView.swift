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
    @State(initialValue: "") var shortDate: String
    @State(initialValue: "") var longDate: String
    @State(initialValue: "") var textView: String
    @State(initialValue: "") var disabledField: String
    @State(initialValue: nil) var errorText: String?
    
    init(normal: State<String> = State(initialValue: ""),
         email: State<String> = State(initialValue: ""),
         password: State<String> = State(initialValue: ""),
         currency: State<String> = State(initialValue: ""),
         shortDate: State<String> = State(initialValue: ""),
         longDate: State<String> = State(initialValue: ""),
         textView: State<String> = State(initialValue: ""),
         disabledField: State<String> = State(initialValue: ""),
         errorText: State<String?> = State(initialValue: nil)) {
        _normal = normal
        _email = email
        _password = password
        _currency = currency
        _shortDate = shortDate
        _longDate = longDate
        _textView = textView
        _disabledField = disabledField
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
            }
            VStack {
                Text("ENABLED")
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
                    label: "Currency",
                    maxLength: 10)
                EmeraldSwiftUiTextField(
                    textFieldType: .shortDate,
                    text: $shortDate,
                    label: "Short Date")
                EmeraldSwiftUiTextField(
                    textFieldType: .longDate,
                    text: $longDate,
                    label: "Long Date")
                EmeraldSwiftUiTextView(
                    text: $textView,
                    label: "Text View",
                    helperText: "this is a helper text")
            }
            .padding()
            VStack {
                Text("DISABLED")
                EmeraldSwiftUiTextField(
                    text: $disabledField,
                    label: "Normal",
                    disabled: true)
                EmeraldSwiftUiTextField(
                    textFieldType: .email,
                    text: $disabledField,
                    label: "Email",
                    placeholder: "correo@mail.com",
                    errorText: errorText,
                    disabled: true)
                EmeraldSwiftUiTextField(
                    textFieldType: .password,
                    text: $disabledField,
                    label: "Pasword",
                    disabled: true)
                EmeraldSwiftUiTextField(
                    textFieldType: .currency,
                    text: $disabledField,
                    label: "Currency",
                    maxLength: 10,
                    disabled: true)
                EmeraldSwiftUiTextField(
                    textFieldType: .shortDate,
                    text: $disabledField,
                    label: "Short Date",
                    disabled: true)
                EmeraldSwiftUiTextField(
                    textFieldType: .longDate,
                    text: $disabledField,
                    label: "Long Date",
                    disabled: true)
                EmeraldSwiftUiTextView(
                    text: $disabledField,
                    label: "Text View",
                    helperText: "this is a helper text",
                    disabled: true)
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
