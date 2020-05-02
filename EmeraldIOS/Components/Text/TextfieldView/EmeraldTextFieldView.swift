//
//  EmeraldTextFieldView.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 4/12/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public class EmeraldTextFieldView: BaseInputView {

    public var status: EmeraldTextField.EmeraldTextFieldState {
        return self.textField.status
    }

    public var text: String? {
        set {
            self.textField.text = newValue
        }
        get {
            return self.textField.text
        }
    }

    public func setDelegate(_ delegate: CustomEmeraldTextFieldDelegate) {
        self.textField.setCustomDelegate(with: delegate)
    }

    public func set(placeholder: String) {
        self.textField.prepareForInterfaceBuilder()
        textField.set(placeholder: placeholder)
    }

    public func getPlaceholder() -> String? {
        return self.textField.placeholder
    }

    public func set(hint: String?) {
        self.textField.set(hint: hint)
    }

    public func getHint() -> String? {
        return self.textField.getHint()
    }

    public func set(maxLength: Int) {
        self.textField.set(maxLength: maxLength)
    }

    public func getMaxLength() -> Int {
        return self.textField.getMaxLength()
    }

    public func set(format: TextFormat) {
        self.textField.set(format: format)
    }

    public func getFormat() -> TextFormat {
        return self.textField.getFormat()
    }

    public func getUnformattedText() -> String? {
        return self.textField.getUnformattedText()
    }

    public func set(inputType: UIKeyboardType) {
        self.textField.set(inputType: inputType)
    }

    public func getInputType() -> UIKeyboardType? {
        return self.textField.getInputType()
    }

    public func set(id: String?) {
        self.textField.set(id: id)
    }

    public func getId() -> String? {
        return self.textField.getId()
    }

    public func set(isRequired: Bool) {
        self.textField.set(isRequired: isRequired)
    }

    public func isValid() -> Result<Bool, Error> {
        return self.textField.isValid()
    }

    public func show(error: FormFieldErrorType) {
        self.textField.show(error: error)
    }

    public func clearError() {
        self.textField.clearError()
    }

    public func setText(with value: String?) {
        self.textField.setText(with: value)
    }

    public func clearText() {
        self.textField.clearText()
    }

    public func isEnable(_ enable: Bool) {
        self.textField.isEnable(enable)
    }

    public func getValue() -> String? {
        return self.textField.getValue()
    }

    public func setStatus(_ status: EmeraldTextField.EmeraldTextFieldState) {
        self.textField.setStatus(status)
    }
}
