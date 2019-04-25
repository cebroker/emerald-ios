//
//  SelectorFormFieldError.swift
//  EmeraldIOS
//
//  Created by Luis David Goyes Garces on 3/6/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public enum SelectorFormFieldError: FormFieldErrorType {
    case missingSelectedValue
    case uiSelectedValueMismatch
}

public extension SelectorFormFieldError {
    public var description: String? {
        switch self {
        case .missingSelectedValue:
            return "Missing selected value."
        case .uiSelectedValueMismatch:
            return "Tthe text showed in UI does not match any selectable."
        }
    }
}
