//
//  TextFormField.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public protocol TextFormFieldType {
    func set(placeholder: String?)
    func getPlaceholder() -> String?
    func set(text: String?)
    func getText() -> String?
    func set(maxLength: Int)
    func getMaxLength() -> Int
    func set(format: TextFormat)
    func getFormat() -> TextFormat
    func getUnformattedText() -> String?
    func set(font: UIFont?)
    func getFont() -> UIFont?
    func set(textColor: UIColor?)
    func getTextColor() -> UIColor?
    func set(inputType: UIKeyboardType)
    func getInputType() -> UIKeyboardType?
}

@IBDesignable
public class TextFormField: FormFieldType<String>, TextFormFieldType, TextFormatter, UITextFieldDelegate {

    var textField: UITextField = UITextField()

    @IBInspectable
    public var maxLength: Int = 0

    @IBInspectable
    public var title: String? {
        set {
            self.set(text: title)
        }
        get {
            return self.getText()
        }
    }

    @IBInspectable
    public var placeHolder: String? {
        set {
            self.set(placeholder: placeHolder)
        }
        get {
            return self.getPlaceholder()
        }
    }

    @IBInspectable
    public var format: Int {
        set {
            self.set(format: TextFormat.init(rawValue: format) ?? .none)
        }
        get {
            return self.getFormat().hashValue
        }
    }

    private var initialPlaceHolder: String?

    private var innerFormat: TextFormat = .none
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 58.0)
    }

    let placeholderLabel: UILabel = UILabel()

    override func postInit() {
        self.addSubview(textField)
        self.addSubview(placeholderLabel)
        
        textField.delegate = self
        self.setupTextFieldConstraints()
        self.setupLabelConstraints()
    }
    
    private func setupTextFieldConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: placeholderLabel.bottomAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func setupLabelConstraints() {
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        placeholderLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        placeholderLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        placeholderLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let oldText = textField.text, let textRange = Range(range, in: oldText) else {
            return true
        }

        if maxLength > 0 {
            let newLength = (oldText.count - range.length) + string.count

            guard newLength <= maxLength else {
                return false
            }
        }

        let updatedText = oldText.replacingCharacters(in: textRange, with: string)

        do {
            let textWithoutFormat = try remove(format: self.innerFormat, to: updatedText)
            textField.text = try apply(format: self.innerFormat, to: textWithoutFormat)
            return false
        } catch {
            return false
        }
    }

    public func set(inputType: UIKeyboardType) {
        self.textField.keyboardType = inputType
    }

    public func getInputType() -> UIKeyboardType? {
        return self.textField.keyboardType
    }

    public func set(placeholder: String?) {
        self.initialPlaceHolder = placeholder
        self.placeholderLabel.text = placeholder
        self.placeholderLabel.textColor = UIColor.gray
    }

    public func getPlaceholder() -> String? {
        return self.initialPlaceHolder
    }

    public func set(text: String?) {
        self.textField.text = text
    }

    public func getText() -> String? {
        return self.textField.text
    }

    public func set(maxLength: Int) {
        if maxLength > 0 {
            self.maxLength = maxLength
        }
    }

    public func getMaxLength() -> Int {
        return self.maxLength
    }

    public func set(format: TextFormat) {
        self.innerFormat = format
    }

    public func getFormat() -> TextFormat {
        return self.innerFormat
    }

    public func set(font: UIFont?) {
        self.textField.font = font
    }

    public func getFont() -> UIFont? {
        return self.textField.font
    }

    public func set(textColor: UIColor?) {
        self.textField.textColor = textColor
    }

    public func getTextColor() -> UIColor? {
        return self.textField.textColor
    }

    public func getUnformattedText() -> String? {
        guard let textWithFormat = self.textField.text else {
            return nil
        }

        do {
            return try self.remove(format: self.innerFormat, to: textWithFormat)
        } catch {
            return nil
        }
    }

    public override func show(error: FormFieldErrorType) {
        self.placeholderLabel.text = error.description
        self.placeholderLabel.textColor = UIColor.red
    }

    public override func clearError() {
        self.placeholderLabel.text = self.initialPlaceHolder
        self.placeholderLabel.textColor = UIColor.gray
    }

    internal override func validateContent() -> ValidationResult {
        guard let text = self.getText(), !text.isEmpty else {
            return ValidationResult(isValid: false, error: FormFieldError.emptyField)
        }

        return ValidationResult(isValid: true)
    }

    override func getValue() -> String? {
        return getText()
    }
}
