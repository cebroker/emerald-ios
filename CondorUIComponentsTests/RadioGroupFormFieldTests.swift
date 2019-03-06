//
//  RadioGroupFormFieldTests.swift
//  CondorUIComponentsTests
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import XCTest

@testable import CondorUIComponents

class RadioGroupFormFieldTests: XCTestCase {
    
    private struct InnerConstants {
        struct Strings {
        }
        
        struct Settings {
            static let mockFrame = Constants.MockedData.mockFrame
        }
        
        struct Values {
            static let successful = Constants.MockedData.educationTypes[0]
        }
    }
    
    var radioGroupField: RadioGroupFormField?
    
    override func setUp() {
        radioGroupField = RadioGroupFormField(frame: InnerConstants.Settings.mockFrame)
    }
    
    override func tearDown() {
        radioGroupField = nil
    }
    
    func testShouldPassValidation() {
        guard let radioGroupField = self.radioGroupField as? RadioGroupFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        radioGroupField.set(data: Constants.MockedData.educationTypes)
        
        guard let testableRadioGroupField = self.radioGroupField as? TestableRadioGroupFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        testableRadioGroupField.select(option: InnerConstants.Values.successful)
        
        let validationResult = radioGroupField.isValid()
        
        guard validationResult.isValid else {
            XCTFail(Constants.TestsErrors.validationFailed.localizedDescription)
            return
        }
        
        
    }
    
    func testShouldNotPassValidationEmpty() {
        guard let radioGroupField = self.radioGroupField as? RadioGroupFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        radioGroupField.set(data: Constants.MockedData.educationTypes)
        
        let validationResult = radioGroupField.isValid()
        
        guard !validationResult.isValid else {
            XCTFail(Constants.TestsErrors.validationFailed.localizedDescription)
            return
        }
        
        guard let errorDescription = validationResult.error?.description else {
            XCTFail(Constants.TestsErrors.unexpectedError.localizedDescription)
            return
        }
        
        guard errorDescription == FormFieldError.emptyField.description else {
            XCTFail(errorDescription)
            return
        }
    }
}
