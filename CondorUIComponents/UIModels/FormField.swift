//
//  FormField.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol FormFieldErrorProtocol {
    
    var description: String? { get }
}

public enum FormFieldError: FormFieldErrorProtocol {
    case emptyField
}

public extension FormFieldError {
    public var description: String? {
        switch self {
        case .emptyField:
            return "This field can not be empty."
        }
    }
}

public class ValidationResult {
    let isValid: Bool
    let error: FormFieldErrorProtocol?
    init(isValid: Bool, error: FormFieldErrorProtocol? = nil) {
        self.isValid = isValid
        self.error = error
    }
}

public protocol FormFieldProtocol {
    var isRequired: Bool { get set }
    
    func isValid() -> ValidationResult
    func show(error: FormFieldErrorProtocol)
    func clearError()
    mutating func set(isRequired: Bool)
}

extension FormFieldProtocol {
    mutating public func set(isRequired: Bool ){
        self.isRequired = isRequired
    }
}
