//
//  EmeraldSwiftUIPhoneTextField.swift
//  EmeraldIOS
//
//  Created by Cristopher Escorcia on 19/09/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI
import Combine

@available(iOS 13.0.0, *)
public struct EmeraldSwiftUIPhoneTextField: View {
    @Binding private var text: String
    @State private var focused: Bool
    private var label: String
    private var placeholder: String
    private var accessibility: String
    private var errorText: String?
    private var maxLength: Int?
    private var disabled: Bool
    private var keyboardType: UIKeyboardType
    
    public init(
        text: Binding<String>,
        focused: State<Bool> = State(initialValue: false),
        label: String = "",
        placeholder: String = "",
        accessibility: String = "",
        errorText: String? = nil,
        maxLength: Int? = nil,
        disabled: Bool = false,
        keyboardType: UIKeyboardType = .decimalPad) {
        self._text = text
        self._focused = focused
        self.label = label
        self.placeholder = placeholder
        self.accessibility = accessibility
        self.errorText = errorText
        self.maxLength = maxLength
        self.disabled = disabled
        self.keyboardType = keyboardType
    }
    
    var textField: some View {
        EmeraldGenericTextField(
            text: $text,
            focused: _focused,
            placeholder: focused ?
                placeholder :
                "",
            accessibility: accessibility,
            errorText: errorText,
            disabled: disabled,
            keyboardType: keyboardType)
            .onReceive(Just(text)) {
                text = formatPhone($0)
            }
            .padding(
                .leading,
                Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
            .padding(
                .trailing,
                Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
            .padding(
                .top, focused || !text.isEmpty ?
                    Constants.EmeraldSwiftUiTextField.heightLabel * 0.7 :
                    .zero)
            .overlay(RoundedRectangle(cornerRadius: Constants.EmeraldSwiftUiTextField.cornerRadius)
                        .stroke(EmeraldSwiftUiTextField.getBorderColor(
                                    errorText: errorText,
                                    focused: focused,
                                    disabled: disabled),
                                lineWidth: EmeraldSwiftUiTextField.getBorderWidth(focused: focused)))
    }
    
    var errorTextContent: some View {
        HStack(alignment: .top) {
            if errorText != nil, !(errorText?.isEmpty ?? true) {
                LabelHelperText(
                    helperText: nil,
                    errorText: errorText)
            }
        }
        .padding(
            .leading,
            Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
    }
    
    var labelFieldContent: some View {
        HStack {
            LabelTextFieldTitle(
                label: label,
                text: text,
                errorText: errorText,
                focused: $focused)
            Spacer()
        }
        .frame(height: Constants.EmeraldSwiftUiTextField.heightLabel)
        .padding(
            .trailing,
            Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
        .padding(
            .leading,
            Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
        .offset(
            x: .zero,
            y: focused ?
                -Constants.EmeraldSwiftUiTextField.heightLabel :
                text.isEmpty ?
                .zero :
                -Constants.EmeraldSwiftUiTextField.topContentSpacing)
        .animation(.spring(
                    response: 0.2,
                    dampingFraction: 1,
                    blendDuration: .zero))
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                textField
                labelFieldContent
                    .onTapGesture {
                        if !disabled {
                            self.focused = true
                        }
                    }
            }
            errorTextContent
        }
        .padding(
            .leading,
            Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
        .padding(
            .trailing,
            Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
        .padding(
            .bottom,
            Constants.EmeraldSwiftUiTextField.bottomContentPadding)
        .fixedSize(
            horizontal: false,
            vertical: true)
    }
    
    func formatPhone(_ phone: String) -> String {
        let mask = Constants.TextFormating.phoneFormat
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for ch in mask where index < numbers.endIndex {
            if ch == Constants.Values.x {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

#if DEBUG
@available(iOS 13.0.0, *)
struct EmeraldPhoneTextField_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            EmeraldSwiftUIPhoneTextField(
                text: $name,
                label: "name asda s sada s asda name asda s sada s asda name asda s sada s asda ",
                placeholder: "placeholder",
                keyboardType: .default)
        }
    }
}
#endif
