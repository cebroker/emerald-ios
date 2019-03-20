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
}

extension FormStackView: FormStackViewConfigurable {
    
    public func createDateFormField(placeholder: String) -> DateFormField? {
        let x = DateFormField()
        defaultSetup(textFormField: x, with: placeholder)
        return x
    }
    
    public func createSelectorFormField(placeholder: String) -> SelectorFormField? {
        let x = SelectorFormField()
        defaultSetup(textFormField: x, with: placeholder)
        return x
    }
    
    public func createTextSelectionField(placeholder: String) -> TextSelectionFormField? {
        let x = TextSelectionFormField()
        defaultSetup(textFormField: x, with: placeholder)
        return x
    }
    
    public func createTextRegexFormField(placeholder: String) -> TextRegexFormField? {
        let x = TextRegexFormField()
        defaultSetup(textFormField: x, with: placeholder)
        return x
    }
    
    public func createTextFormField(placeholder: String) -> TextFormField? {
        let x = TextFormField()
        defaultSetup(textFormField: x, with: placeholder)
        return x
    }
    
    private func defaultSetup(textFormField: TextFormField, with placeholder: String) {
        textFormField.set(placeholder: placeholder)
//        textFormField.heightAnchor.constraint(equalToConstant: 58).isActive = true
        self.fields.append(textFormField)
    }
    
    public func reloadFields() {
        self.removeAllArrangedSubviews()
        fields.forEach {
            self.addArrangedSubview($0)
        }
    }
    
    private func setupDefaultAutoLayout(to view: UIView){
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
