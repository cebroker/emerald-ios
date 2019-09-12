//
//  EmeraldTextDependantField.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/14/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol EmeraldTextDependantFieldType: EmeraldTextFieldType {
    func set(availableOptions: [String])
    func set(shouldValidateWithOptions: Bool)
    func getAvailableOptions() -> [String]
}

public class EmeraldTextDependantField: EmeraldTextField, EmeraldTextDependantFieldType {
    
    private lazy var availableOptions: [String] = []
    private var shouldValidateWithOptions: Bool = false
    
    public func set(availableOptions: [String]) {
        self.availableOptions = availableOptions
    }
    
    public func getAvailableOptions() -> [String] {
        return availableOptions
    }
    
    public func set(shouldValidateWithOptions: Bool) {
        self.shouldValidateWithOptions = shouldValidateWithOptions
    }
    
    override func validateContent() -> Result<Bool, Error> {
        guard let text = self.getValue()?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else {
            return .failure(FormFieldError.emptyField)
        }
        
        guard !availableOptions.isEmpty else {
            return .failure(EmeraldTextDependantFieldError.missingAvailableOptions)
        }
        
        if shouldValidateWithOptions {
            guard let _ = self.availableOptions.first(where: { option -> Bool in
                option.uppercased() == text.uppercased()
            }) else {
                return .failure(EmeraldTextDependantFieldError.optionNotFound)
            }
        }
        
        return .success(true)
    }
}
