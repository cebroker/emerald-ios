//
//  EmeraldRegexTextField.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public protocol EmeraldRegexTextFieldType: EmeraldTextFieldType {
    func set(regex: EmeraldRegexFormatType)
    func getRegex() -> EmeraldRegexFormatType
}

@IBDesignable
public class EmeraldRegexTextField: EmeraldTextField, EmeraldRegexTextFieldType {

    @IBInspectable
    public var regex: String {
        set {
            self.set(regex: EmeraldRegexFormatType(rawValue: newValue))
        }
        get {
            return self.getRegex().regex!
        }
    }

    private var innerRegex: EmeraldRegexFormatType = .any

    public func set(regex: EmeraldRegexFormatType) {
        self.innerRegex = regex
    }

    public func getRegex() -> EmeraldRegexFormatType {
        return self.innerRegex
    }

    override func validateContent() -> Result<Bool, Error> {
        guard let text = self.getValue(), !text.isEmpty,
            let validationRegex = innerRegex.regex else {
                return .failure(FormFieldError.emptyField)
        }

        let regex = NSRegularExpression(validationRegex)

        guard regex.matchesString(with: text) else {
            return .failure(EmeraldRegexTextFieldError.notMatchingRegex)
        }

        return .success(true)
    }

    public override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let validationRegex = innerRegex.regex, let text = textField.text else {
            return false
        }
        let textRange = Range(range, in: text)
        let updatedText = text.replacingCharacters(in: textRange!, with: string)
        let regex = NSRegularExpression(validationRegex)
        let value = regex.matchesString(with: updatedText)

        self.setStatus(value ? .valid : .error)

        return super.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
    }
}
