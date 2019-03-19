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

    var cityFormField: FormFieldType<String> = TextSelectionFormField(frame: Constants.MockedData.mockFrame)

    func testShouldPassValidation() {

        (self.cityFormField as? TextSelectionFormFieldType)?.set(availableOptions: InnerConstants.Settings.mockedState.cities)
        (self.cityFormField as? TextSelectionFormFieldType)?.set(text: InnerConstants.Strings.passValidation)

        XCTAssert(cityFormField.isValid().isValid)
    }

    func testShouldNotPassValidationEmpty() {

        (self.cityFormField as? TextSelectionFormFieldType)?.set(availableOptions: InnerConstants.Settings.mockedState.cities)
        (self.cityFormField as? TextSelectionFormFieldType)?.set(text: InnerConstants.Strings.emptyValidation)

        let validationResult = cityFormField.isValid()

        XCTAssert(!validationResult.isValid)

        XCTAssertEqual(
            validationResult.error?.description,
            FormFieldError.emptyField.description)
    }

    func testShouldNotPassValidationMissingState() {

        (self.cityFormField as? TextSelectionFormFieldType)?.set(text: InnerConstants.Strings.passValidation)

        let validationResult = cityFormField.isValid()

        XCTAssert(!validationResult.isValid)

        XCTAssertEqual(
            validationResult.error?.description,
            TextSelectionFormFieldError.missingAvailableOptions.description)
    }

    func testShouldNotPassValidationCityNotFound() {

        (self.cityFormField as? TextSelectionFormFieldType)?.set(availableOptions: InnerConstants.Settings.mockedState.cities)
        (self.cityFormField as? TextSelectionFormFieldType)?.set(text: InnerConstants.Strings.cityNotFoundValidation)

        let validationResult = cityFormField.isValid()

        XCTAssert(!validationResult.isValid)

        XCTAssertEqual(
            validationResult.error?.description,
            TextSelectionFormFieldError.optionNotFound.description)
    }

}
