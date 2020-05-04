//
//  EmeraldTextField+EmeraldTextFieldType.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 2/05/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import Foundation

extension EmeraldTextField: EmeraldTextFieldType {
    public func set(placeholder: String?) {
        initialPlaceHolder = placeholder
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = EmeraldTheme.placeholderColor
    }

    public func getPlaceholder() -> String? {
        return initialPlaceHolder
    }

    public func set(hint: String?) {
        self.hint = hint
    }

    public func getHint() -> String? {
        return hint
    }

    @objc public func setText(with value: String?) {
        if let value = value, !value.isEmpty {
            activateField()
        } else {
            deactivateField()
        }
        text = value
    }

    public func clearText() {
        setText(with: nil)
    }

    public func set(id: String?) {
        self.id = id
    }

    public func getId() -> String? {
        return id
    }

    public func set(isRequired: Bool) {
        self.isRequired = isRequired
    }

    public func getIsRequired() -> Bool {
        return isRequired
    }

    public func handleResult(with validationResult: Result<Bool, Error>) -> Bool {
        switch validationResult {
        case .failure(let error):
            guard let error = error as? FormFieldErrorType else {
                return false
            }

            show(error: error)
            return false
        default:
            clearError()
            return true
        }
    }

    public func show(error: FormFieldErrorType) {
        isErrored = true
        layer.borderColor = EmeraldTheme.redColor.cgColor
    }

    public func clearError() {
        isErrored = false
        layer.borderColor = EmeraldTheme.borderColor.cgColor
    }

    public func validateAndHandle() -> Bool {
        return handleResult(with: isValid())
    }

    public func set(format: TextFormat) {
        innerFormat = format
        switch format {
        case .currency:
            set(maxLength: InnerConstants.maximumDoubleLength)
            set(inputType: .decimalPad)
        case .number:
            set(inputType: .numberPad)
        case .longDate:
            set(maxLength: InnerConstants.maximumDateLength)
            set(inputType: .numberPad)
        case .shortDate:
            set(maxLength: InnerConstants.maximumShortDateLength)
            set(inputType: .numberPad)
        default:
            set(inputType: .asciiCapable)
        }
    }

    public func getFormat() -> TextFormat {
        return innerFormat
    }

    public func getUnformattedText() -> String? {
        guard let textWithFormat = text else {
            return nil
        }

        do {
            return try remove(format: innerFormat, to: textWithFormat)
        } catch {
            return nil
        }
    }

    public func set(inputType: UIKeyboardType) {
        keyboardType = inputType
    }

    public func getInputType() -> UIKeyboardType? {
        return keyboardType
    }

    public func set(maxLength: Int) {
        if maxLength > 0 {
            self.maxLength = maxLength
        }
    }

    public func getMaxLength() -> Int {
        return maxLength
    }

    public func isEnable(_ enable: Bool) {
        alpha = enable == true ? 1 : 0.5
        isEnabled = enable
        deactivateField()
    }

    public func setCustomDelegate(with delegate: CustomEmeraldTextFieldDelegate) {
        customTextFieldDelegate = delegate
    }
}
