//
//  PhoneTextFieldTests.swift
//  CondorUIComponentsTests
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import XCTest

@testable import CondorUIComponents

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

//    var phoneTextField: FormFieldType?
    var phoneTextField: TextRegexFormField?

    override func setUp() {

        phoneTextField = TextRegexFormField(frame: Constants.MockedData.mockFrame)
    }

    override func tearDown() {
        phoneTextField = nil
    }

    func testShouldPassValidation() {
        guard let phoneTextField = self.phoneTextField as? TextRegexFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }

        phoneTextField.set(regex: Constants.Regex.phone)

        guard let testablePhoneTextField = self.phoneTextField as? TestableTextFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }

        testablePhoneTextField.set(text: InnerConstants.Strings.successfulPhone)

        guard phoneTextField.isValid().isValid else {
            if let error = phoneTextField.isValid().error?.description {
                XCTFail(error)
            } else {
                XCTFail(Constants.TestsErrors.validationFailed.localizedDescription)
            }
            return
        }
    }

    func testShouldNotPassValidationEmpty() {
        guard let phoneTextField = self.phoneTextField as? TextRegexFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }

        phoneTextField.set(regex: Constants.Regex.phone)

        guard let testablePhoneTextField = self.phoneTextField as? TestableTextFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }

        testablePhoneTextField.set(text: InnerConstants.Strings.emptyPhone)


        let validationResult = phoneTextField.isValid()

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

    func testShouldNotPassValidationMissingRegex() {
        guard let phoneTextField = self.phoneTextField as? TextRegexFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }

        guard let testablePhoneTextField = self.phoneTextField as? TestableTextFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }

        testablePhoneTextField.set(text: InnerConstants.Strings.successfulPhone)

        let validationResult = phoneTextField.isValid()

        guard !validationResult.isValid else {
            XCTFail(Constants.TestsErrors.validationSucceded.localizedDescription)
            return
        }

        guard let errorDescription = validationResult.error?.description else {
            XCTFail(Constants.TestsErrors.unexpectedError.localizedDescription)
            return
        }

        guard errorDescription == TextRegexFormFieldError.missingRegex.description else {
            XCTFail(errorDescription)
            return
        }
    }

    func testShouldNotPassValidationRegexNotMaching() {
        guard let phoneTextField = self.phoneTextField as? TextRegexFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }

        phoneTextField.set(regex: Constants.Regex.phone)

        guard let testablePhoneTextField = self.phoneTextField as? TestableTextFormFieldProtocol else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }

        testablePhoneTextField.set(text: InnerConstants.Strings.notNumeric)

        let validationResult = phoneTextField.isValid()

        guard !validationResult.isValid else {
            XCTFail(Constants.TestsErrors.validationSucceded.localizedDescription)
            return
        }

        guard let errorDescription = validationResult.error?.description else {
            XCTFail(Constants.TestsErrors.unexpectedError.localizedDescription)
            return
        }

        guard errorDescription == TextRegexFormFieldError.notMatchingRegex.description else {
            XCTFail(errorDescription)
            return
        }
    }
}
