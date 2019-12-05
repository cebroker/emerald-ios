//
//  EmeraldTextFieldView.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 4/12/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public class EmeraldTextFieldView: BaseInputView {

    override func setupViews() {
        super.setupViews()
        self.setDelegate(self)
    }

    func getPlaceholder() -> String? {
        return self.textField.placeholder
    }
    
    func set(hint: String?) {
        self.textField.set(hint: hint)
    }
    
    func getHint() -> String? {
        return self.textField.getHint()
    }
    
    func set(maxLength: Int) {
        self.textField.set(maxLength: maxLength)
    }
    
    func getMaxLength() -> Int {
        return self.textField.getMaxLength()
    }
    
    func set(format: TextFormat) {
        self.textField.set(format: format)
    }
    
    func getFormat() -> TextFormat {
        return self.textField.getFormat()
    }
    
    func getUnformattedText() -> String? {
        return self.textField.getUnformattedText()
    }
    
    func set(inputType: UIKeyboardType) {
        self.textField.set(inputType: inputType)
    }
    
    func getInputType() -> UIKeyboardType? {
        return self.textField.getInputType()
    }
    
    func set(id: String?) {
        self.textField.set(id: id)
    }
    
    func getId() -> String? {
        return self.textField.getId()
    }
    
    func set(isRequired: Bool) {
        self.textField.set(isRequired: isRequired)
    }
    
    func getIsRequired() -> Bool {
        return self.textField.getIsRequired()
    }
    
    func isValid() -> Result<Bool, Error> {
        return self.textField.isValid()
    }
    
    func show(error: FormFieldErrorType){
        self.textField.show(error: error)
    }
    
    func clearError() {
        self.textField.clearError()
    }
    
    func setText(with value: String?) {
        self.textField.setText(with: value)
    }
    
    func clearText() {
        self.textField.clearText()
    }
    
    func isEnable(_ enable: Bool) {
        self.textField.isEnable(enable)
    }
}

extension EmeraldTextFieldView: CustomEmeraldTextFieldDelegate {
    public func didEndEditing(textField: UITextField) {
        self.handleResult(with: self.textField.validateContent())
    }
}
