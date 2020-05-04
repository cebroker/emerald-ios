//
//  EmeraldTextFieldType.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 2/05/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import UIKit

public typealias BasicConfigurationType = Identifiable & Requirable & ErroHandable & EmeraldValidableType & Validable
public typealias TextFieldConfigurationType = TextConfigurable & TextFormattable
public typealias UITextFieldType = UITextField & UITextFieldDelegate

public protocol EmeraldTextFieldType: AnyObject, BasicConfigurationType, TextFieldConfigurationType {
    func set(maxLength: Int)
    func getMaxLength() -> Int
    func set(inputType: UIKeyboardType)
    func getInputType() -> UIKeyboardType?
    func setCustomDelegate(with delegate: CustomEmeraldTextFieldDelegate)
    func isEnable(_ enable: Bool)
}

extension EmeraldTextFieldType where Self: UITextFieldType {}
