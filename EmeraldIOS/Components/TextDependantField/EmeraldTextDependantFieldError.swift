//
//  EmeraldTextDependantFieldError.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/14/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public enum EmeraldTextDependantFieldError: FormFieldErrorType, Error {
    case missingAvailableOptions
    case optionNotFound
}

public extension EmeraldTextDependantFieldError {
    var description: String? {
        switch self {
        case .missingAvailableOptions:
            return "No available options to validate with."
        case .optionNotFound:
            return "Text was not found among available options."
        }
    }
}
