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
    @State private var titleText = "RadioButtonTitle"
    @State private var subTitleText = "Radio Button SubTitle"
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
    @State var selected: String?
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
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .plain)
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .plainPrimary)
            }
            VStack {
            EmeraldSwiftUIButton(
                buttonName: _buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .primary)
            EmeraldSwiftUIButton(
                buttonName: _buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .primarySuccess)
            EmeraldSwiftUIButton(
                buttonName: _buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .primaryWarning)
            EmeraldSwiftUIButton(
                buttonName: _buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .primaryError)
            EmeraldSwiftUIButton(
                buttonName: _buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .primarySmall)
            EmeraldSwiftUIButton(
                buttonName: _buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .primaryLarge)
            }
            VStack {
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .secondary)
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .secondarySmall)
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .secondaryLarge)
            }
            VStack {
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .link)
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .linkButton)
            }
            EmeraldSwiftUIButton(
                buttonName: _buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .witheAndBlueColor)
            EmeraldSwiftUIButton(
                buttonName: _buttonName,
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
                        text: _normalNew,
                        label: "Normal",
                        useLegacy: false)
                    EmeraldSwiftUiTextField(
                        text: _disabledField,
                        label: "Normal",
                        disabled: true,
                        useLegacy: false)
                    Text("V 2.0")
                    EmeraldSwiftUiTextField(
                        text: _normal,
                        label: "Normal",
                        maxLength: 10,
                        clearable: true)
                    EmeraldSwiftUiTextField(
                        text: _disabledField,
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
                        text: _email,
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
                        text: _disabledField,
                        label: "Email",
                        placeholder: "correo@mail.com",
                        disabled: true,
                        useLegacy: false)
                    Text("V 2.0")
                    EmeraldSwiftUiTextField(
                        textFieldType: .email,
                        text: _emailNew,
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
                        text: _disabledField,
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
                        text: _password,
                        label: "Pasword",
                        placeholder: "*********",
                        useLegacy: false)
                    EmeraldSwiftUiTextField(
                        textFieldType: .password,
                        text: _disabledField,
                        label: "Pasword",
                        placeholder: "*********",
                        disabled: true,
                        useLegacy: false)
                    Text("V 2.0")
                    EmeraldSwiftUiTextField(
                        textFieldType: .password,
                        text: _passwordNew,
                        label: "Pasword",
                        placeholder: "*********")
                    EmeraldSwiftUiTextField(
                        textFieldType: .password,
                        text: _disabledField,
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
                        text: _currency,
                        label: "Currency",
                        placeholder: "$300.000,00",
                        useLegacy: false)
                    EmeraldSwiftUiTextField(
                        textFieldType: .currency,
                        text: _disabledField,
                        label: "Currency",
                        placeholder: "$300.000,00",
                        disabled: true,
                        useLegacy: false)
                    Text("V 2.0")
                    EmeraldSwiftUiTextField(
                        textFieldType: .currency,
                        text: _currencyNew,
                        label: "Currency",
                        placeholder: "300.000,00")
                    EmeraldSwiftUiTextField(
                        textFieldType: .currency,
                        text: _disabledField,
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
                        text: _shortDate,
                        label: "Short Date",
                        placeholder: "12/2021",
                        useLegacy: false)
                    EmeraldSwiftUiTextField(
                        textFieldType: .shortDate,
                        text: _disabledField,
                        label: "Short Date",
                        placeholder: "12/2021",
                        disabled: true,
                        useLegacy: false)
                    Text("V 2.0")
                    EmeraldSwiftUiTextField(
                        textFieldType: .shortDate,
                        text: _shortDateNew,
                        label: "Short Date")
                    EmeraldSwiftUiTextField(
                        textFieldType: .shortDate,
                        text: _disabledField,
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
                        text: _longDate,
                        label: "Long Date",
                        placeholder: "12/12/2021",
                        useLegacy: false)
                    EmeraldSwiftUiTextField(
                        textFieldType: .longDate,
                        text: _disabledField,
                        label: "Long Date",
                        placeholder: "12/12/2021",
                        disabled: true,
                        useLegacy: false)
                    Text("V 2.0")
                    EmeraldSwiftUiTextField(
                        textFieldType: .longDate,
                        text: _longDateNew,
                        label: "Long Date")
                    EmeraldSwiftUiTextField(
                        textFieldType: .longDate,
                        text: _disabledField,
                        label: "Long Date",
                        disabled: true)
                }
                Divider()
            }
            VStack {
                VStack {
                    Text("V 1.0")
                    EmeraldSwiftUiTextView(
                        text: _textView,
                        label: "Text View",
                        placeholder: "placeholder",
                        helperText: "this is a helper text",
                        useLegacy: false)
                    EmeraldSwiftUiTextView(
                        text: _disabledField,
                        label: "Text View",
                        placeholder: "placeholder",
                        helperText: "this is a helper text",
                        disabled: true,
                        useLegacy: false)
                    Text("V 2.0")
                    EmeraldSwiftUiTextView(
                        text: _textViewNew,
                        label: "Text View",
                        placeholder: "placeholder",
                        helperText: "this is a helper text",
                        clearable: true)
                    EmeraldSwiftUiTextView(
                        text: _disabledField,
                        label: "Text View",
                        placeholder: "placeholder",
                        helperText: "this is a helper text",
                        disabled: true)
                }
            }
        }
    }
    
    @ViewBuilder
    var emeraldRadioButtonView: some View {
        VStack {
            EmeraldSwiftUiLabel(
                text: $titleText,
                themeStyle: .mainTitle)
            EmeraldSwiftUiLabel(
                text: $subTitleText,
                themeStyle: .subtitle)
        }
        VStack {
            if #available(iOS 14.0, *) {
                ForEach(radioGroups,id: \.id){ data in
                    EmeraldRadioButtonUI(selected: self.$selected,
                                         textRadioButton: data.title,
                                         key: data.id)
                    if  self.selected == data.id && data.requiredExplanation == true {
                        EmeraldSwiftUiTextView(
                            text: _textViewNew,
                            focused: State(initialValue: data.requiredExplanation),
                            label: "",
                            placeholder: "Description",
                            helperText: "",
                            clearable: true)
                            .padding(-10)
                    }
                }.onChange(of: selected) { Equatable in
                    self.textViewNew = ""
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    // MARK: Body
    var body: some View {
        ScrollView {
            emeraldRadioButtonView
            .padding()
            Divider()
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


let radioButton = [
    [
        "id": "1",
        "title": "prueba1",
        "requiredExplanation": "false"
    ],
    [
        "id": "2",
        "requiredExplanation": "true"
    ],
    [
        "id": "3",
        "requiredExplanation": "false"
    ],
    [
        "id": "4",
        "requiredExplanation": "true"
    ]
]

typealias radioGroup = [String:String]

let radioGroups: [radioButtonModel] = [
    radioButtonModel(id: "1", title: "prueba1", requiredExplanation: false),
    radioButtonModel(id: "2", title: "prueba2", requiredExplanation: true),
    radioButtonModel(id: "3", title: "prueba3", requiredExplanation: false),
    radioButtonModel(id: "4", title: "prueba4", requiredExplanation: true)
  
]

struct radioButtonModel {

    let id: String
    let title: String
    var requiredExplanation: Bool

}
