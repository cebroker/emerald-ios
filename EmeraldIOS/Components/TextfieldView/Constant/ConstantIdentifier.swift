//
//  ConstantIdentifier.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 10/12/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public struct ConstantIdentifier {
    static let textField = Identifier.textfield.getValue()
    static let errorLabel = Identifier.errorLabel.getValue()
}

public enum Identifier: String {
    case textfield
    case errorLabel

    func getValue() -> String {
        return self.rawValue
    }
}
