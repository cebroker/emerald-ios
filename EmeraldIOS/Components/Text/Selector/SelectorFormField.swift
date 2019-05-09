////
////  SelectorFormField.swift
////  EmeraldIOS
////
////  Created by Luis David Goyes Garces on 2/28/19.
////  Copyright © 2019 Condor Labs. All rights reserved.
////
//
//import UIKit
//
//public protocol SelectorFormFieldType: TextFormFieldType {
//    func set(notifiable: SelectorFormFieldChangeNotifiable?)
//    func set(data: [Selectable])
//    func clearData()
//    func getSelectedRow() -> Selectable?
//    func set(selectedRow: Selectable)
//}
//
//public class SelectorFormField: TextFormField, SelectorFormFieldType, UIPickerViewDelegate, UIPickerViewDataSource {
//
//    private struct InnerConstants {
//        static let numberOfComponents = 1
//        static let dropdownIconName = "./dropdownicon.png"
//    }
//
//    private weak var notifiable: SelectorFormFieldChangeNotifiable?
//
//    private var pickerView: UIPickerView = UIPickerView()
//
//    private var toolbar: UIToolbar = UIToolbar()
//
//    private var data: [Selectable] = []
//
//    private var selectedRow: Selectable?
//
//    private var dropdownIcon: UIImage?
//
//    public required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    public override init() {
//        super.init()
//    }
//
//    override func validateContent() -> ValidationResult {
//        guard let text = self.getValue(), !text.isEmpty else {
//            return ValidationResult(isValid: false, error: FormFieldError.emptyField)
//        }
//
//        guard let selectedRow = self.selectedRow, data.contains(where: { $0.getSelectableText() == selectedRow.getSelectableText()
//        }) else {
//            return ValidationResult(isValid: false, error: SelectorFormFieldError.missingSelectedValue)
//        }
//
//        guard data.contains(where: { $0.getSelectableText() == self.getValue() }) else {
//            return ValidationResult(isValid: false, error: SelectorFormFieldError.uiSelectedValueMismatch)
//        }
//
//        return ValidationResult(isValid: true)
//    }
//
//    public func set(notifiable: SelectorFormFieldChangeNotifiable?) {
//        self.notifiable = notifiable
//    }
//
//    public func set(data: [Selectable]) {
//        self.data = data
//        self.selectedRow = data.first
//        self.reloadInputViews()
//    }
//
//    public func clearData() {
//        self.selectedRow = nil
//        self.data = []
//        self.reloadInputViews()
//    }
//
//    public func getSelectedRow() -> Selectable? {
//        return selectedRow
//    }
//
//    public func set(selectedRow: Selectable) {
//        self.selectedRow = selectedRow
//        self.textField.text = selectedRow.getSelectableText()
//        notifiable?.onSelected(row: selectedRow, from: self)
//    }
//
//    @objc private func onDoneButtonPressed() {
//        self.textField.text = self.selectedRow?.getSelectableText()
//
//        self.textField.resignFirstResponder()
//        toolbar.removeFromSuperview()
//        pickerView.removeFromSuperview()
//
//        if let selectedRow = self.selectedRow {
//            notifiable?.onSelected(row: selectedRow, from: self)
//        }
//
//        notifiable?.onDoneButtonPressed(from: self)
//    }
//
//    override func postInit() {
//        super.postInit()
//        self.setupPickerView()
//        self.setupToolbar()
//        self.addDropdownIcon()
//    }
//
//    private func setupToolbar() {
//        self.toolbar.barStyle = UIBarStyle.default
//        self.toolbar.isTranslucent = true
//        self.toolbar.sizeToFit()
//
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonPressed))
//        self.toolbar.setItems([flexibleSpace, doneButton], animated: false)
//        self.toolbar.isUserInteractionEnabled = true
//
//        self.textField.inputAccessoryView = toolbar
//    }
//
//    private func addDropdownIcon() {
//        self.dropdownIcon = UIImage(named: InnerConstants.dropdownIconName, in: Bundle(for: ClassBundle.self), compatibleWith: nil)
//
//        guard let image = self.dropdownIcon else {
//            return
//        }
//
//        let imageView = UIImageView(image: image)
//
//        self.textField.addSubview(imageView)
//
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//
//        imageView
//            .rightAnchor
//            .constraint(
//                equalTo: self.rightAnchor,
//                constant: -24)
//            .isActive = true
//
//        imageView
//            .heightAnchor
//            .constraint(equalToConstant: 12)
//            .isActive = true
//
//        imageView
//            .widthAnchor
//            .constraint(equalToConstant: 20)
//            .isActive = true
//
//        imageView
//            .centerYAnchor
//            .constraint(equalTo: self.centerYAnchor)
//            .isActive = true
//    }
//
//    private func setupPickerView() {
//        self.pickerView.delegate = self
//        self.pickerView.dataSource = self
//
//        self.textField.inputView = pickerView
//    }
//
//    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return InnerConstants.numberOfComponents
//    }
//
//    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return data.count
//    }
//
//    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return data[row].getSelectableText()
//    }
//
//    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        self.set(selectedRow: data[row])
//    }
//}
