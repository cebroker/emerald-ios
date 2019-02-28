//
//  CheckboxFormField.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public protocol CheckboxFormFieldProtocol: MultipleSelectionFormFieldProtocol {
    
}

public protocol TestableCheckboxFormFieldProtocol {
    func select(option: Selectable, status: Bool)
}

public class CheckboxFormField: MultipleSelectionFormField, CheckboxFormFieldProtocol, TestableCheckboxFormFieldProtocol {
    
    override public func set(data: [Selectable]) {
        super.set(data: data)
        
        guard let checkboxes = self.stackView?.arrangedSubviews as? [MultipleSelectionItemProtocol] else {
            return
        }
        
        checkboxes.forEach {
            $0.setSquareShape(true)
        }
    }
    
    public func select(option: Selectable, status: Bool) {
        guard let checkboxes = self.stackView?.arrangedSubviews as? [MultipleSelectionItemProtocol] else {
            return
        }
        
        if let existingOption = checkboxes.first(where: {
            $0.getTitle() == option.getSelectableText()
        }) {
            existingOption.set(status: status)
        }
    }
    
    override func validateContent() -> ValidationResult {
        guard
            let checkboxes = self.stackView?.arrangedSubviews as? [MultipleSelectionItemProtocol],
            let _ = checkboxes.first(where: {
                $0.getStatus() == true
            })
            else {
                return ValidationResult(isValid: false, error: FormFieldError.emptyField)
        }
        
        return ValidationResult(isValid: true)
    }
    
    override public func onItemClicked(title: String?, from item: MultipleSelectionItem) {
        super.onItemClicked(title: title, from: item)
        
        listener?.onItemClicked(title: title, from: item)
    }
}
