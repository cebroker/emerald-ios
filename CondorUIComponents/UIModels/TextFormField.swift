//
//  TextFormField.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import MaterialComponents.MaterialTextFields

public protocol TextFormFieldProtocol: FormFieldProtocol {
    func set(title: String?)
    func set(maxLength: Int)
    func set(format: TextFormat)
    func getUnformattedText() -> String?
}

public protocol TestableTextFormFieldProtocol {
    func set(text: String?)
    func getText() -> String?
}

public class TextFormField: MDCTextField,
    TextFormFieldProtocol,
    TestableTextFormFieldProtocol,
TextFormatter {
    
    private struct InnerConstants {
        static let sequenceLenth: Int = 10
    }
    
    var title: String? = nil
    
    private var maxLength: Int = 0
    
    private var format: TextFormat = .none
    
    public var isRequired: Bool = true
    
    private var textFieldControllerFloating: MDCTextInputController?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit() {
        self.textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: self)
        self.delegate = self
    }
    
    public func isValid() -> ValidationResult {
        guard isRequired else {
            return ValidationResult(isValid: true)
        }
        
        return self.validateContent()
    }
    
    public func show(error: FormFieldErrorProtocol) {
        self.placeholder = error.description
    }
    
    public func clearError() {
        self.placeholder = title
    }
    
    public func set(maxLength: Int) {
        if maxLength > 0 {
            self.maxLength = maxLength
        }
    }
    
    func validateContent() -> ValidationResult {
        guard let text = self.text, !text.isEmpty else {
            return ValidationResult(isValid: false, error: FormFieldError.emptyField)
        }
        
        return ValidationResult(isValid: true)
    }
    
    public func set(text: String?) {
        self.text = text
    }
    
    public func set(title: String?) {
        self.title = title
        self.placeholder = title
    }
    
    public func getText() -> String? {
        return self.text
    }
    
    public func getUnformattedText() -> String? {
        guard let textWithFormat = self.text else {
            return nil
        }
        
        do {
            return try self.remove(format: self.format, to: textWithFormat)
        } catch {
            return nil
        }
    }
    
    public func set(format: TextFormat) {
        self.format = format
    }
}

extension TextFormField: UITextFieldDelegate {
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
            let textWithoutFormat = try remove(format: self.format, to: updatedText)
            self.text = try apply(format: self.format, to: textWithoutFormat)
            return false
        } catch {
            return false
        }
    }
}
