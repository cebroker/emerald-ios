//
//  EmeraldNormalTextView.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 27/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct EmeraldNormalTextView: View {
    
    @Binding public var text: String
    @State public var focused: Bool
    public var label: String
    public var placeholder: String
    public var accessibility: String
    public var helperText: String?
    public var errorText: String?
    public var maxLength: Int?
    public var disabled: Bool
    public var keyboardType: UIKeyboardType
    
    public init(text: Binding<String>,
                focused: State<Bool> = State(initialValue: false),
                label: String = "",
                placeholder: String = "",
                accessibility: String = "",
                helperText: String? = nil,
                errorText: String? = nil,
                maxLength: Int? = nil,
                disabled: Bool = false,
                keyboardType: UIKeyboardType = .default) {
        self._text = text
        self._focused = focused
        self.label = label
        self.placeholder = placeholder
        self.accessibility = accessibility
        self.helperText = helperText
        self.errorText = errorText
        self.maxLength = maxLength
        self.disabled = disabled
        self.keyboardType = keyboardType
    }
    
    @ViewBuilder
    var textView: some View {
        EmeraldGenericTextView(
            text: $text,
            focused: _focused,
            accessibility: accessibility,
            disabled: disabled,
            keyboardType: keyboardType)
            .onReceive(text.publisher.collect()) {
                if maxLength != nil {
                    text = String($0.prefix(maxLength ?? 0))
                }
            }
            .padding(
                .leading,
                Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
            .padding(
                .trailing,
                Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
            .padding(
                .top,
                Constants.EmeraldSwiftUiTextField.topContentSpacing +
                    Constants.EmeraldSwiftUiTextField.topContentSpacing * 0.85)
            .offset(
                x: .zero,
                y: validatePositionText())
            .padding(
                .bottom, Constants.EmeraldSwiftUiTextField.spaceBottomContent)
    }
    
     func validatePositionText() -> CGFloat {
         var position: CGFloat = 0.0
         if label.isEmpty {
             position = -Constants.EmeraldSwiftUiTextField.topContentSpacing
         } else  {
             if !text.isEmpty {
                 position = -(Constants.EmeraldSwiftUiTextField.topContentSpacing - Constants.EmeraldSwiftUiTextField.spaceBetweenContent)
             } else {
                 if focused {
                     position = -(Constants.EmeraldSwiftUiTextField.topContentSpacing - Constants.EmeraldSwiftUiTextField.spaceBetweenContent)
                 } else {
                     position = -Constants.EmeraldSwiftUiTextField.topContentSpacing
                 }
             }
         }
         return position
     }
  
    var errorTextContent: some View {
        HStack(alignment: .top) {
            if errorText != nil || helperText != nil {
                LabelHelperText(
                    disabled: disabled,
                    helperText: helperText,
                    errorText: errorText)
            }
            
            if maxLength != nil {
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
        GeometryReader { geo in
        HStack {
            LabelTextFieldTitle(
                label: label,
                text: text,
                errorText: errorText,
                focused: $focused)
            Spacer()
        }
        .padding(
            .trailing,
            Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
        .padding(
            .leading,
            Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
        .offset(
            x: .zero,
            y: validatePositionLabelField(height: geo.size.height))
        .animation(.spring(
                    response: 0.2,
                    dampingFraction: 1,
                    blendDuration: .zero))
        }
    }
    
    private func validatePositionLabelField(height: CGFloat ) -> CGFloat  {
        var position: CGFloat = 0.0
        if focused || !$text.wrappedValue.isEmpty {
            position = height - 115
        } else {
            position = height - 110
        }
        return position
    }
    
    var labelPlaceholderContent: some View {
        GeometryReader { geo in
         HStack {
            Text(placeholder)
                .font(Typography(
                        size: .h5,
                        weight: .semibold).suFont)
                .foregroundColor(Constants.EmeraldSwiftUiTextField.placeHolderColor.suColor)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .padding(
            .leading,
            Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
        .offset(
            x: .zero,
            y: label.isEmpty ? 10 : 50)
        .animation(.spring(
                    response: 0.2,
                    dampingFraction: 1,
                    blendDuration: .zero))
        }
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            VStack {
               ZStack {
                labelFieldContent
                textView
                if focused, text.isEmpty {
                    labelPlaceholderContent
                }
               }.overlay(RoundedRectangle(cornerRadius: Constants.EmeraldSwiftUiTextField.cornerRadius)
                .stroke(EmeraldSwiftUiTextView.getBorderColor(
                                        errorText: errorText,
                                        focused: focused,
                                        disabled: disabled),
                                    lineWidth: EmeraldSwiftUiTextView.getBorderWidth(focused: focused)))
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
struct EmeraldNormalTextView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            EmeraldNormalTextView(
                text: $name,
                placeholder: "placeholder",
                accessibility: "name",
                keyboardType: .emailAddress)
        }
    }
}
#endif

