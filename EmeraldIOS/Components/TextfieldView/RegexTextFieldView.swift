//
//  RegexTextFieldView.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 4/12/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public class RegexTextFieldView: BaseInputView<EmeraldRegexTextField> {

    @IBInspectable
    public var regex: String {
        set {
            self.set(regex: EmeraldRegexFormatType(rawValue: newValue))
        }
        get {
            return self.getRegex().regex!
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setupViews() {
        super.setupViews()
        self.set(placeholder: "example placeholder")
        self.setDelegate(self)
    }
    
    public func set(regex: EmeraldRegexFormatType) {
        self.textField.set(regex: regex)
      }

    public func getRegex() -> EmeraldRegexFormatType {
        return self.textField.getRegex()
    }
}

extension RegexTextFieldView: CustomEmeraldTextFieldDelegate {
    public func didEndEditing(textField: UITextField) {
        self.handleResult(with: self.textField.validateContent())
    }
}
