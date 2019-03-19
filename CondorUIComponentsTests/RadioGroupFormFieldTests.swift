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

    var radioGroupField: FormFieldType<[Selectable]> = RadioGroupFormField(frame: InnerConstants.Settings.mockFrame)

    func testShouldPassValidation() {

        (self.radioGroupField as? MultipleSelectionFormFieldType)?.set(data: Constants.MockedData.educationTypes)

        (self.radioGroupField as? TestableRadioGroupFormFieldType)?.select(option: InnerConstants.Values.successful)

        XCTAssert(radioGroupField.isValid().isValid)
    }

    func testShouldNotPassValidationEmpty() {

        (self.radioGroupField as? MultipleSelectionFormFieldType)?.set(data: Constants.MockedData.educationTypes)

        let validationResult = radioGroupField.isValid()

        XCTAssert(!validationResult.isValid)

        XCTAssertEqual(
            validationResult.error?.description,
            FormFieldError.emptyField.description)
    }
}
