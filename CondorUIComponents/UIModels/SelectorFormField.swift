//
//  SelectorFormField.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public protocol Selectable {
    func getSelectableText() -> String
}

public protocol SelectorFormFieldProtocol: TextFormFieldProtocol {
    func set(listener: SelectorFormFieldListener)
    func set(data: [Selectable])
    func clearData()
    func getSelectedRow() -> Selectable?
    func set(selectedRow: Selectable)
}

public protocol SelectorFormFieldListener: class {
    func onSelected(row: Selectable, from selector: SelectorFormField)
    func onDoneButtonPressed(from selector: SelectorFormField)
}

public extension SelectorFormFieldListener {
    func onDoneButtonPressed(from selector: SelectorFormField) {
        // Method intentionally left in blank
    }
}

public class SelectorFormField: TextFormField, SelectorFormFieldProtocol {
    
    private struct InnerConstants {
        static let numberOfComponents = 1
    }
    
    private weak var listener: SelectorFormFieldListener?
    
    private var pickerView: UIPickerView = UIPickerView()
    
    private var toolbar: UIToolbar = UIToolbar()
    
    private var data: [Selectable] = []
    
    private var selectedRow: Selectable?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override func validateContent() -> ValidationResult {
        guard let text = self.text, !text.isEmpty else {
            return ValidationResult(isValid: false, error: FormFieldError.emptyField)
        }
        
        guard let selectedRow = self.selectedRow, data.contains(where: { $0.getSelectableText() == selectedRow.getSelectableText()
        }) else {
            return ValidationResult(isValid: false, error: SelectorFormFieldError.missingSelectedValue)
        }
        
        guard data.contains(where: { $0.getSelectableText() == self.getValue() }) else {
            return ValidationResult(isValid: false, error: SelectorFormFieldError.uiSelectedValueMismatch)
        }
        
        return ValidationResult(isValid: true)
    }
    
    public func set(listener: SelectorFormFieldListener) {
        self.listener = listener
    }
    
    public func set(data: [Selectable]) {
        self.data = data
        self.selectedRow = data.first
        self.reloadInputViews()
    }
    
    public func clearData() {
        self.selectedRow = nil
        self.data = []
        self.reloadInputViews()
    }
    
    public func getSelectedRow() -> Selectable? {
        return selectedRow
    }
    
    public func set(selectedRow: Selectable) {
        self.selectedRow = selectedRow
        self.text = selectedRow.getSelectableText()
        listener?.onSelected(row: selectedRow, from: self)
    }
    
    @objc private func onDoneButtonPressed() {
        self.text = self.selectedRow?.getSelectableText()
        
        self.resignFirstResponder()
        toolbar.removeFromSuperview()
        pickerView.removeFromSuperview()
        
        if let selectedRow = self.selectedRow {
            listener?.onSelected(row: selectedRow, from: self)
        }
        
        listener?.onDoneButtonPressed(from: self)
    }
    
    override func commonInit() {
        super.commonInit()
        self.setupPickerView()
        self.setupToolbar()
    }
    
    private func setupToolbar() {
        self.toolbar.barStyle = UIBarStyle.default
        self.toolbar.isTranslucent = true
        self.toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonPressed))
        self.toolbar.setItems([doneButton], animated: false)
        self.toolbar.isUserInteractionEnabled = true
        
        self.inputAccessoryView = toolbar
    }
    
    private func setupPickerView() {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.inputView = pickerView
    }
}

extension SelectorFormField: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return InnerConstants.numberOfComponents
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row].getSelectableText()
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.set(selectedRow: data[row])
    }
}

public enum SelectorFormFieldError: FormFieldErrorProtocol {
    case missingSelectedValue
    case uiSelectedValueMismatch
}

public extension SelectorFormFieldError {
    public var description: String? {
        switch self {
        case .missingSelectedValue:
            return "Missing selected value."
        case .uiSelectedValueMismatch:
            return "Tthe text showed in UI does not match any selectable."
        }
    }
}
