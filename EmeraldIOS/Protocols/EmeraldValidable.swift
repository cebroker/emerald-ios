//
//  EmeraldValidable.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 6/13/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol EmeraldValidableType {
    func validateAndHandle() -> Bool
    func validateEmeraldFields(with fields: [EmeraldValidableType]) -> Bool
}

extension EmeraldValidableType {
    public func validateEmeraldFields(with fields: [EmeraldValidableType]) -> Bool {
        return fields.map({ $0.validateAndHandle() }).filter({ $0 == false }).isEmpty
    }
    
    public func validateAndHandle() -> Bool {
        return true
    }
}
