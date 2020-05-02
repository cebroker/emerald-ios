//
//  EmeraldTextFieldType.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 2/05/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import UIKit

public protocol EmeraldTextFieldType: AnyObject, Clearable, Identifiable {
    func set(placeholder: String?)
    func getPlaceholder() -> String?
    func set(hint: String?)
    func getHint() -> String?
    func set(maxLength: Int)
    func getMaxLength() -> Int
    func set(format: TextFormat)
    func getFormat() -> TextFormat
    func getUnformattedText() -> String?
    func set(inputType: UIKeyboardType)
    func getInputType() -> UIKeyboardType?
    func set(isRequired: Bool)
    func getIsRequired() -> Bool
    func isValid() -> Result<Bool, Error>
    func handleResult(with validationResult: Result<Bool, Error>) -> Bool
    func show(error: FormFieldErrorType)
    func setText(with value: String?)
    func setCustomDelegate(with delegate: CustomEmeraldTextFieldDelegate)
    func isEnable(_ enable: Bool)
}

public protocol Clearable {
    func clearText()
    func clearError()
}
