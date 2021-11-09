//
//  EmeraldDateTextFieldNew.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 26/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct EmeraldDateTextFieldNew: View, TextFormatter {
    
    @Binding var text: String
    @State(initialValue: false) var focused: Bool
    var label: String = ""
    var placeholder: String = ""
    var accessibility: String = ""
    var helperText: String? = nil
    var errorText: String? = nil
    var maxLength: Int? = nil
    var hideCounter: Bool = false
    var clearable: Bool = true
    var disabled: Bool = false
    var textFormat: TextFormat = .shortDate
    var keyboardType: UIKeyboardType = .default
    
    var textField: some View {
        EmeraldGenericTextField(
            text: $text,
            focused: _focused,
            placeholder: placeholder,
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
                .trailing, (clearable ?
                                Constants.EmeraldSwiftUiTextField.trailingContentSpacing * 3 +
                                Constants.EmeraldSwiftUiTextField.widthIcon +
                                Constants.EmeraldSwiftUiTextField.widthClearButton :
                                Constants.EmeraldSwiftUiTextField.trailingContentSpacing +
                                Constants.EmeraldSwiftUiTextField.widthIcon))
            .overlay(RoundedRectangle(cornerRadius: Constants.EmeraldSwiftUiTextField.cornerRadius)
                        .stroke(EmeraldSwiftUiTextField.getBorderColor(
                                    errorText: errorText,
                                    focused: focused,
                                    disabled: disabled),
                                lineWidth: EmeraldSwiftUiTextField.getBorderWidth(focused: focused)))
    }
    
    @ViewBuilder
    var iconDateContent: some View {
        let calendarIcon = UIImage(
            named: Constants.Icons.calendar,
            in: Bundle(for: ClassBundle.self),
            compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        if calendarIcon != nil {
            Button(action: {}) {
                Image(uiImage: calendarIcon ?? UIImage(systemName: Constants.Icons.systemCalendar)!)
                    .resizable()
                    .foregroundColor(
                        disabled ?
                            Constants.EmeraldSwiftUiTextField.disabledColor.suColor :
                            Constants.EmeraldSwiftUiTextField.textColor.suColor)
            }
            .frame(
                width: Constants.EmeraldSwiftUiTextField.widthIcon,
                height: Constants.EmeraldSwiftUiTextField.widthIcon)
        }
    }
    
    var helperTextContent: some View {
        HStack(alignment: .top) {
            if errorText != nil || helperText != nil {
                LabelHelperText(
                    disabled: disabled,
                    helperText: helperText,
                    errorText: errorText)
            }
            if maxLength != nil, !hideCounter {
                Spacer()
                LabelTextFieldCounter(
                    text: $text,
                    disabled: disabled,
                    maxLength: maxLength)
            }
        }
        .padding(
            .leading,
            Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
    }
    
    var labelFieldContent: some View {
        HStack(alignment: .top) {
            LabelTextFieldTitleNew(
                label: label,
                disabled: disabled,
                errorText: errorText,
                focused: $focused)
                .padding(
                    .trailing,
                    Constants.EmeraldSwiftUiTextField.horizontalLabelSpacing)
            Spacer()
        }
        .frame(height: Constants.EmeraldSwiftUiTextField.heightLabel)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                ZStack {
                    textField
                    HStack(spacing: Constants.EmeraldSwiftUiTextField.trailingContentSpacing) {
                        Spacer()
                        if clearable, !text.isEmpty {
                            ClearButton {
                                text = ""
                            }
                        }
                        iconDateContent
                    }
                    .frame(alignment: .trailing)
                    .padding(.trailing,
                             Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
                }
                helperTextContent
            }
            .offset(
                x: .zero,
                y: Constants.EmeraldSwiftUiTextField.heightLabel * 0.5)
            labelFieldContent
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
        var maxCharacter = maxLength != nil ?
            maxLength! :
            Constants.EmeraldSwiftUiTextField.maximumShortDateLength
        maxCharacter = textFormat == .shortDate ?
            maxCharacter :
            Constants.EmeraldSwiftUiTextField.maximumDateLength
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

#if DEBUG
@available(iOS 13.0.0, *)
struct EmeraldDateTextFieldNew_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            EmeraldDateTextFieldNew(
                text: $name,
                label: "name asda s sada s asda sdasda s d sdas dasds as dfs dfs df",
                placeholder: "placeholder",
                helperText: "this field is for help you",
                clearable: true,
                keyboardType: .default)
        }
    }
}
#endif
