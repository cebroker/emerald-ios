//
//  FormStackViewContract.swift
//  EmeraldIOS
//
//  Created by Luis David Goyes Garces on 4/24/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol FormStackViewConfigurable {
    func createLabel() -> EmeraldLabel?
    func createTextFormField(placeholder: String) -> TextFormField?
    func createTextRegexFormField(placeholder: String) -> TextRegexFormField?
    func createTextSelectionField(placeholder: String) -> TextSelectionFormField?
    func createDateFormField(placeholder: String) -> DateFormField?
    func createFormButton(with title: String) -> FormButton?
    func reloadFields()
}
