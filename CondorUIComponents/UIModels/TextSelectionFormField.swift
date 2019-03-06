//
//  TextSelectionFormField.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public class AddressState: Selectable {
    let name: String
    let id: Int
    let cities: [String]
    public init(
        name: String,
        id: Int,
        cities: [String]) {
        self.name = name
        self.id = id
        self.cities = cities
    }
    
    public func getSelectableText() -> String {
        return name
    }
}

protocol TextSelectionFormFieldProtocol: TextFormFieldProtocol {
    func set(availableOptions: [String])
    func getAvailableOptions() -> [String]?
}

class TextSelectionFormField: TextFormField, TextSelectionFormFieldProtocol {
    
    private var availableOptions: [String]?
    
    func set(availableOptions: [String]) {
        self.availableOptions = availableOptions
    }
    
    func getAvailableOptions() -> [String]? {
        return self.availableOptions
    }
    
    override func validateContent() -> ValidationResult {
        guard let text = self.getValue(), !text.isEmpty else {
            return ValidationResult(isValid: false, error: FormFieldError.emptyField)
        }
        
        guard let availableOptions = self.availableOptions else {
            return ValidationResult(isValid: false, error: TextSelectionFormFieldError.missingAvailableOptions)
        }
        
        guard let _ = availableOptions.first(where: { option -> Bool in
            option == text.uppercased()
        }) else {
            return ValidationResult(isValid: false, error: TextSelectionFormFieldError.optionNotFound)
        }
        
        return ValidationResult(isValid: true)
    }
}

enum TextSelectionFormFieldError: FormFieldErrorProtocol {
    case missingAvailableOptions
    case optionNotFound
}

extension TextSelectionFormFieldError {
    public var description: String? {
        switch self {
        case .missingAvailableOptions:
            return "No available options to validate with."
        case .optionNotFound:
            return "Text was not found among available options."
        }
    }
}
