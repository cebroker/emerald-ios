//
//  TextSelectionFormFieldTests.swift
//  CondorUIComponentsTests
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import XCTest

@testable import CondorUIComponents

class TextSelectionFormFieldTests: XCTestCase {
    
    private struct InnerConstants {
        
        struct Strings {
            static let passValidation = "Medellin"
            static let emptyValidation = ""
            static let cityNotFoundValidation = "Manizales"
        }
        
        struct Settings {
            static let mockedState = Constants.MockedData.states[0]
        }
    }
    
    var cityFormField: FormFieldType<String>?
    
    override func setUp() {
        cityFormField = TextSelectionFormField(frame: Constants.MockedData.mockFrame)
    }
    
    override func tearDown() {
        cityFormField = nil
    }
    
    func testShouldPassValidation() {
        guard let cityFormField = self.cityFormField else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        guard let cityFormFieldDataSetter = self.cityFormField as? TextSelectionFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        cityFormFieldDataSetter.set(availableOptions: InnerConstants.Settings.mockedState.cities)
        cityFormFieldDataSetter.set(text: InnerConstants.Strings.passValidation)
        
        guard cityFormField.isValid().isValid else {
            if let error = cityFormField.isValid().error?.description {
                XCTFail(error.description)
            } else {
                XCTFail(Constants.TestsErrors.validationFailed.localizedDescription)
            }
            return
        }
    }
    
    func testShouldNotPassValidationEmpty() {
        guard let cityFormField = self.cityFormField else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        guard let cityFormFieldDataSetter = self.cityFormField as? TextSelectionFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        cityFormFieldDataSetter.set(availableOptions: InnerConstants.Settings.mockedState.cities)
        cityFormFieldDataSetter.set(text: InnerConstants.Strings.emptyValidation)
        
        let validationResult = cityFormField.isValid()
        
        guard !validationResult.isValid else {
            XCTFail(Constants.TestsErrors.validationSucceded.localizedDescription)
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
    
    func testShouldNotPassValidationMissingState() {
        guard let cityFormField = self.cityFormField else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        guard let cityFormFieldDataSetter = self.cityFormField as? TextSelectionFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        cityFormFieldDataSetter.set(text: InnerConstants.Strings.passValidation)
        
        let validationResult = cityFormField.isValid()
        
        guard !validationResult.isValid else {
            XCTFail(Constants.TestsErrors.validationSucceded.localizedDescription)
            return
        }
        
        guard let errorDescription = validationResult.error?.description else {
            XCTFail(Constants.TestsErrors.unexpectedError.localizedDescription)
            return
        }
        
        guard errorDescription == TextSelectionFormFieldError.missingAvailableOptions.description else {
            XCTFail(errorDescription)
            return
        }
    }
    
    func testShouldNotPassValidationCityNotFound() {
        guard let cityFormField = self.cityFormField else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        guard let cityFormFieldDataSetter = self.cityFormField as? TextSelectionFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        cityFormFieldDataSetter.set(availableOptions: InnerConstants.Settings.mockedState.cities)
        cityFormFieldDataSetter.set(text: InnerConstants.Strings.cityNotFoundValidation)
        
        let validationResult = cityFormField.isValid()
        
        guard !validationResult.isValid else {
            XCTFail(Constants.TestsErrors.validationSucceded.localizedDescription)
            return
        }
        
        guard let errorDescription = validationResult.error?.description else {
            XCTFail(Constants.TestsErrors.unexpectedError.localizedDescription)
            return
        }
        
        guard errorDescription == TextSelectionFormFieldError.optionNotFound.description else {
            XCTFail(errorDescription)
            return
        }
    }
    
}
