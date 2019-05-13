//
//  EmeraldSelectorField.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/9/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol EmeraldSelectorFieldType: EmeraldTextFormFieldType {
    func set(data: [Selectable])
    func clearData()
    func getSelectedRow() -> Selectable?
    func set(selectedRow: Selectable)
    func set(notifiable: EmeraldSelectorFieldChangeNotifiable?)
}

@IBDesignable
public class EmeraldSelectorField: EmeraldTextField, EmeraldSelectorFieldType, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private struct InnerConstants {
        static let numberOfComponents = 1
        static let dropdownIconName = #imageLiteral(resourceName: "dropdownicon")
    }
    
    private weak var notifiable: EmeraldSelectorFieldChangeNotifiable?
    private lazy var pickerView: UIPickerView = UIPickerView()
    private lazy var toolbar: UIToolbar = UIToolbar()
    private lazy var data: [Selectable] = []
    private var selectedRow: Selectable?
    private var dropdownIcon: UIImage?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupPickerView()
        self.setupToolbar()
        self.addDropdownIcon()
    }
    
    public func set(notifiable: EmeraldSelectorFieldChangeNotifiable?) {
        self.notifiable = notifiable
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
        notifiable?.onSelected(row: selectedRow, from: self)
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return InnerConstants.numberOfComponents
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    override func validateContent() -> ValidationResult {
        guard let text = self.getValue(), !text.isEmpty else {
            return ValidationResult(isValid: false, error: FormFieldError.emptyField)
        }
        
        guard let selectedRow = self.selectedRow, data.contains(where: { $0.getSelectableText() == selectedRow.getSelectableText()
        }) else {
            return ValidationResult(isValid: false, error: EmeraldSelectorFormFieldError.missingSelectedValue)
        }
        
        guard data.contains(where: { $0.getSelectableText() == self.getValue() }) else {
            return ValidationResult(isValid: false, error: EmeraldSelectorFormFieldError.uiSelectedValueMismatch)
        }
        
        return ValidationResult(isValid: true)
    }
    
    private func setupToolbar() {
        self.toolbar.barStyle = UIBarStyle.default
        self.toolbar.isTranslucent = true
        self.toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonPressed))
        self.toolbar.setItems([flexibleSpace, doneButton], animated: false)
        self.toolbar.isUserInteractionEnabled = true
        self.inputAccessoryView = toolbar
    }
    
    private func addDropdownIcon() {
        self.dropdownIcon = InnerConstants.dropdownIconName
        
        guard let image = self.dropdownIcon else {
            return
        }
        
        let imageView = UIImageView(image: image)
        
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView
            .rightAnchor
            .constraint(
                equalTo: self.rightAnchor,
                constant: -24)
            .isActive = true
        
        imageView
            .heightAnchor
            .constraint(equalToConstant: 12)
            .isActive = true
        
        imageView
            .widthAnchor
            .constraint(equalToConstant: 20)
            .isActive = true
        
        imageView
            .centerYAnchor
            .constraint(equalTo: self.centerYAnchor)
            .isActive = true
    }
    
    private func setupPickerView() {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.inputView = pickerView
    }
    
    @objc private func onDoneButtonPressed() {
        self.text = self.selectedRow?.getSelectableText()
        self.resignFirstResponder()
        toolbar.removeFromSuperview()
        pickerView.removeFromSuperview()
        
        if let selectedRow = self.selectedRow {
            notifiable?.onSelected(row: selectedRow, from: self)
        }
        
        notifiable?.onDoneButtonPressed(from: self)
    }
}
