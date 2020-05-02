//
//  EmeraldTextFieldType.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 2/05/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import UIKit

public typealias BasicConfigurationType = Identifiable & Requirable & ErroHandable

public protocol EmeraldTextFieldType: AnyObject, BasicConfigurationType, TextConfigurable, TextFormattable {
    func set(maxLength: Int)
    func getMaxLength() -> Int
    func set(inputType: UIKeyboardType)
    func getInputType() -> UIKeyboardType?
    func setCustomDelegate(with delegate: CustomEmeraldTextFieldDelegate)
    func isEnable(_ enable: Bool)
}
