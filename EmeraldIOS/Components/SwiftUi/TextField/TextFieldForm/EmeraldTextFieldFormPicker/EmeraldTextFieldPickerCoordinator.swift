//
//  EmeraldTextFieldPickerCoordinator.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 18/01/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
final class EmeraldTextFieldPickerCoordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @Binding private var data: [Selectable]
    private var didSelectedItem: ((Int) -> Void)?
    private var isEditing: ((Bool) -> Void)?
    
    init(data: Binding<[Selectable]>, didSelectedItem: ((Int) -> Void)? = nil, isEditing: ((Bool) -> Void)? = nil) {
        self._data = data
        self.didSelectedItem = didSelectedItem
        self.isEditing = isEditing
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.data[row].getSelectableText()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.didSelectedItem?(row)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.isEditing?(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.isEditing?(false)
    }
}
