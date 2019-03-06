//
//  TextRegexFormField.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public protocol TextRegexFormFieldProtocol: TextFormFieldType {
    func set(regex: String)
    func getRegex() -> String
}

public class TextRegexFormField: TextFormField, TextRegexFormFieldProtocol {

    private var regex: String = Constants.Regex.any

    public func set(regex: String) {
        self.regex = regex
    }

    public func getRegex() -> String {
        return self.regex
    }

    override func validateContent() -> ValidationResult {
        guard let text = self.getValue(), !text.isEmpty else {
            return ValidationResult(isValid: false, error: FormFieldError.emptyField)
        }

        let regex = NSRegularExpression(self.regex)

        guard regex.matches(text) else {
            return ValidationResult(isValid: false, error: TextRegexFormFieldError.notMatchingRegex)
        }

        return ValidationResult(isValid: true)
    }
}
