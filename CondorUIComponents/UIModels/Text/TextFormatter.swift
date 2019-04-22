//
//  TextFormatter.swift
//  CondorUIComponents
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
        guard let amount = Int(resource) else {
            return resource
        }

        let formatter = getCurrencyFormatter()

        guard let currency = formatter.string(from: amount as NSNumber) else {
            return resource
        }

        return currency
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
        let formatter = getCurrencyFormatter()

        if let formattedNumber = formatter.number(from: resource) as? Int {
            return String(describing: formattedNumber)
        } else {
            if resource == Constants.Values.dollar {
                return Constants.Values.empty
            }
            return resource
        }
    }

    private func getCurrencyFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()

        formatter.locale = Locale(identifier: Constants.Values.localIdentifier)
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.currencySymbol = Constants.Values.dollar
        formatter.generatesDecimalNumbers = false

        return formatter
    }
}
