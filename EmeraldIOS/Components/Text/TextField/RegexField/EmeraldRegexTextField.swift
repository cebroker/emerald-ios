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
    
    override public func isValid() -> Result<Bool, Error> {
        guard getIsRequired() || !self.getValue().isNilOrEmpty else {
            return .success(true)
        }
        return validateContent()
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
}

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        guard let string = self else { return true }
        return string.isEmpty
    }
}
