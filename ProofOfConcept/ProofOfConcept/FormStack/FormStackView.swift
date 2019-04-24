//
//  FormStackView.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 3/20/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit
import CondorUIComponentsIOS

public class FormStackView: UIStackView {

    private var fields: [UIView] = []

    private var defaultSingleLineFrame: CGRect?

    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.spacing = 30
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.alignment = .fill
    }

    func areFieldsValid() {
        fields
            .filter { $0 is FormFieldType<String> }
            .map { $0 as? FormFieldType<String> }
            .forEach {
                guard let validationResult = $0?.isValid() else {
                    return
                }

                if !validationResult.isValid,
                    let error = validationResult.error {
                    $0?.show(error: error)
                } else {
                    $0?.clearError()
                }
        }
    }
}

extension FormStackView: FormStackViewConfigurable {

    public func createDateFormField(placeholder: String) -> DateFormField? {
        let field = DateFormField()
        defaultSetup(textFormField: field, with: placeholder)
        return field
    }

    public func createSelectorFormField(placeholder: String) -> SelectorFormField? {
        let field = SelectorFormField(dropdownIcon: UIImage(named: "dropdownicon"))
        defaultSetup(textFormField: field, with: placeholder)
        return field
    }

    public func createTextSelectionField(placeholder: String) -> TextSelectionFormField? {
        let field = TextSelectionFormField()
        defaultSetup(textFormField: field, with: placeholder)
        return field
    }

    public func createTextRegexFormField(placeholder: String) -> TextRegexFormField? {
        let field = TextRegexFormField()
        defaultSetup(textFormField: field, with: placeholder)
        return field
    }

    public func createTextFormField(placeholder: String) -> TextFormField? {
        let field = TextFormField()
        defaultSetup(textFormField: field, with: placeholder)
        return field
    }

    public func createFormButton(with title: String) -> FormButton? {
        let button = FormButton()
        button.setTitle(title, for: .normal)
        fields.append(button)
        return button
    }

    private func defaultSetup(textFormField: TextFormField, with placeholder: String) {
        textFormField.set(placeholder: placeholder)
        self.fields.append(textFormField)
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
