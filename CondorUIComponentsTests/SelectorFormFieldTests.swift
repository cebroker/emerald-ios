//
//  SelectorFormFieldTests.swift
//  CondorUIComponentsTests
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import XCTest

@testable import CondorUIComponents

class SelectorFormFieldTests: XCTestCase {

    private struct InnerConstants {
        struct Strings {
            static let empty = ""
        }

        struct Settings {
            static let mockFrame = Constants.MockedData.mockFrame
        }

        struct Values {
            static let successfulState = Constants.MockedData.states[0]
        }
    }

    var stateSelectorField: FormFieldType<String>?

    override func setUp() {
        stateSelectorField = SelectorFormField(frame: Constants.MockedData.mockFrame)
    }

    override func tearDown() {
        stateSelectorField = nil
    }

    func testShouldPassValidation() {
        guard let stateSelectorField = self.stateSelectorField else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        guard let stateSelectorFieldDataSetter = self.stateSelectorField as? SelectorFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }

        stateSelectorFieldDataSetter.set(data: Constants.MockedData.states)
        stateSelectorFieldDataSetter.set(selectedRow: InnerConstants.Values.successfulState)

        guard stateSelectorField.isValid().isValid else {
            if let error = stateSelectorField.isValid().error?.description {
                XCTFail(error)
            } else {
                XCTFail(Constants.TestsErrors.validationFailed.localizedDescription)
            }
            return
        }
    }

    func testShouldNotPassValidationEmpty() {
        guard let stateSelectorField = self.stateSelectorField else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        guard let stateSelectorFieldDataSetter = self.stateSelectorField as? SelectorFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }

        stateSelectorFieldDataSetter.set(data: Constants.MockedData.states)

        let validationResult = stateSelectorField.isValid()

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

    func testShouldNotPassValidationMissingSelectedRow() {
        guard let stateSelectorField = self.stateSelectorField else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        guard let stateSelectorFieldDataSetter = self.stateSelectorField as? SelectorFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }

        stateSelectorFieldDataSetter.set(data: [Constants.MockedData.states[0]])
        stateSelectorFieldDataSetter.set(selectedRow: Constants.MockedData.states[1])

        let validationResult = stateSelectorField.isValid()

        guard !validationResult.isValid else {
            XCTFail(Constants.TestsErrors.validationSucceded.localizedDescription)
            return
        }

        guard let errorDescription = validationResult.error?.description else {
            XCTFail(Constants.TestsErrors.unexpectedError.localizedDescription)
            return
        }

        guard errorDescription == SelectorFormFieldError.missingSelectedValue.description else {
            XCTFail(errorDescription)
            return
        }
    }

    func testShouldNotPassValidationUISelectedValueMismatch() {
        guard let stateSelectorField = self.stateSelectorField else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        guard let stateSelectorFieldDataSetter = self.stateSelectorField as? SelectorFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }

        stateSelectorFieldDataSetter.set(data: [Constants.MockedData.states[0]])
        stateSelectorFieldDataSetter.set(selectedRow: Constants.MockedData.states[0])
        stateSelectorFieldDataSetter.set(text: Constants.MockedData.states[0].name + " ")

        let validationResult = stateSelectorField.isValid()

        guard !validationResult.isValid else {
            XCTFail(Constants.TestsErrors.validationSucceded.localizedDescription)
            return
        }

        guard let errorDescription = validationResult.error?.description else {
            XCTFail(Constants.TestsErrors.unexpectedError.localizedDescription)
            return
        }

        guard errorDescription == SelectorFormFieldError.uiSelectedValueMismatch.description else {
            XCTFail(errorDescription)
            return
        }
    }
}
