//
//  EmeraldNormalTextField.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 26/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct EmeraldNormalTextField: View {
    
    @Binding var text: String
    @State(initialValue: false) var focused: Bool
    var label: String = ""
    var placeholder: String = ""
    var accessibility: String = ""
    var errorText: String? = nil
    var maxLength: Int? = nil
    var disabled: Bool = false
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
                if maxLength != nil {
                    text = String($0.prefix(maxLength ?? .zero))
                }
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
}

#if DEBUG
@available(iOS 13.0.0, *)
struct EmeraldNormalTextField_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            EmeraldNormalTextField(
                text: $name,
                label: "name asda s sada s asda name asda s sada s asda name asda s sada s asda ",
                placeholder: "placeholder",
                keyboardType: .default)
        }
    }
}
#endif
