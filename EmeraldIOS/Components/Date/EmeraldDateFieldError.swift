//
//  EmeraldDateFieldError.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/14/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

enum EmeraldDateFieldError: FormFieldErrorType, Error {
    case lowerThanMinimumDate
    case greaterThanMaximumDate
    case invalidDateFormat
}

extension EmeraldDateFieldError {
    public var description: String? {
        switch self {
        case .lowerThanMinimumDate:
            return "Picked date is lower than minimum."
        case .greaterThanMaximumDate:
            return "Picked date is greater than maximum."
        case .invalidDateFormat:
            return "Invalid date format"
        }
    }
}
