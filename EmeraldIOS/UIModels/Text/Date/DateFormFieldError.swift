//
//  DateFormFieldError.swift
//  EmeraldIOS
//
//  Created by Luis David Goyes Garces on 3/6/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

enum DateFormFieldError: FormFieldErrorType {
    case lowerThanMinimumDate
    case greaterThanMaximumDate
}

extension DateFormFieldError {
    public var description: String? {
        switch self {
        case .lowerThanMinimumDate:
            return "Picked date is lower than minimum."
        case .greaterThanMaximumDate:
            return "Picked date is greater than maximum."
        }
    }
}
