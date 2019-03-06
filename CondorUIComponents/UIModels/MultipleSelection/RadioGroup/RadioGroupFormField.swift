//
//  RadioGroupFormField.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

protocol RadioGroupFormFieldProtocol: MultipleSelectionFormFieldProtocol {
    
}

protocol TestableRadioGroupFormFieldProtocol {
    func select(option: Selectable)
}

class RadioGroupFormField: MultipleSelectionFormField, RadioGroupFormFieldProtocol, TestableRadioGroupFormFieldProtocol {
    private var selectedOption: Selectable?
    
    func select(option: Selectable) {
        self.selectedOption = option
    }
    
    override func validateContent() -> ValidationResult {
        guard let _ = self.selectedOption else {
            return ValidationResult(isValid: false, error: FormFieldError.emptyField)
        }
        
        return ValidationResult(isValid: true)
    }
    
    override func onItemClicked(title: String?, from item: MultipleSelectionItem) {
        super.onItemClicked(title: title, from: item)
        
        guard let radioButtons = self.stackView?.arrangedSubviews as? [MultipleSelectionItemProtocol] else {
            return
        }
        
        radioButtons.forEach {
            $0.set(status: false)
        }
        item.set(status: true)
        
        selectedOption = data?.first {
            $0.getSelectableText() == title
        }
        
        listener?.onItemClicked(title: title, from: item)
    }
}
