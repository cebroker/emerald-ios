//
//  SelectorFormFieldTests.swift
//  EmeraldIOSTests
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import XCTest

@testable import EmeraldIOS

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

    var stateSelectorField: FormFieldType<String> =
        SelectorFormField(frame: Constants.MockedData.mockFrame)

    func testShouldPassValidation() {

        (self.stateSelectorField as? SelectorFormFieldType)?.set(data: Constants.MockedData.states)
        (self.stateSelectorField as? SelectorFormFieldType)?.set(selectedRow: InnerConstants.Values.successfulState)

        XCTAssert(stateSelectorField.isValid().isValid)
    }

    func testShouldNotPassValidationEmpty() {

        (self.stateSelectorField as? SelectorFormFieldType)?.set(data: Constants.MockedData.states)

        let validationResult = stateSelectorField.isValid()

        XCTAssert(!validationResult.isValid)

        XCTAssertEqual(
            validationResult.error?.description,
            FormFieldError.emptyField.description)
    }

    func testShouldNotPassValidationMissingSelectedRow() {

        (self.stateSelectorField as? SelectorFormFieldType)?.set(data: [Constants.MockedData.states[0]])
        (self.stateSelectorField as? SelectorFormFieldType)?.set(selectedRow: Constants.MockedData.states[1])

        let validationResult = stateSelectorField.isValid()

        XCTAssert(!validationResult.isValid)

        XCTAssertEqual(
            validationResult.error?.description,
            SelectorFormFieldError.missingSelectedValue.description)
    }

    func testShouldNotPassValidationUISelectedValueMismatch() {

        (self.stateSelectorField as? SelectorFormFieldType)?.set(data: [Constants.MockedData.states[0]])
        (self.stateSelectorField as? SelectorFormFieldType)?.set(selectedRow: Constants.MockedData.states[0])
        (self.stateSelectorField as? SelectorFormFieldType)?.set(text: Constants.MockedData.states[0].name + " ")

        let validationResult = stateSelectorField.isValid()

        XCTAssert(!validationResult.isValid)

        XCTAssertEqual(
            validationResult.error?.description,
            SelectorFormFieldError.uiSelectedValueMismatch.description)
    }
}
