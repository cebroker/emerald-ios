//
//  RegexTextFieldView.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 4/12/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public class RegexTextFieldView: BaseInputView {

    var emeraldRegexTextField = EmeraldRegexTextField()
    override var textField: EmeraldTextField {
        get {
            return emeraldRegexTextField
        }
        set{
            emeraldRegexTextField = newValue as! EmeraldRegexTextField
        }
    }

    override func setupViews() {
        super.setupViews()
        self.setDelegate(self)
    }
    
    public func set(regex: String) {
        self.set(regex: EmeraldRegexFormatType(rawValue: regex))
    }
    
    public func set(regex: EmeraldRegexFormatType) {
        self.emeraldRegexTextField.set(regex: regex)
      }

    public func getRegex() -> EmeraldRegexFormatType {
        return self.emeraldRegexTextField.getRegex()
    }
}

extension RegexTextFieldView: CustomEmeraldTextFieldDelegate {
    public func didEndEditing(textField: UITextField) {
        self.handleResult(with: self.textField.validateContent())
    }
}
