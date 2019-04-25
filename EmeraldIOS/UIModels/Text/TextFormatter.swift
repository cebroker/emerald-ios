//
//  TextFormatter.swift
//  EmeraldIOS
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public enum TextFormat: Int {
    case none = 0
    case currency
    case phone
    case number
}

public enum TextFormatterError: Error {
    case cannotApplyCurrencyFormat
    case cannotApplyPhoneFormat
    case cannotRemoveCurrencyFormat
    case cellWithoutFormat
    case cannotApplyDateFormat
}

public protocol TextFormatter {
    func apply(format: TextFormat, to resource: String) throws -> String
    func remove(format: TextFormat, to resource: String) throws -> String
}

public extension TextFormatter {
    func apply(format: TextFormat, to resource: String) throws -> String {
        switch format {
        case .currency:
            return formatCurrency(resource: resource)
        case .phone:
            return formatResource(phoneNumber: resource)
        default:
            return resource
        }
    }

    func remove(format: TextFormat, to resource: String) throws -> String {
        switch format {
        case .currency:
            return removeCurrencyFormat(from: resource)
        case .phone:
            return resource.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        default:
            return resource
        }
    }

    private func formatCurrency(resource: String) -> String {
        if resource == Constants.Values.empty {
            return resource
        }

        return Constants.Values.dollarWithSpace + resource
    }

    private func formatResource(phoneNumber: String) -> String {
        let numbersOnly = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        return numbersOnly.reduce(Constants.Values.empty) { (result, individualNumber) in
            if result.count == Constants.TextFormating.phonePrefixIndex || result.count == Constants.TextFormating.phoneSuffixIndex {
                return result + Constants.Values.hyphen + String(individualNumber)
            }
            return result + String(individualNumber)
        }
    }

    private func removeCurrencyFormat(from resource: String) -> String {
        if resource == Constants.Values.dollar {
            return Constants.Values.empty
        }

        var rawNumber = resource
            .replacingOccurrences(
                of: Constants.Values.dollar,
                with: Constants.Values.empty)
            .trimmingCharacters(in: .whitespaces)

        if let dotIndex = rawNumber.firstIndex(
            of: Constants.Values.dot) {

            if let secondDotIndex = rawNumber.indices.first(where: { index in
                rawNumber[index] == Constants.Values.dot && dotIndex != index
            }) {
                rawNumber.remove(at: secondDotIndex)
            }

            if rawNumber.count - 1 >= dotIndex.encodedOffset + 3 {
                rawNumber.remove(at: rawNumber.index(dotIndex, offsetBy: 3))
            }
        }

        return rawNumber
    }
}
