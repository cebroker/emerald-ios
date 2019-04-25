//
//  DateFormFieldTests.swift
//  EmeraldIOSTests
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import XCTest

@testable import EmeraldIOS

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

    var dateFormField: FormFieldType<String> = DateFormField(frame: Constants.MockedData.mockFrame)

    func testShouldPassValidation() {

        (self.dateFormField as? DateFormFieldType)?.set(dateFormat: Constants.DateFormat.defaultFormat)

        (self.dateFormField as? DateFormFieldTestableType)?.set(
            day: InnerConstants.Values.SuccessTest.day,
            month: InnerConstants.Values.SuccessTest.month,
            year: InnerConstants.Values.SuccessTest.year)

        XCTAssert(dateFormField.isValid().isValid)

        XCTAssertEqual(
            dateFormField.getValue(),
            InnerConstants.Strings.success)
    }

    func testShouldNotPassValidationEmpty() {

        (self.dateFormField as? DateFormFieldType)?.set(dateFormat: Constants.DateFormat.defaultFormat)

        let validationResult = dateFormField.isValid()

        XCTAssert(!validationResult.isValid)

        XCTAssertEqual(
            validationResult.error?.description,
            FormFieldError.emptyField.description)
    }

    func testShouldNotPassValidationLowerThanMinimumDate() {

        (self.dateFormField as? DateFormFieldType)?.set(dateFormat: Constants.DateFormat.defaultFormat)

        (self.dateFormField as? DateFormFieldTestableType)?.setMinimum(
            day: InnerConstants.Values.ReferenceDate.day,
            month: InnerConstants.Values.ReferenceDate.month,
            year: InnerConstants.Values.ReferenceDate.year)

        (self.dateFormField as? DateFormFieldTestableType)?.set(
            day: InnerConstants.Values.FailedMinimumDate.day,
            month: InnerConstants.Values.FailedMinimumDate.month,
            year: InnerConstants.Values.FailedMinimumDate.year)

        let validationResult = dateFormField.isValid()

        XCTAssert(!validationResult.isValid)

        XCTAssertEqual(
            validationResult.error?.description,
            DateFormFieldError.lowerThanMinimumDate.description)
    }

    func testShouldNotPassValidationGreaterThanMaximumDate() {

        (self.dateFormField as? DateFormFieldType)?.set(dateFormat: Constants.DateFormat.defaultFormat)

        (self.dateFormField as? DateFormFieldTestableType)?.setMaximum(
            day: InnerConstants.Values.ReferenceDate.day,
            month: InnerConstants.Values.ReferenceDate.month,
            year: InnerConstants.Values.ReferenceDate.year)

        (self.dateFormField as? DateFormFieldTestableType)?.set(
            day: InnerConstants.Values.FailedMaximumDate.day,
            month: InnerConstants.Values.FailedMaximumDate.month,
            year: InnerConstants.Values.FailedMaximumDate.year)

        let validationResult = dateFormField.isValid()

        XCTAssert(!validationResult.isValid)

        XCTAssertEqual(
            validationResult.error?.description,
            DateFormFieldError.greaterThanMaximumDate.description)
    }
}
