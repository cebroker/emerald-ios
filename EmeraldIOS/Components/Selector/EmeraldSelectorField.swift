//
//  EmeraldSelectorField.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/9/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit
//EmeraldTextFieldStyle
public protocol EmeraldSelectorFieldType: EmeraldTextFormFieldType {
    func set(data: [Selectable])
    func clearData()
    func getSelectedRow() -> Selectable?
    func set(selectedRow: Selectable)
    func set(notifiable: EmeraldSelectorFieldChangeNotifiable?)
}

public class EmeraldSelectorField: EmeraldTextField, EmeraldSelectorFieldType, UIPickerViewDelegate, UIPickerViewDataSource {
    public func set(notifiable: EmeraldSelectorFieldChangeNotifiable?) {
        <#code#>
    }
    
    public func set(data: [Selectable]) {
        <#code#>
    }
    
    public func clearData() {
        <#code#>
    }
    
    public func getSelectedRow() -> Selectable? {
        <#code#>
    }
    
    public func set(selectedRow: Selectable) {
        <#code#>
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        <#code#>
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
}
