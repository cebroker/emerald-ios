//
//  EmeraldMultipleSelectionFieldError.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public enum EmeraldMultipleSelectionFieldError: FormFieldErrorType, Error {
    case missingSelectedValue
}

public extension EmeraldMultipleSelectionFieldError {
    var description: String? {
        switch self {
        case .missingSelectedValue:
            return "Missing selected value."
        }
    }
}
