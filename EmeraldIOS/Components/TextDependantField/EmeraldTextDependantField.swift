//
//  EmeraldTextDependantField.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/14/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol EmeraldTextDependantFieldType: EmeraldTextFieldType {
    func set(availableOptions: [String])
    func getAvailableOptions() -> [String]
}

public class EmeraldTextDependantField: EmeraldTextField, EmeraldTextDependantFieldType {
    
    private lazy var availableOptions: [String] = []
    
    public func set(availableOptions: [String]) {
        self.availableOptions = availableOptions
    }
    
    public func getAvailableOptions() -> [String] {
        return availableOptions
    }
    
    override func validateContent() -> Result<Bool, Error> {
        guard let text = self.getValue(), !text.isEmpty else {
            return .failure(FormFieldError.emptyField)
        }
        
        guard !availableOptions.isEmpty else {
            return .failure(EmeraldTextDependantFieldError.missingAvailableOptions)
        }
        
        guard let _ = self.availableOptions.first(where: { option -> Bool in
            option.uppercased() == text.uppercased()
        }) else {
            return .failure(EmeraldTextDependantFieldError.optionNotFound)
        }
        
        return .success(true)
    }
}
