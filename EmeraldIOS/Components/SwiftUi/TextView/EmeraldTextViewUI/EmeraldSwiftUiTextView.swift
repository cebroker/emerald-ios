//
//  EmeraldSwiftUiTextView.swift
//  Components
//
//  Created by Ronal Fabra on 21/07/21.
//

import SwiftUI
import Introspect

@available(iOS 13.0.0, *)
public struct EmeraldSwiftUiTextView: View {
    
    @Binding public var text: String
    @State public var focused: Bool
    public var label: String = ""
    public var placeholder: String = ""
    public var accessibility: String = ""
    public var helperText: String? = nil
    public var errorText: String? = nil
    public var maxLength: Int? = nil
    public var hideCounter: Bool = false
    public var clearable: Bool = false
    public var disabled: Bool = false
    public var textFieldType: TextFieldType = .normal
    
    public init(text: Binding<String>,
                focused: State<Bool> = State(initialValue: false),
                label: String = "",
                placeholder: String = "",
                accessibility: String = "",
                helperText: String? = nil,
                errorText: String? = nil,
                maxLength: Int? = nil,
                hideCounter: Bool = false,
                clearable: Bool = false,
                disabled: Bool = false,
                textFieldType: TextFieldType = .normal) {
        self._text = text
        self._focused = focused
        self.label = label
        self.placeholder = placeholder
        self.accessibility = accessibility
        self.helperText = helperText
        self.errorText = errorText
        self.maxLength = maxLength
        self.hideCounter = hideCounter
        self.clearable = clearable
        self.disabled = disabled
        self.textFieldType = textFieldType
    }
    
    var textView: some View {
        TextViewSwiftUi(
            text: $text,
            disabled: disabled,
            placeHolder: placeholder) {
            self.focused = $0
        }
        .onReceive(text.publisher.collect()) {
            if maxLength != nil {
                text = String($0.prefix(maxLength ?? 0))
            }
        }
        .keyboardType(textFieldType.getKeyboardType())
        .accessibility(identifier: accessibility)
        .font(Typography(
                size: .h3,
                weight: .semibold).suFont)
        .foregroundColor(Constants.EmeraldSwiftUiTextField.textColor)
        .padding(
            .leading,
            Constants.EmeraldSwiftUiTextField.leadingContentSpacing)
        .padding(
            .trailing, (
                clearable ?
                    Constants.EmeraldSwiftUiTextField.trailingContentSpacing +
                    (Constants.EmeraldSwiftUiTextField.widthClearButton * 2.5) :
                    Constants.EmeraldSwiftUiTextField.trailingContentSpacing))
        .padding(
            .top,
            Constants.EmeraldSwiftUiTextField.topContentSpacing)
        .padding(
            .bottom,
            Constants.EmeraldSwiftUiTextField.bottomContentSpacing)
        .frame(height: Constants.EmeraldSwiftUiTextField.textAreaHeight)
        .overlay(RoundedRectangle(cornerRadius: Constants.EmeraldSwiftUiTextField.cornerRadius)
                    .stroke(
                        (errorText != nil ?
                            Constants.EmeraldSwiftUiTextField.errorColor :
                            (focused ?
                                Constants.EmeraldSwiftUiTextField.focusColor :
                                Constants.EmeraldSwiftUiTextField.borderColor)),
                        lineWidth:
                            self.focused ?
                            Constants.EmeraldSwiftUiTextField.borderWidthFocused :
                            Constants.EmeraldSwiftUiTextField.borderWidth))
        .introspectTextView { textView in
            if focused {
                textView.becomeFirstResponder()
            }
        }
    }
    
    var clearButtonContent: some View {
        ClearButton {
            text = ""
        }
        .padding(
            .trailing,
            Constants.EmeraldSwiftUiTextField.trailingContentSpacing)
        .padding(
            .top,
            Constants.EmeraldSwiftUiTextField.topContentSpacing * 0.7)
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
            LabelTextFieldTitle(
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
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                ZStack {
                    textView
                    if clearable, !text.isEmpty {
                        clearButtonContent
                    }
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
        .background(Color.white)
    }
}

@available(iOS 13.0.0, *)
struct EmeraldSwiftUiTextView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            EmeraldSwiftUiTextView(
                text: $name,
                label: "name asda s sada s asda sdasda s d sdas dasds as dfs dfs df",
                placeholder: "placeholder",
                accessibility: "name",
                helperText: "this field is for help you",
                clearable: true,
                textFieldType: .email)
        }
    }
}
