//
//  SwiftUiView.swift
//  ProofOfConcept
//
//  Created by Daniel Crespo Duarte on 7/22/21.
//  Copyright © 2021 Luis David Goyes Garces. All rights reserved.
//
import EmeraldIOS
import SwiftUI

final class DataSelectable: Selectable {
    public var id: String
    public var name: String
    
    public init(
        id: String,
        name: String) {
        self.id = id
        self.name = name
    }
    
    func getSelectableText() -> String {
        name
    }
}

@available(iOS 13.0.0, *)
struct SwiftUiView: View {
    //MARK: Constants
    private let actionButton = "Action button"
    
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
    @State(initialValue: "") private var normal: String
    @State(initialValue: "") private var normalNew: String
    @State(initialValue: "") private var email: String
    @State(initialValue: "") private var emailNew: String
    @State(initialValue: "") private var password: String
    @State(initialValue: "") private var passwordNew: String
    @State(initialValue: "") private var currency: String
    @State(initialValue: "") private var currencyNew: String
    @State(initialValue: "") private var shortDate: String
    @State(initialValue: "") private var shortDateNew: String
    @State(initialValue: "") private var longDate: String
    @State(initialValue: "") private var longDateNew: String
    @State(initialValue: "") private var textView: String
    @State(initialValue: "") private var textViewtwo: String
    @State(initialValue: "eferewrwrwerwerewrerewr") private var textViewthree: String
    @State(initialValue: "") private var textViewNew: String
    @State(initialValue: "") private var disabledField: String
    @State(initialValue: nil) private var errorText: String?
    @State(initialValue: nil) private var errorTextNew: String?
    // MARK: It's for radioButton
    @State private var selected: String?
    
    // MARK: It's for New Textfields
    @State(initialValue: "") private var textV2: String
    @State(initialValue: nil) private var errorTextV2: String?
    @State(initialValue: "") private var textV3: String
    @State(initialValue: nil) private var errorTextV3: String?
    
    // MARK: It's for New Textfields Picker
    @State private var pickerData: [Selectable] = [DataSelectable(id: "1", name: "name 1"),
                                           DataSelectable(id: "2", name: "name 2")]
    @State private var itemPickerSelected: Int?
    @State(initialValue: "") private var textV4: String
    @State(initialValue: nil) private var errorTextV4: String?
    
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
                    themeStyle: .plain) {
                        print(actionButton)
                    }
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .plainPrimary) {
                        print(actionButton)
                    }
            }
            VStack {
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .primary) {
                        print(actionButton)
                    }
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .primarySuccess){}
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .primaryWarning) {
                        print(actionButton)
                    }
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .primaryError) {}
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .primarySmall) {}
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .primaryLarge) {}
            }
            VStack {
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .secondary) {}
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .secondarySmall) {}
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .secondaryLarge) {}
            }
            VStack {
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .link) {}
                EmeraldSwiftUIButton(
                    buttonName: _buttonName,
                    isEnabled: .constant(true),
                    isHighlighted: .constant(false),
                    themeStyle: .linkButton) {}
            }
            EmeraldSwiftUIButton(
                buttonName: _buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .witheAndBlueColor) {}
            EmeraldSwiftUIButton(
                buttonName: _buttonName,
                isEnabled: .constant(true),
                isHighlighted: .constant(false),
                themeStyle: .warning) {}
        }
    }
    
    
    @ViewBuilder
    var emeraldTextFieldsNewView: some View {
        VStack {
            EmeraldTextFieldFormNormal(text: $textV2,
                                       hint: "ingresa tu email",
                                       placeholder: "email@mail.com")
                .hasError(errorTextV2 != nil, errorText: errorTextV2)
                .disabled(false)
                .onReceive(textV2.publisher.collect()) {
                    errorTextV2 = isValidEmail(String($0)) || String($0).isEmpty ?
                    nil :
                    "email invalido"
                }
            Spacer()
            EmeraldTextFieldFormDate(text: $textV3,
                                     hint: "ingresa la fecha",
                                     placeholder: "12/12/2022",
                                     keyboardType: .numberPad)
                .hasError(errorTextV3 != nil, errorText: errorTextV3)
                .disabled(false)
            Spacer()
            EmeraldTextFieldFormPicker(hint: "Selecciona una categoria",
                                       placeholder: "este es mi placholder",
                                       data: $pickerData,
                                       lastSelectedIndex: $itemPickerSelected)
                .hasError(errorTextV4 != nil, errorText: errorTextV4)
                .disabled(false)
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
                        label: "Normal",
                        maxLength: 10,
                        clearable: true)
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
                        label:"This is an extremely long placeholder...This is an extremely long placeholder...This is an extremely",
                        placeholder: "This is an extremely long placeholder...This is an extremely long placeholder...This is an extremely",
                        helperText: "This is an extremely long description...This is an extremely long description...This is an extremely long description...This is an extremely long description...This is an extremely long description...",
                        useLegacy: false).padding(20)
                    EmeraldSwiftUiTextView(
                        text: $textView,
                        label:"232131312312312312312312312312312323432432423442p4234324m3423423432423423j2",
                        placeholder: "232131312312312312312312312312312323432432423442p4234324m3423423432423423j2",
                        helperText: "420i2423i0423i04i0234i0240i2340i4i02340i23i04230i423i04i2034i02340i2423i04i0234i0234i0234i0234i0234i",
                        useLegacy: false).padding(20)
                    Text("V 1.0")
                    EmeraldSwiftUiTextView(
                        text: $textViewtwo,
                        label:"23232323",
                        placeholder: "placeholderfdfofsofsofsodofsosfofsosfosdf",
                        helperText: "232131312312312312312312312312312323432432423442p4234324m3423423432423423j2",
                        useLegacy: false).padding(20)
                    EmeraldSwiftUiTextView(
                        text: $textViewthree,
                        label:"",
                        placeholder: "er094500534503450345",
                        helperText: "this is a helper text",
                        useLegacy: false).padding(20)
                    EmeraldSwiftUiTextView(
                        text: $disabledField,
                        label: "Text View",
                        placeholder: "placeholder",
                        helperText: "this is a helper text",
                        disabled: true,
                        useLegacy: false)
                    Text("V 2.0")
                    EmeraldSwiftUiTextView(
                        text: $textViewNew,
                        label:"This is an  long placeholder...This is an extremely long placeholder...This is an extremely",
                        placeholder: "placeholder",
                        helperText: "this is a helper text",
                        clearable: true)
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
                                         textRadioButton: .constant(data.title),
                                         key: data.id)
                    if  self.selected == data.id && data.requiredExplanation == true {
                        EmeraldSwiftUiTextView(
                            text: $textViewNew,
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
            VStack {
                emeraldTextFieldsNewView
                    .padding()
                Divider()
                emeraldTextFieldsView
                    .padding()
            }
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
