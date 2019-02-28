//
//  CheckboxFormFieldTests.swift
//  CondorUIComponentsTests
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import XCTest

@testable import CondorUIComponents

class CheckboxFormFieldTests: XCTestCase {
    
    private struct InnerConstants {
        struct Strings {
        }
        
        struct Settings {
            static let mockFrame = Constants.MockedData.mockFrame
        }
        
        struct Values {
            static let successful1 = Constants.MockedData.educationTypes[0]
            static let successful2 = Constants.MockedData.educationTypes[1]
        }
    }
    
    var checkboxField: FormFieldProtocol?
    
    override func setUp() {
        checkboxField = CheckboxFormField(frame: InnerConstants.Settings.mockFrame)
    }
    
    override func tearDown() {
        checkboxField = nil
    }
    
    func testShouldPassValidation() {
        guard let checkboxField = self.checkboxField as? CheckboxFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        checkboxField.set(data: Constants.MockedData.educationTypes)
        
        guard let testableCheckboxField = self.checkboxField as? TestableCheckboxFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        testableCheckboxField.select(option: InnerConstants.Values.successful1, status: true)
        testableCheckboxField.select(option: InnerConstants.Values.successful2, status: true)
        
        let validationResult = checkboxField.isValid()
        
        guard validationResult.isValid else {
            XCTFail(Constants.TestsErrors.validationFailed.localizedDescription)
            return
        }
    }
    
    func testShouldNotPassValidationEmpty() {
        guard let checkboxField = self.checkboxField as? CheckboxFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        checkboxField.set(data: Constants.MockedData.educationTypes)
        
        let validationResult = checkboxField.isValid()
        
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
