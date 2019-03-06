//
//  FormField.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public enum FormFieldError: FormFieldErrorType {
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
    let error: FormFieldErrorType?
    init(isValid: Bool, error: FormFieldErrorType? = nil) {
        self.isValid = isValid
        self.error = error
    }
}

public class FormFieldType<ReturnType>: UIView {
    
    var required: Bool = true
    
    var fieldValue: ReturnType?

    func isValid() -> ValidationResult {
        guard required else {
            return ValidationResult(isValid: true)
        }

        return validateContent()
    }

    func validateContent() -> ValidationResult {
        return ValidationResult.init(isValid: false, error: FormFieldError.emptyField)
    }

    func show(error: FormFieldErrorType) {

    }

    func clearError() {

    }

    func getValue() -> ReturnType? {
        return self.fieldValue
    }

    func set(value: ReturnType) {
        self.fieldValue = value
    }

    func set(required: Bool) {
        self.required = required
    }
}
