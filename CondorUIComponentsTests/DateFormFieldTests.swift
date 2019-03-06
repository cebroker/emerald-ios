//
//  DateFormFieldTests.swift
//  CondorUIComponentsTests
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import XCTest

@testable import CondorUIComponents

class DateFormFieldTests: XCTestCase {

    private struct InnerConstants {
        struct Strings {
            static let success = "02/05/2016"
        }

        struct Settings {
            static let mockFrame = Constants.MockedData.mockFrame
        }

        struct Values {
            struct SuccessTest {
                static let day = 5
                static let month = 2
                static let year = 2016
            }
            struct ReferenceDate {
                static let day = 5
                static let month = 2
                static let year = 2016
            }
            struct FailedMinimumDate {
                static let day = 4
                static let month = 2
                static let year = 2016
            }
            struct FailedMaximumDate {
                static let day = 6
                static let month = 2
                static let year = 2016
            }
        }
    }

    var dateFormField: FormFieldType<String>?

    override func setUp() {
        dateFormField = DateFormField(frame: Constants.MockedData.mockFrame)
    }

    override func tearDown() {
        dateFormField = nil
    }

    func testShouldPassValidation() {
        guard let dateFormField = self.dateFormField else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        guard let dateFormFieldDataSetter = self.dateFormField as? DateFormFieldType else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        guard let testableDateFormFieldDataSetter = self.dateFormField as? DateFormFieldTestableType else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        dateFormFieldDataSetter.set(dateFormat: Constants.DateFormat.defaultFormat)

        testableDateFormFieldDataSetter.set(
            day: InnerConstants.Values.SuccessTest.day,
            month: InnerConstants.Values.SuccessTest.month,
            year: InnerConstants.Values.SuccessTest.year)

        guard dateFormField.isValid().isValid else {
            if let error = dateFormField.isValid().error?.description {
                XCTFail(error)
            } else {
                XCTFail(Constants.TestsErrors.validationFailed.localizedDescription)
            }
            return
        }

        guard dateFormField.getValue() == InnerConstants.Strings.success else {
            XCTFail(Constants.TestsErrors.validationFailed.localizedDescription)
            return
        }
    }

    func testShouldNotPassValidationEmpty() {

        guard let dateFormField = self.dateFormField else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        guard let dateFormFieldDataSetter = self.dateFormField as? DateFormFieldType else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }

        dateFormFieldDataSetter.set(dateFormat: Constants.DateFormat.defaultFormat)

        let validationResult = dateFormField.isValid()

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

    func testShouldNotPassValidationLowerThanMinimumDate() {
        guard let dateFormField = self.dateFormField else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        guard let dateFormFieldDataSetter = self.dateFormField as? DateFormFieldType else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        guard let testableDateFormField = self.dateFormField as? DateFormFieldTestableType else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }

        dateFormFieldDataSetter.set(dateFormat: Constants.DateFormat.defaultFormat)

        testableDateFormField.setMinimum(
            day: InnerConstants.Values.ReferenceDate.day,
            month: InnerConstants.Values.ReferenceDate.month,
            year: InnerConstants.Values.ReferenceDate.year)

        testableDateFormField.set(
            day: InnerConstants.Values.FailedMinimumDate.day,
            month: InnerConstants.Values.FailedMinimumDate.month,
            year: InnerConstants.Values.FailedMinimumDate.year)

        let validationResult = dateFormField.isValid()

        guard !validationResult.isValid else {
            XCTFail(Constants.TestsErrors.validationSucceded.localizedDescription)
            return
        }

        guard let errorDescription = validationResult.error?.description else {
            XCTFail(Constants.TestsErrors.unexpectedError.localizedDescription)
            return
        }

        guard errorDescription == DateFormFieldError.lowerThanMinimumDate.description else {
            XCTFail(errorDescription)
            return
        }
    }

    func testShouldNotPassValidationGreaterThanMaximumDate() {
        guard let dateFormField = self.dateFormField else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        guard let dateFormFieldDataSetter = self.dateFormField as? DateFormFieldType else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }
        
        guard let testableDateFormField = self.dateFormField as? DateFormFieldTestableType else {
            XCTFail(Constants.TestsErrors.formFieldCastingError.localizedDescription)
            return
        }

        dateFormFieldDataSetter.set(dateFormat: Constants.DateFormat.defaultFormat)

        testableDateFormField.setMaximum(
            day: InnerConstants.Values.ReferenceDate.day,
            month: InnerConstants.Values.ReferenceDate.month,
            year: InnerConstants.Values.ReferenceDate.year)

        testableDateFormField.set(
            day: InnerConstants.Values.FailedMaximumDate.day,
            month: InnerConstants.Values.FailedMaximumDate.month,
            year: InnerConstants.Values.FailedMaximumDate.year)

        let validationResult = dateFormField.isValid()

        guard !validationResult.isValid else {
            XCTFail(Constants.TestsErrors.validationSucceded.localizedDescription)
            return
        }

        guard let errorDescription = validationResult.error?.description else {
            XCTFail(Constants.TestsErrors.unexpectedError.localizedDescription)
            return
        }

        guard errorDescription == DateFormFieldError.greaterThanMaximumDate.description else {
            XCTFail(errorDescription)
            return
        }
    }
}
