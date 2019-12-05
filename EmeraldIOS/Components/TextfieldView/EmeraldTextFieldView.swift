//
//  EmeraldTextFieldView.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 4/12/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public class EmeraldTextFieldView: BaseInputView {

    override func setupViews() {
        super.setupViews()
        self.setDelegate(self)
    }
}

extension EmeraldTextFieldView: CustomEmeraldTextFieldDelegate {
    public func didEndEditing(textField: UITextField) {
        self.handleResult(with: self.textField.validateContent())
    }
}
