//
//  TextFieldType.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 23/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import UIKit

public enum TextFieldType {
    case normal
    case email
    case password
    case currency
    case numeric
    case date
    
    func getKeyboardType() -> UIKeyboardType {
        switch self {
        case .normal, .password:
            return .default
        case .email:
            return .emailAddress
        case .numeric:
            return .decimalPad
        case .currency, .date:
            return .numberPad
        }
    }
}
