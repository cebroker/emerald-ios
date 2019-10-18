//
//  EmeraldDateFieldError.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/14/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

enum EmeraldDateFieldError: FormFieldErrorType, Error {
    case lowerThanMinimumDate(message: String)
    case greaterThanMaximumDate(message: String)
    case invalidDateFormat(message: String)
}

extension EmeraldDateFieldError {
    public var description: String? {
        switch self {
        case .lowerThanMinimumDate(let message),
             .greaterThanMaximumDate(let message),
             .invalidDateFormat(let message):
            return message
        }
    }
}
