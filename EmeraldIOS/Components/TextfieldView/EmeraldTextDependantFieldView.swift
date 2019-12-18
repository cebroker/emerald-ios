//
//  EmeraldTextDependantFieldView.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 18/12/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public class EmeraldTextDependantFieldView: EmeraldTextFieldView {
    public var emeraldTextDependantField: EmeraldTextDependantField = EmeraldTextDependantField()

    public override var textField: EmeraldTextField {
        get {
            return emeraldTextDependantField
        }
        set {
            emeraldTextDependantField = newValue as! EmeraldTextDependantField
        }
    }


    public func set(availableOptions: [String]) {
        self.emeraldTextDependantField.set(availableOptions: availableOptions)
    }

    public func getAvailableOptions() -> [String] {
        return self.emeraldTextDependantField.getAvailableOptions()
    }

    public func set(shouldValidateWithOptions: Bool) {
        self.emeraldTextDependantField.set(shouldValidateWithOptions: shouldValidateWithOptions)
    }

    override public func validateContent() -> Result<Bool, Error> {
        return self.emeraldTextDependantField.validateContent()
    }
}
