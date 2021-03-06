//
//  EmeraldStackViewContract.swift
//  EmeraldIOS
//
//  Created by Luis David Goyes Garces on 4/24/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol EmeraldStackViewConfigurable {
    func createLabel() -> EmeraldLabel?
    func createEmeraldTextField(placeholder: String) -> EmeraldTextField?
    func createEmeraldRegexFormField(placeholder: String) -> EmeraldRegexTextField?
    func createEmeraldTextDependantField(placeholder: String) -> EmeraldTextDependantField?
    func createDateFormField(placeholder: String) -> EmeraldDateField?
    func createButton(with title: String) -> EmeraldButton?
    func reloadFields()
}
