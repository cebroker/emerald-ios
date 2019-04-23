//
//  Constants.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

struct Constants {

    public class AddressState: Selectable {
        let name: String
        let id: Int
        let cities: [String]
        public init(
            name: String,
            id: Int,
            cities: [String]) {
            self.name = name
            self.id = id
            self.cities = cities
        }

        public func getSelectableText() -> String {
            return name
        }
    }

    struct Regex {
        static let ssn = "^[0-9]{9}$"
        static let npi = "^[0-9]{10}$"
        static let phone = "^[0-9]{3}[-]{1}[0-9]{3}[-]{1}[0-9]{4}$"
        static let zip = "^[0-9]{5}$"
        static let email = "^[a-z0-9!#$%&'*+=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])*$"
        static let any = "(.*?)"
    }

    struct TextFormating {
        static let currency = "$%.0f"
        static let phone = "PHONE_FORMAT"
        static let phoneLength = 10
        static let phonePrefixIndex = 3
        static let phoneSuffixIndex = 7
    }

    struct MockedData {
        static let states: [AddressState] = [
            AddressState(
                name: "Antioquia",
                id: 1,
                cities: ["MEDELLIN", "ENVIGADO", "SABANETA", "ITAGUI"]),
            AddressState(
                name: "Cundinamarca",
                id: 2,
                cities: ["CHIA", "BOGOTA"]),
            AddressState(
                name: "Amazonas",
                id: 3,
                cities: ["LETICIA"]),
        ]

        static let educationTypes: [EducationType] = [
            EducationType(type: "Test 1"),
            EducationType(type: "Test Test 2"),
            EducationType(type: "Test Test Test 3")
        ]

        struct MockFrameDimens {
            static let x = 0
            static let y = 0
            static let width = 10
            static let height = 20
        }

        static let mockFrame = CGRect(
            x: Constants.MockedData.MockFrameDimens.x,
            y: Constants.MockedData.MockFrameDimens.y,
            width: Constants.MockedData.MockFrameDimens.width,
            height: Constants.MockedData.MockFrameDimens.height)
    }

    enum TestsErrors: Error {
        case validationFailed
        case validationSucceded
        case unexpectedError
        case formFieldCastingError
    }

    struct DateFormat {
        static let defaultFormat = "MM/dd/yyyy"
        static let defaultLocale = "en_US_POSIX"
        static let defaultTimeZone = "GMT+0:00"
    }

    struct Dimens {
        struct SingleRadioButton {
            static let height = 58
        }
        struct RadioButtonCircle {
            static let side = 20
        }
        static let origin = 0
    }

    struct Values {
        static let empty = ""
        static let hyphen = "-"
        static let stringComma: String = ","
        static let dollar = "$"
        static let dollarWithSpace = "$ "
        static let localIdentifier = "en_US_POSIX"
        static let dot: Character = "."
    }

    struct Design {
        static let font = "OpenSans-Regular"
        static let fontSemiBold = "OpenSans-SemiBold"
        static let fontBold = "OpenSans-Bold"

        struct FontSize {
            static let form: CGFloat = 12
            static let body: CGFloat = 16
        }

        struct Color {
            static let grayBorder = UIColor(hex: 0xC0C0C0)
            static let lightGreen = UIColor(hex: 0x33DB95)
        }
    }
}

class EducationType: Selectable {
    private let type: String

    init(type: String) {
        self.type = type
    }

    func getSelectableText() -> String {
        return self.type
    }
}
