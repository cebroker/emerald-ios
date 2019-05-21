//
//  EmeraldStackView.swift
//  EmeraldIOS
//
//  Created by Luis David Goyes Garces on 4/24/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public class EmeraldStackView: UIStackView {
    
    public var fields: [UIView] = []
    
    private var defaultSingleLineFrame: CGRect?
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        self.spacing = 30
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.alignment = .fill
    }
    
    public func areFieldsValid() {
        fields
            .filter { $0 is EmeraldTextFieldType }
            .map { $0 as? EmeraldTextFieldType }
            .forEach {
                guard let validationResult = $0?.isValid() else {
                    return
                }
                
                switch validationResult {
                    case .success(_):
                        $0?.clearError()
                    case .failure(let error):
                        guard let error = error as? FormFieldErrorType else {
                            return
                        }
                        $0?.show(error: error)
                }
        }
    }
}

extension EmeraldStackView: EmeraldStackViewConfigurable {
    
    public func createLabel() -> EmeraldLabel? {
        let field = EmeraldLabel()
        defaultSetup(anyView: field)
        return field
    }
    
    public func createDateFormField(placeholder: String) -> EmeraldDateField? {
        let field = EmeraldDateField()
        defaultSetup(textFormField: field, with: placeholder)
        return field
    }

    public func createEmeraldSelectorFormField(placeholder: String) -> EmeraldSelectorField? {
        let field = EmeraldSelectorField()
        defaultSetup(textFormField: field, with: placeholder)
        return field
    }

    public func createEmeraldTextDependantField(placeholder: String) -> EmeraldTextDependantField? {
        let field = EmeraldTextDependantField()
        defaultSetup(textFormField: field, with: placeholder)
        return field
    }

    public func createEmeraldRegexFormField(placeholder: String) -> EmeraldRegexTextField? {
        let field = EmeraldRegexTextField()
        defaultSetup(textFormField: field, with: placeholder)
        return field
    }
    
    public func createEmeraldTextField(placeholder: String) -> EmeraldTextField? {
        let field = EmeraldTextField()
        defaultSetup(textFormField: field, with: placeholder)
        return field
    }
    
    public func createButton(with title: String) -> EmeraldButton? {
        let button = EmeraldButton()
        button.setTitle(title, for: .normal)
        fields.append(button)
        return button
    }
    
    private func defaultSetup(textFormField: EmeraldTextField, with placeholder: String) {
        textFormField.set(placeholder: placeholder)
        textFormField.themeStyle = EmeraldTextFieldStyle.formField.IBInspectable
        self.fields.append(textFormField)
    }
    
    private func defaultSetup(anyView: UIView) {
        self.fields.append(anyView)
    }
    
    public func reloadFields() {
        self.removeAllArrangedSubviews()
        fields.forEach {
            self.addArrangedSubview($0)
        }
    }
    
    private func setupDefaultAutoLayout(to view: UIView) {
        view.anchor(
            top: nil,
            left: self.leftAnchor,
            bottom: nil,
            right: self.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: -10,
            width: 0,
            height: 58)
    }
}
