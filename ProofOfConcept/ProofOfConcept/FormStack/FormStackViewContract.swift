//
//  FormStackViewContract.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 3/20/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import CondorUIComponentsIOS

public protocol FormStackViewConfigurable {
    func createTextFormField(placeholder: String) -> TextFormField?
    func createTextRegexFormField(placeholder: String) -> TextRegexFormField?
    func createTextSelectionField(placeholder: String) -> TextSelectionFormField?
    func createDateFormField(placeholder: String) -> DateFormField?
    func createFormButton(with title: String) -> FormButton?
    func reloadFields()
}
