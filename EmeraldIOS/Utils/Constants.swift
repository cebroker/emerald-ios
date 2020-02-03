//
//  Constants.swift
//  EmeraldIOS
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

struct Constants {

    public class AddressState: Selectable {
        var name: String
        var id: Int
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

        public func getSelectableId() -> String {
            return String(id)
        }

        public func setSelectableText(with value: String) {
            self.name = value
        }

        public func setSelectableId(with value: String) {
            self.id = Int(value) ?? 0
        }
    }

    struct Regex {
        static let ssn = "^[0-9]{9}$"
        static let npi = "^[0-9]{10}$"
        static let phone = "^[0-9]{3}[-]{1}[0-9]{3}[-]{1}[0-9]{4}$"
        static let zip = "^[0-9]{5}$"
        static let visa = "^[A-Z0-9a-z]*$"
        static let email = "^[a-zA-Z0-9!#$%&'*+=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])*$"
        static let any = "(.*?)"
        static let upperCased = "[A-Z]"
        static let lowerCased = "[a-z]"
        static let numbers = "[0-9]"
    }

    struct TextFormating {
        static let currency = "$%.0f"
        static let phone = "PHONE_FORMAT"
        static let phoneLength = 10
        static let phonePrefixIndex = 3
        static let alternatePhonePrefixIndex = 4
        static let phoneSuffixIndex = 7
        static let alternatePhoneSuffixIndex = 9
        static let alternatePhoneMaxLength = 13
        static let dateFirstSeparatorIndex = 2
        static let dateFirstValidatorIndex = 2
        static let dateSecondValidatorIndex = 4
        static let dateSecondSeparatorIndex = 5
        static let maxMonthValue = 12
        static let ssnPrefixIndex = 3
        static let ssnSuffixIndex = 6
        static let ssnMaxLength = 11
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
        static let backend = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        static let shortFormat = "MM/yyyy"
        static let defaultFormat = "MM/dd/yyyy"
        static let hyphenDateFormat = "MM-dd-yyyy"
        static let yyyyMMdd = "yyyy-MM-dd"
        static let defaultLocale = "en_US_POSIX"
        static let defaultTimeZone = "GMT+0:00"
        static let monthLocalizedDateFormat = "MMMM"
        static let yeardLocalizedDateFormat = "y"
    }

    struct Dimens {
        struct SingleRadioButton {
            static let height = 58
        }
        
        struct RadioButtonCircle {
            static let side = 20
        }
        
        static let origin = 0
        static let chipsCornerRadiousSimple = CGFloat(integerLiteral: 2)
        static let chipsCornerRadiousDissmissable = CGFloat(integerLiteral: 15)
    }

    struct Values {
        static let empty = ""
        static let hyphen = "-"
        static let slash = "/"
        static let stringComma: String = ","
        static let dollar = "$"
        static let dollarWithSpace = "$ "
        static let localIdentifier = "en_US_POSIX"
        static let dot: Character = "."
        static let space = " "
        static let zero = 0
        static let one: CGFloat = 1
        static let zeroDecimals = ".00"
        static let select = "Select"
        static let openingParenthesis = "("
        static let closingParenthesis = ")"
    }

    struct Design {

        static let font = "OpenSans-Regular"
        static let fontSemiBold = "OpenSans-SemiBold"
        static let fontBold = "OpenSans-Bold"

        struct FontSize {
            static let form: CGFloat = 12
            static let body: CGFloat = 16
            static let button: CGFloat = 18
        }

        struct Color {
            static let grayBorder = UIColor(hex: 0xC0C0C0)
            static let lightGreen = UIColor(hex: 0x33DB95)
            static let blueAccent = UIColor(hex: 0x42A5F5)
        }
    }
    
    struct ReusableId {
        static let verticalDivider = "verticalDivider"
        static let barChartcell = "barChartCell"
        static let verticalLabel = "verticalLabel"
        static let sideBar = "sideBar"
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

    func getSelectableId() -> String {
        return ""
    }
}
