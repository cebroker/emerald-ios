//
//  TextSelectionFormFieldError.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 3/6/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public enum TextSelectionFormFieldError: FormFieldErrorType {
    case missingAvailableOptions
    case optionNotFound
}

public extension TextSelectionFormFieldError {
    public var description: String? {
        switch self {
        case .missingAvailableOptions:
            return "No available options to validate with."
        case .optionNotFound:
            return "Text was not found among available options."
        }
    }
}
