//
//  EmeraldRegexFormatType.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//
public enum EmeraldRegexFormatType {
    case email
    case zip
    case phone
    case alternatePhone
    case npi
    case ssn
    case upperCased
    case lowerCased
    case numbers
    case custom(String)
    case any

    var rawValue: String {
        return regex!
    }

    init(rawValue: String) {
        switch rawValue {
        case "email":
            self = EmeraldRegexFormatType.email
        case "zip":
            self = EmeraldRegexFormatType.zip
        case "phone":
            self = EmeraldRegexFormatType.phone
        case "alternatePhone":
            self = .alternatePhone
        case "npi":
            self = EmeraldRegexFormatType.npi
        case "ssn":
            self = EmeraldRegexFormatType.ssn
        case "upperCased":
            self = EmeraldRegexFormatType.upperCased
        case "lowerCased":
            self = EmeraldRegexFormatType.lowerCased
        case "numbers":
            self = EmeraldRegexFormatType.numbers
        case "custom(String)":
            var cleanRawValue = rawValue.replacingOccurrences(of: "custom(", with: "")
            cleanRawValue.removeLast()
            self = EmeraldRegexFormatType.custom(cleanRawValue)
        default:
            self = .any
        }
    }

    var regex: String? {
        switch self {
        case .email:
            return Constants.Regex.email
        case .zip:
            return Constants.Regex.zip
        case .phone:
            return Constants.Regex.phone
        case .alternatePhone:
            return Constants.Regex.alternatePhone
        case .npi:
            return Constants.Regex.npi
        case .ssn:
            return Constants.Regex.ssn
        case .upperCased:
            return Constants.Regex.upperCased
        case .lowerCased:
            return Constants.Regex.lowerCased
        case .numbers:
            return Constants.Regex.numbers
        case .any:
            return Constants.Regex.any
        case .custom(let regex):
            return regex
        }
    }
}
