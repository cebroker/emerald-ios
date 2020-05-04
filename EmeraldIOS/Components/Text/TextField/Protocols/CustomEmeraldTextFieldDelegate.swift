//
//  EmeraldTextField+Delegate.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 2/05/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import UIKit

@objc public protocol CustomEmeraldTextFieldDelegate {
    @objc optional func didEndEditing(textField: UITextField)
    @objc optional func didBeginEditing(textField: UITextField)
    @objc optional func valueDidChange(textField: UITextField, text: String?)
}

