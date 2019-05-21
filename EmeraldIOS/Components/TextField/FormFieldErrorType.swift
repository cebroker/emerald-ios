//
//  FormFieldErrorType.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol FormFieldErrorType {
    var description: String? { get }
}

public enum FormFieldError: FormFieldErrorType, Error {
    case emptyField
}

public extension FormFieldError {
    var description: String? {
        switch self {
        case .emptyField:
            return "This field can not be empty."
        }
    }
}
