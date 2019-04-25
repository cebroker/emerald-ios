//
//  PhoneTextFieldTests.swift
//  EmeraldIOSTests
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import XCTest

@testable import EmeraldIOS

class PhoneTextFieldTests: XCTestCase {

    private struct InnerConstants {
        struct Strings {
            static let successfulPhone = "123-412-3412"
            static let emptyPhone = ""
            static let notNumeric = "asdfa"
            static let invalidLength = "1234"
        }

        enum Errors: Error {
            case validationFailed
            case validationSucceded
            case unexpectedError
            case formFieldCastingError
        }
    }

    var phoneTextField: FormFieldType<String> = TextRegexFormField(frame: Constants.MockedData.mockFrame)

    func testShouldPassValidation() {

        (self.phoneTextField as? TextRegexFormFieldType)?.set(regex: Constants.Regex.phone)
        (self.phoneTextField as? TextRegexFormFieldType)?.set(text: InnerConstants.Strings.successfulPhone)

        XCTAssert(phoneTextField.isValid().isValid)
    }

    func testShouldNotPassValidationEmpty() {

        (self.phoneTextField as? TextRegexFormFieldType)?.set(regex: Constants.Regex.phone)
        (self.phoneTextField as? TextRegexFormFieldType)?.set(text: InnerConstants.Strings.emptyPhone)

        let validationResult = phoneTextField.isValid()

        XCTAssert(!validationResult.isValid)

        XCTAssertEqual(
            validationResult.error?.description,
            FormFieldError.emptyField.description)
    }

    func testShouldNotPassValidationRegexNotMaching() {

        (self.phoneTextField as? TextRegexFormFieldType)?.set(regex: Constants.Regex.phone)
        (self.phoneTextField as? TextRegexFormFieldType)?.set(text: InnerConstants.Strings.notNumeric)

        let validationResult = phoneTextField.isValid()

        XCTAssert(!validationResult.isValid)

        XCTAssertEqual(
            validationResult.error?.description,
            TextRegexFormFieldError.notMatchingRegex.description)
    }
}
