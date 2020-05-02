//
//  RegexTextFieldView.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 4/12/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public class EmeraldRegexTextFieldView: EmeraldTextFieldView {

    public var emeraldRegexTextField = EmeraldRegexTextField()
    override public var textField: EmeraldTextField {
        get {
            return emeraldRegexTextField
        }
        set{
            emeraldRegexTextField = newValue as! EmeraldRegexTextField
        }
    }
    
    public func set(regex: String) {
        self.set(regex: EmeraldRegexFormatType(rawValue: regex))
    }    
    
    public func set(regex: EmeraldRegexFormatType) {
        self.emeraldRegexTextField.set(regex: regex)
      }

    public func getRegex() -> EmeraldRegexFormatType {
        return self.emeraldRegexTextField.getRegex()
    }
    
    public override func validateContent() -> Result<Bool, Error> {
        return self.emeraldRegexTextField.validateContent()
    }
}
