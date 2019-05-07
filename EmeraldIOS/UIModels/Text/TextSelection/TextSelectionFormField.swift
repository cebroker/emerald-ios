////
////  TextSelectionFormField.swift
////  EmeraldIOS
////
////  Created by Luis David Goyes Garces on 2/28/19.
////  Copyright © 2019 Condor Labs. All rights reserved.
////
//
//public protocol TextSelectionFormFieldType: TextFormFieldType {
//    func set(availableOptions: [String])
//    func getAvailableOptions() -> [String]
//}
//
//public class TextSelectionFormField: TextFormField, TextSelectionFormFieldType {
//
//    private var availableOptions: [String] = []
//
//    public func set(availableOptions: [String]) {
//        self.availableOptions = availableOptions
//    }
//
//    public func getAvailableOptions() -> [String] {
//        return self.availableOptions
//    }
//
//    override func validateContent() -> ValidationResult {
//        guard let text = self.getValue(), !text.isEmpty else {
//            return ValidationResult(isValid: false, error: FormFieldError.emptyField)
//        }
//        
//        guard !availableOptions.isEmpty else {
//            return ValidationResult(isValid: false, error: TextSelectionFormFieldError.missingAvailableOptions)
//        }
//
//        guard let _ = self.availableOptions.first(where: { option -> Bool in
//            option.uppercased() == text.uppercased()
//        }) else {
//            return ValidationResult(isValid: false, error: TextSelectionFormFieldError.optionNotFound)
//        }
//
//        return ValidationResult(isValid: true)
//    }
//}
