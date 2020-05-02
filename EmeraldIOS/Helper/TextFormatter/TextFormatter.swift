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
    case shortDate
    case longDate
    case alternatePhone
    case ssn
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
    func formatCurrency(resource: String) -> String
    func removeCurrencyFormat(from resource: String) -> String
}

public extension TextFormatter {
    func apply(format: TextFormat, to resource: String) throws -> String {
        switch format {
        case .phone:
            return formatResource(phoneNumber: resource)
        case .shortDate:
            return formatShortDate(with: resource)
        case .longDate:
            return formatDate(with: resource)
        case .alternatePhone:
            return formatAlternatePhone(phoneNumber: resource)
        case .ssn:
            return formatSSN(ssnNumber: resource)
        default:
            return resource
        }
    }

    func remove(format: TextFormat, to resource: String) throws -> String {
        switch format {
        case .phone, .alternatePhone:
            return resource.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        default:
            return resource
        }
    }

    func formatCurrency(resource: String) -> String {
        let formatter = NumberFormatter()
        formatter.currencyCode = "USD"
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        let simpleFormat = Constants.Values.dollarWithSpace + resource
        
        guard let double = Double(resource) else {
            return simpleFormat
        }
        
        return formatter.string(from: NSNumber(value: double)) ?? simpleFormat
    }
    
    func removeCurrencyFormat(from resource: String) -> String {
        if resource == Constants.Values.dollar {
            return Constants.Values.empty
        }

        let firstCleaner = resource.replacingOccurrences(
            of: Constants.Values.stringComma,
            with: Constants.Values.empty)
        
        let secondCleaner = firstCleaner.replacingOccurrences(
            of: Constants.Values.zeroDecimals,
            with: Constants.Values.empty)
        
        var rawNumber = secondCleaner
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

            if rawNumber.count - 1 >= dotIndex.utf16Offset(in: Constants.Values.empty) + 3 {
                rawNumber.remove(at: rawNumber.index(dotIndex, offsetBy: 3))
            }
        }

        return rawNumber
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
    
    private func formatSSN(ssnNumber: String) -> String {
        let numbersOnly = ssnNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        return numbersOnly.reduce(Constants.Values.empty) { (result, individualNumber) in
            if result.count == Constants.TextFormating.ssnPrefixIndex || result.count == Constants.TextFormating.ssnSuffixIndex {
                return result + Constants.Values.hyphen + String(individualNumber)
            } else if result.count >= Constants.TextFormating.ssnMaxLength {
                return result
            }
            
            return result + String(individualNumber)
        }
    }
    
    private func formatAlternatePhone(phoneNumber: String) -> String {
        let numbersOnly = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        return numbersOnly.reduce(Constants.Values.empty) { (result, individualNumber) in
            switch result.count {
            case let x where x == Constants.Values.zero:
                return result + Constants.Values.openingParenthesis + String(individualNumber)
            case let x where x == Constants.TextFormating.alternatePhonePrefixIndex:
                return result + Constants.Values.closingParenthesis + " \(individualNumber)"
            case let x where x == Constants.TextFormating.alternatePhoneSuffixIndex:
                return result + Constants.Values.hyphen + String(individualNumber)
            case let x where x > Constants.TextFormating.alternatePhoneMaxLength:
                return result
            default:
                return result + String(individualNumber)
            }
        }
    }
    
    private func formatShortDate(with resource: String) -> String {
        let numbersOnly = getNumbersOnlyForDateFormat(with: resource)
        
        return numbersOnly.reduce(Constants.Values.empty) { (result, individualNumber) in
            if result.count == Constants.TextFormating.dateFirstSeparatorIndex {
                return result + Constants.Values.slash + String(individualNumber)
            }
            return result + String(individualNumber)
        }
    }
    
    private func formatDate(with resource: String) -> String {
        let numbersOnly = getNumbersOnlyForDateFormat(with: resource)
        
        return numbersOnly.reduce(Constants.Values.empty) { (result, individualNumber) in
            if result.count == Constants.TextFormating.dateFirstSeparatorIndex || result.count == Constants.TextFormating.dateSecondSeparatorIndex {
                return result + Constants.Values.slash + String(individualNumber)
            }
            return result + String(individualNumber)
        }
    }
    
    private func getNumbersOnlyForDateFormat(with resource: String) -> String {
        var numbersOnly = resource.components(separatedBy: Constants.Values.slash).joined()
        let numbersOnlyAsInt = Int(numbersOnly) ?? Constants.Values.zero
        
        if numbersOnly.count == Constants.TextFormating.dateFirstValidatorIndex && numbersOnlyAsInt > Constants.TextFormating.maxMonthValue  {
            numbersOnly = String(Constants.TextFormating.maxMonthValue)
        }
        
        if numbersOnly.count == Constants.TextFormating.dateSecondValidatorIndex {
            var dateFormated = DateComponents()
            let daySuffix = Int(numbersOnly.suffix(2)) ?? Constants.Values.zero
            dateFormated.month = Int(numbersOnly.prefix(2))
            let calendar = Calendar.current
            let date = calendar.date(from: dateFormated) ?? Date()
            let range = calendar.range(of: .day, in: .month, for: date)
            let numDaysInMonth = range?.count ?? Constants.Values.zero
            if daySuffix > numDaysInMonth {
                numbersOnly = numbersOnly.prefix(2) + String(numDaysInMonth)
            }
        }
        
        return numbersOnly
    }
}
