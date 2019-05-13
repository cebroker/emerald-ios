//
//  FormField.swift
//  EmeraldIOS
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

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

public class ValidationResult {
    public let isValid: Bool
    public let error: FormFieldErrorType?
    public init(isValid: Bool, error: FormFieldErrorType? = nil) {
        self.isValid = isValid
        self.error = error
    }
}

@IBDesignable
public class FormFieldType<ReturnType>: UIView {

    var required: Bool = true

    var fieldValue: ReturnType?

    var id: String?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.postInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.postInit()
    }

    public init() {
        super.init(frame: CGRect.zero)
        self.postInit()
    }

    func set(id: String) {
        self.id = id
    }

    func getId() -> String? {
        return self.id
    }

    func postInit() {
        // Method intentionally left in blank
    }

    public func isValid() -> ValidationResult {
        guard required else {
            return ValidationResult(isValid: true)
        }

        return validateContent()
    }

    func validateContent() -> ValidationResult {
        return ValidationResult.init(isValid: false, error: FormFieldError.emptyField)
    }

    public func show(error: FormFieldErrorType) {
        // Method intentionally left in blank
    }

    public func clearError() {
        // Method intentionally left in blank
    }

    public func getValue() -> ReturnType? {
        return self.fieldValue
    }

    public func set(value: ReturnType) {
        self.fieldValue = value
    }

    public func set(required: Bool) {
        self.required = required
    }
}
