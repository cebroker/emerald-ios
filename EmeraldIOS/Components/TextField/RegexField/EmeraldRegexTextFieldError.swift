//
//  EmeraldRegexTextFieldError.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public enum EmeraldRegexTextFieldError: FormFieldErrorType, Error {
    case missingRegex
    case notMatchingRegex
}

extension EmeraldRegexTextFieldError {
    public var description: String? {
        switch self {
        case .missingRegex:
            return "Missing regex."
        case .notMatchingRegex:
            return "Invalid format."
        }
    }
}
