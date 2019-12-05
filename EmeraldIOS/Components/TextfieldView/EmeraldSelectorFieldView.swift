//
//  EmeraldSelectorFieldView.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 4/12/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public class EmeraldSelectorFieldView: BaseInputView {
    var emeraldSelectorField = EmeraldSelectorField()
    override var textField: EmeraldTextField {
        get {
            return emeraldSelectorField
        }
        set {
            emeraldSelectorField = newValue as! EmeraldSelectorField
        }
    }
    
    override func setupViews() {
         super.setupViews()
         self.setDelegate(self)
     }

    public func set(notifiable: EmeraldSelectorFieldChangeNotifiable?) {
        self.emeraldSelectorField.set(notifiable: notifiable)
    }

    public func set(data: [Selectable]) {
        self.emeraldSelectorField.set(data: data)
    }
    
    public func clearData() {
        self.emeraldSelectorField.clearData()
    }
    
    public func set(emptyOptionText: String) {
        self.emeraldSelectorField.set(emptyOptionText: emptyOptionText)
    }
    
    public func getSelectedRow() -> Selectable? {
        return self.emeraldSelectorField.getSelectedRow()
    }

    public func set(selectedRow: Selectable) {
        self.emeraldSelectorField.set(selectedRow: selectedRow)
    }
}

extension EmeraldSelectorFieldView: CustomEmeraldTextFieldDelegate {
    public func didEndEditing(textField: UITextField) {
        self.handleResult(with: self.textField.validateContent())
    }
}
