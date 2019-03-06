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
}

public class TextRegexFormField: TextFormField, TextRegexFormFieldProtocol {
    
    private var regex: String?
    
    public func set(regex: String) {
        self.regex = regex
    }
    
    override func validateContent() -> ValidationResult {
        guard let text = self.getValue(), !text.isEmpty else {
            return ValidationResult(isValid: false, error: FormFieldError.emptyField)
        }
        
        guard let regexString = self.regex else {
            return ValidationResult(isValid: false, error: TextRegexFormFieldError.missingRegex)
        }
        
        let regex = NSRegularExpression(regexString)
        
        guard regex.matches(text) else {
            return ValidationResult(isValid: false, error: TextRegexFormFieldError.notMatchingRegex)
        }
        
        return ValidationResult(isValid: true)
    }
}

public enum TextRegexFormFieldError: FormFieldErrorType {
    case missingRegex
    case notMatchingRegex
}

extension TextRegexFormFieldError {
    public var description: String? {
        switch self {
        case .missingRegex:
            return "Missing regex."
        case .notMatchingRegex:
            return "Regex does not match."
        }
    }
}
