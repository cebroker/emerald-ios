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

@IBDesignable
public class TextRegexFormField: TextFormField, TextRegexFormFieldProtocol {

    @IBInspectable
    public var regex: String {
        set {
            self.set(regex: regex)
        }
        
        get {
            return self.getRegex()
        }
    }

    private var innerRegex: String = Constants.Regex.any

    public func set(regex: String) {
        self.innerRegex = regex
    }

    public func getRegex() -> String {
        return self.innerRegex
    }

    override func validateContent() -> ValidationResult {
        guard let text = self.getValue(), !text.isEmpty else {
            return ValidationResult(isValid: false, error: FormFieldError.emptyField)
        }

        let regex = NSRegularExpression(self.innerRegex)

        guard regex.matches(text) else {
            return ValidationResult(isValid: false, error: TextRegexFormFieldError.notMatchingRegex)
        }

        return ValidationResult(isValid: true)
    }
}
