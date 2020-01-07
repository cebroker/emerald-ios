//
//  EmeraldInputViewValidableType.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 6/12/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol EmeraldInputViewValidableType {
    func validateAndHandle() -> Bool
    func validateEmeraldFields(with fields: [EmeraldInputViewValidableType]) -> Bool
}

extension EmeraldInputViewValidableType {
    public func validateEmeraldFields(with fields: [EmeraldInputViewValidableType]) -> Bool {
        return fields.map({ $0.validateAndHandle() }).filter({ $0 == false }).isEmpty
    }
    
    public func validateAndHandle() -> Bool {
        return true
    }
}
