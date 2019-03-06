//
//  CheckboxFormField.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public protocol TestableCheckboxFormFieldProtocol {
    func select(option: Selectable, status: Bool)
}

public class CheckboxFormField: MultipleSelectionFormField, TestableCheckboxFormFieldProtocol {
    
    public override func set(data: [Selectable]) {
        super.set(data: data)
        
        guard let checkboxes = getChildren() else {
            return
        }
        
        checkboxes.forEach {
            $0.setSquareShape(true)
        }
    }
    
    public func select(option: Selectable, status: Bool) {
        guard let checkboxes = getChildren() else {
            return
        }
        
        if let existingOption = checkboxes.first(where: {
            $0.getTitle() == option.getSelectableText()
        }) {
            existingOption.set(status: status)
        }
    }
}
