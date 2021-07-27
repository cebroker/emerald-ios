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
    // MARK: States
    @State private var mainTitle = "Main Title"
    @State private var subTitle = "Sub Title"
    @State private var tableHeader = "Table Header"
    @State private var link = "link"
    @State private var hello = "hello"
    @State private var bodyText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    @State(initialValue: "buttonName") var buttonName: String
    @State(initialValue: "") var normal: String
    @State(initialValue: "") var normalNew: String
    @State(initialValue: "") var email: String
    @State(initialValue: "") var emailNew: String
    @State(initialValue: "") var password: String
    @State(initialValue: "") var passwordNew: String
    @State(initialValue: "") var currency: String
    @State(initialValue: "") var currencyNew: String
    @State(initialValue: "") var shortDate: String
    @State(initialValue: "") var shortDateNew: String
    @State(initialValue: "") var longDate: String
    @State(initialValue: "") var longDateNew: String
    @State(initialValue: "") var textView: String
    @State(initialValue: "") var textViewNew: String
    @State(initialValue: "") var disabledField: String
    @State(initialValue: nil) var errorText: String?
    @State(initialValue: nil) var errorTextNew: String?
    
    // MARK: ViewBuilder
    @ViewBuilder
    var emeraldLabelByStory: some View {
        VStack {
            Text("Labels")
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .font(.title)
                .foregroundColor(.red)
            Spacer()
            VStack(alignment: .center, spacing: 5) {
                EmeraldSwiftUiLabel(
                    text: $mainTitle,
                    themeStyle: .mainTitle)
                EmeraldSwiftUiLabel(
                    text: $subTitle,
                    themeStyle: .subtitle)
                EmeraldSwiftUiLabel(
                    text: $tableHeader,
                    themeStyle: .tableHeader)
                EmeraldSwiftUiLabel(
                    text: $link,
                    themeStyle: .link)
                Spacer()
            }
            VStack(alignment: .center, spacing: 5) {
                EmeraldSwiftUiLabel(
                    text: $bodyText,
                    themeStyle: .body)
                EmeraldSwiftUiLabel(
                    text: $bodyText,
                    themeStyle: .bodyBold)
            }
        }
    }
    
    @ViewBuilder
    var emeraldChipViewByStory: some View {
        VStack {
            Text("Chips View")
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .font(.title)
                .foregroundColor(.red)
            Spacer()
            HStack(alignment: .center, spacing: 5) {
                EmeraldSwiftUiChipView(text: $hello, themeStyle: .simple)
                EmeraldSwiftUiChipView(text: $hello, themeStyle: .error)
                EmeraldSwiftUiChipView(text: $hello, themeStyle: .success)
                EmeraldSwiftUiChipView(text: $hello, themeStyle: .warning)
                EmeraldSwiftUiChipView(text: $hello, themeStyle: .dismissable)
            }
        }
    }
    
    @ViewBuilder
    var emeraldButtonsView: some View {
        VStack {
            Text("Buttons")
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .font(.title)
                .foregroundColor(.red)
            Spacer()
            VStack {
                EmeraldSwiftUIButton(
                    buttonName: $buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .plain)
                EmeraldSwiftUIButton(
                    buttonName: $buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .plainPrimary)
            }
            VStack {
            EmeraldSwiftUIButton(
                buttonName: $buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .primary)
            EmeraldSwiftUIButton(
                buttonName: $buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .primarySuccess)
            EmeraldSwiftUIButton(
                buttonName: $buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .primaryWarning)
            EmeraldSwiftUIButton(
                buttonName: $buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .primaryError)
            EmeraldSwiftUIButton(
                buttonName: $buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .primarySmall)
            EmeraldSwiftUIButton(
                buttonName: $buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .primaryLarge)
            }
            VStack {
                EmeraldSwiftUIButton(
                    buttonName: $buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .secondary)
                EmeraldSwiftUIButton(
                    buttonName: $buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .secondarySmall)
                EmeraldSwiftUIButton(
                    buttonName: $buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .secondaryLarge)
            }
            VStack {
                EmeraldSwiftUIButton(
                    buttonName: $buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .link)
                EmeraldSwiftUIButton(
                    buttonName: $buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .linkButton)
            }
            EmeraldSwiftUIButton(
                buttonName: $buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .witheAndBlueColor)
            EmeraldSwiftUIButton(
                buttonName: $buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .warning)
        }
    }
    
    @ViewBuilder
    var emeraldTextFieldsView: some View {
        VStack {
            Text("TextFields")
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .font(.title)
                .foregroundColor(.red)
            Spacer()
            VStack {
                VStack {
                    Text("V 1.0")
                    EmeraldSwiftUiTextField(
                        text: $normalNew,
                        label: "Normal",
                        useLegacy: false)
                    EmeraldSwiftUiTextField(
                        text: $disabledField,
                        label: "Normal",
                        disabled: true,
                        useLegacy: false)
                    Text("V 2.0")
                    EmeraldSwiftUiTextField(
                        text: $normal,
                        label: "Normal")
                    EmeraldSwiftUiTextField(
                        text: $disabledField,
                        label: "Normal",
                        disabled: true)
                }
                Divider()
            }
            VStack {
                VStack {
                    Text("V 1.0")
                    EmeraldSwiftUiTextField(
                        textFieldType: .email,
                        text: $email,
                        label: "Email",
                        placeholder: "correo@mail.com",
                        errorText: errorText,
                        useLegacy: false)
                        .onReceive(email.publisher.collect()) {
                            errorText = isValidEmail(String($0)) || String($0).isEmpty ?
                                nil :
                                "email invalido"
                        }
                    EmeraldSwiftUiTextField(
                        textFieldType: .email,
                        text: $disabledField,
                        label: "Email",
                        placeholder: "correo@mail.com",
                        disabled: true,
                        useLegacy: false)
                    Text("V 2.0")
                    EmeraldSwiftUiTextField(
                        textFieldType: .email,
                        text: $emailNew,
                        label: "Email",
                        placeholder: "correo@mail.com",
                        errorText: errorTextNew)
                        .onReceive(emailNew.publisher.collect()) {
                            errorTextNew = isValidEmail(String($0)) || String($0).isEmpty ?
                                nil :
                                "email invalido"
                        }
                    EmeraldSwiftUiTextField(
                        textFieldType: .email,
                        text: $disabledField,
                        label: "Email",
                        placeholder: "correo@mail.com",
                        disabled: true)
                }
                Divider()
            }
            VStack {
                VStack {
                    Text("V 1.0")
                    EmeraldSwiftUiTextField(
                        textFieldType: .password,
                        text: $password,
                        label: "Pasword",
                        placeholder: "*********",
                        useLegacy: false)
                    EmeraldSwiftUiTextField(
                        textFieldType: .password,
                        text: $disabledField,
                        label: "Pasword",
                        placeholder: "*********",
                        disabled: true,
                        useLegacy: false)
                    Text("V 2.0")
                    EmeraldSwiftUiTextField(
                        textFieldType: .password,
                        text: $passwordNew,
                        label: "Pasword",
                        placeholder: "*********")
                    EmeraldSwiftUiTextField(
                        textFieldType: .password,
                        text: $disabledField,
                        label: "Pasword",
                        placeholder: "*********",
                        disabled: true)
                }
                Divider()
            }
            VStack {
                VStack {
                    Text("V 1.0")
                    EmeraldSwiftUiTextField(
                        textFieldType: .currency,
                        text: $currency,
                        label: "Currency",
                        placeholder: "$300.000,00",
                        useLegacy: false)
                    EmeraldSwiftUiTextField(
                        textFieldType: .currency,
                        text: $disabledField,
                        label: "Currency",
                        placeholder: "$300.000,00",
                        disabled: true,
                        useLegacy: false)
                    Text("V 2.0")
                    EmeraldSwiftUiTextField(
                        textFieldType: .currency,
                        text: $currencyNew,
                        label: "Currency",
                        placeholder: "300.000,00")
                    EmeraldSwiftUiTextField(
                        textFieldType: .currency,
                        text: $disabledField,
                        label: "Currency",
                        placeholder: "300.000,00",
                        disabled: true)
                }
                Divider()
            }
            VStack {
                VStack {
                    Text("V 1.0")
                    EmeraldSwiftUiTextField(
                        textFieldType: .shortDate,
                        text: $shortDate,
                        label: "Short Date",
                        placeholder: "12/2021",
                        useLegacy: false)
                    EmeraldSwiftUiTextField(
                        textFieldType: .shortDate,
                        text: $disabledField,
                        label: "Short Date",
                        placeholder: "12/2021",
                        disabled: true,
                        useLegacy: false)
                    Text("V 2.0")
                    EmeraldSwiftUiTextField(
                        textFieldType: .shortDate,
                        text: $shortDateNew,
                        label: "Short Date")
                    EmeraldSwiftUiTextField(
                        textFieldType: .shortDate,
                        text: $disabledField,
                        label: "Short Date",
                        disabled: true)
                }
                Divider()
            }
            VStack {
                VStack {
                    Text("V 1.0")
                    EmeraldSwiftUiTextField(
                        textFieldType: .longDate,
                        text: $longDate,
                        label: "Long Date",
                        placeholder: "12/12/2021",
                        useLegacy: false)
                    EmeraldSwiftUiTextField(
                        textFieldType: .longDate,
                        text: $disabledField,
                        label: "Long Date",
                        placeholder: "12/12/2021",
                        disabled: true,
                        useLegacy: false)
                    Text("V 2.0")
                    EmeraldSwiftUiTextField(
                        textFieldType: .longDate,
                        text: $longDateNew,
                        label: "Long Date")
                    EmeraldSwiftUiTextField(
                        textFieldType: .longDate,
                        text: $disabledField,
                        label: "Long Date",
                        disabled: true)
                }
                Divider()
            }
            VStack {
                VStack {
                    Text("V 1.0")
                    EmeraldSwiftUiTextView(
                        text: $textView,
                        placeholder: "placeholder",
                        helperText: "this is a helper text",
                        useLegacy: false)
                    EmeraldSwiftUiTextView(
                        text: $disabledField,
                        placeholder: "placeholder",
                        helperText: "this is a helper text",
                        disabled: true,
                        useLegacy: false)
                    Text("V 2.0")
                    EmeraldSwiftUiTextView(
                        text: $textViewNew,
                        label: "Text View",
                        placeholder: "placeholder",
                        helperText: "this is a helper text")
                    EmeraldSwiftUiTextView(
                        text: $disabledField,
                        label: "Text View",
                        placeholder: "placeholder",
                        helperText: "this is a helper text",
                        disabled: true)
                }
            }
        }
    }
    
    // MARK: Body
    var body: some View {
        ScrollView {
            emeraldLabelByStory
            .padding()
            Divider()
            emeraldChipViewByStory
            .padding()
            Divider()
            emeraldButtonsView
            .padding()
            Divider()
            emeraldTextFieldsView
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
        SwiftUiView()
    }
}
