//
//  EmeraldRegexFormatType.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//
public enum EmeraldRegexFormatType: String, Inspectable {
    case email
    case zip
    case phone
    case npi
    case ssn
    case upperCased
    case lowerCased
    case numbers
    case custom
    case any = "(.*?)"
    
    var regex: String? {
        switch self {
        case .email:
            return Constants.Regex.email
        case .zip:
            return Constants.Regex.zip
        case .phone:
            return Constants.Regex.phone
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
        default:
            return nil
        }
    }
    
    var IBInspectable: String {
        return rawValue
    }
    
    init(IBInspectable: String) {
        self.init(stringValue: IBInspectable)
    }
}
