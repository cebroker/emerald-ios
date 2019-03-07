//
//  TextFormField.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import MaterialComponents.MaterialTextFields

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
}

@IBDesignable
public class TextFormField: FormFieldType<String>, TextFormFieldType, TextFormatter, UITextFieldDelegate {

    var textField: MDCTextField?

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

    private var textFieldControllerFloating: MDCTextInputController?

    private var initialPlaceHolder: String?

    private var innerFormat: TextFormat = .none

    required public init?(coder aDecoder: NSCoder) {
        self.textField = MDCTextField(coder: aDecoder)
        super.init(coder: aDecoder)
    }

    override public init(frame: CGRect) {
        self.textField = MDCTextField(frame: frame)
        super.init(frame: frame)
    }

    override func postInit() {
        guard let textField = self.textField else {
            return
        }

        self.addSubview(textField)
        self.textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: textField)
        textField.delegate = self
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

    public func set(placeholder: String?) {
        self.initialPlaceHolder = placeholder
        self.textField?.placeholder = placeholder
    }

    public func getPlaceholder() -> String? {
        return self.initialPlaceHolder
    }

    public func set(text: String?) {
        self.textField?.text = text
    }

    public func getText() -> String? {
        return self.textField?.text
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

    public func getUnformattedText() -> String? {
        guard let textWithFormat = self.textField?.text else {
            return nil
        }

        do {
            return try self.remove(format: self.innerFormat, to: textWithFormat)
        } catch {
            return nil
        }
    }

    public override func show(error: FormFieldErrorType) {
        self.textField?.placeholder = error.description
    }

    public override func clearError() {
        self.textField?.placeholder = self.initialPlaceHolder
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
