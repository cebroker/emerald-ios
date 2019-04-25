//
//  CheckboxFormFieldTests.swift
//  EmeraldIOSTests
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import XCTest

@testable import EmeraldIOS

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

    var checkboxField: FormFieldType<[Selectable]> = CheckboxFormField(frame: InnerConstants.Settings.mockFrame)

    func testShouldPassValidation() {
        (self.checkboxField as? MultipleSelectionFormFieldType)?.set(data: Constants.MockedData.educationTypes)

        (self.checkboxField as? TestableCheckboxFormFieldType)?.select(option: InnerConstants.Values.successful1, status: true)
        (self.checkboxField as? TestableCheckboxFormFieldType)?.select(option: InnerConstants.Values.successful2, status: true)

        let validationResult = checkboxField.isValid()

        XCTAssert(validationResult.isValid)
    }

    func testShouldNotPassValidationEmpty() {
        (self.checkboxField as? MultipleSelectionFormFieldType)?.set(data: Constants.MockedData.educationTypes)

        let validationResult = checkboxField.isValid()

        XCTAssert(!validationResult.isValid)

        XCTAssertEqual(
            validationResult.error?.description,
            FormFieldError.emptyField.description)
    }
}
