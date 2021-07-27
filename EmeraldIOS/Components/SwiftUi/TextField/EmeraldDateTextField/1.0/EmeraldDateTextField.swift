//
//  EmeraldDateTextField.swift
//  Components
//
//  Created by Ronal Fabra on 26/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct EmeraldDateTextField: View, TextFormatter {
    
    @Binding var text: String
    @State(initialValue: false) var focused: Bool
    var label: String = ""
    var placeholder: String = ""
    var accessibility: String = ""
    var errorText: String? = nil
    var maxLength: Int? = nil
    var disabled: Bool = false
    var textFormat: TextFormat = .shortDate
    var keyboardType: UIKeyboardType = .default
    
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
            .onReceive(text.publisher.collect()) {
                formatText(String($0))
            }
            .padding(
                .leading,
                Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
            .padding(
                .trailing,
                Constants.EmeraldSwiftUiTextField.trailingContentSpacing +
                Constants.EmeraldSwiftUiTextField.widthIcon)
            .padding(
                .top, focused || !text.isEmpty ?
                    Constants.EmeraldSwiftUiTextField.heightLabel * 0.7 :
                    .zero)
            .overlay(RoundedRectangle(cornerRadius: Constants.EmeraldSwiftUiTextField.cornerRadius)
                        .stroke((errorText != nil ?
                                    Constants.EmeraldSwiftUiTextField.errorColor :
                                    (focused ?
                                        Constants.EmeraldSwiftUiTextField.focusColor :
                                        (disabled ?
                                        Constants.EmeraldSwiftUiTextField.placeHolderColor.opacity(0.5) :
                                        Constants.EmeraldSwiftUiTextField.placeHolderColor))),
                                lineWidth: self.focused ?
                                    Constants.EmeraldSwiftUiTextField.borderWidthFocused :
                                    Constants.EmeraldSwiftUiTextField.borderWidth))
    }
    
    @ViewBuilder
    var iconDateContent: some View {
        let calendarIcon = UIImage(
            named: Constants.Icons.calendar,
            in: Bundle(for: ClassBundle.self),
            compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        if calendarIcon != nil {
            Button(action: {}) {
                Image(uiImage: calendarIcon ?? UIImage(systemName: "calendar")!)
                    .resizable()
                    .foregroundColor(
                        disabled ?
                            Constants.EmeraldSwiftUiTextField.disabledColor :
                            Constants.EmeraldSwiftUiTextField.textColor)
            }
            .frame(
                width: Constants.EmeraldSwiftUiTextField.widthIcon,
                height: Constants.EmeraldSwiftUiTextField.widthIcon)
        }
    }
    
    var errorTextContent: some View {
        HStack(alignment: .top) {
            if errorText != nil {
                LabelHelperText(
                    disabled: disabled,
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
            .leading,
            Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
        .padding(
            .trailing,
            Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
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
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                textField
                labelFieldContent
                    .onTapGesture {
                        if !disabled {
                            self.focused = true
                        }
                    }
                HStack {
                    Spacer()
                    iconDateContent
                }
                .frame(alignment: .trailing)
                .padding(
                    .trailing,
                    Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
            }
            errorTextContent
        }
        .fixedSize(
            horizontal: false,
            vertical: true)
        .padding(
            .horizontal,
            Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
        .padding(
            .bottom,
            Constants.EmeraldSwiftUiTextField.bottomContentPadding)
    }
    
    func formatText(_ text:String) {
        let maxCharacter = maxLength != nil ?
            maxLength! :
            (textFormat == .shortDate ?
                Constants.EmeraldSwiftUiTextField.maximumShortDateLength :
                Constants.EmeraldSwiftUiTextField.maximumDateLength)
        let str = String(text.prefix(maxCharacter))
        if text.count > maxCharacter {
            self.text = str
        } else {
            do {
                let textWithoutFormat = try self.remove(format: self.textFormat, to: str)
                let newText = try self.apply(format: self.textFormat, to: textWithoutFormat)
                
                DispatchQueue.main.async {
                    self.text = newText
                }
                
            } catch (let error) {
                print(error)
            }
        }
    }
}

@available(iOS 13.0.0, *)
struct EmeraldDateTextField_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            EmeraldDateTextField(
                text: $name,
                label: "name asda s sada s asda sdasda s d sdas dasds as dfs dfs df",
                placeholder: "placeholder",
                keyboardType: .default)
        }
    }
}
