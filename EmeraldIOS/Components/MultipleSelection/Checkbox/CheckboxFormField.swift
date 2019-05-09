//
//  CheckboxFormField.swift
//  EmeraldIOS
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public protocol TestableCheckboxFormFieldType {
    func select(option: Selectable, status: Bool)
}

public class CheckboxFormField: MultipleSelectionFormField, TestableCheckboxFormFieldType {
    
    public override func set(data: [Selectable]) {
        super.set(data: data)
        
        getChildren()?.forEach {
            $0.setSquareShape(true)
        }
    }
    
    public func select(option: Selectable, status: Bool) {
        if let existingOption =  getChildren()?.first(where: {
            $0.getTitle() == option.getSelectableText()
        }) {
            existingOption.set(status: status)
        }
    }
}
