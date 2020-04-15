//
//  EmeraldSelectorField.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/9/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol EmeraldSelectorFieldType: EmeraldTextFieldType {
    func set(data: [Selectable])
    func clearData()
    func getSelectedRow() -> Selectable?
    func set(selectedRow: Selectable)
    func set(notifiable: EmeraldSelectorFieldChangeNotifiable?)
    func set(emptyOptionText: String)
}

@IBDesignable
public class EmeraldSelectorField: EmeraldTextField, EmeraldSelectorFieldType, UIPickerViewDelegate, UIPickerViewDataSource {
    private struct InnerConstants {
        static let numberOfComponents = 1
        static let dropdownIconName = "arrow_down_icon.png"
    }

    private class EmptySelectable: Selectable {
        private var text: String = Constants.Values.select

        func getSelectableText() -> String {
            return text
        }

        func set(text: String) {
            self.text = text
        }
    }

    private weak var notifiable: EmeraldSelectorFieldChangeNotifiable?
    private lazy var pickerView: UIPickerView = UIPickerView()
    private lazy var toolbar: UIToolbar = UIToolbar()
    private lazy var data: [Selectable] = []
    private var selectedRow: Selectable?
    private var dropdownIcon: UIImage?
    private var emptySelectable = EmptySelectable()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareForInterfaceBuilder()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyTheme()
        delegate = self
        setupPickerView()
        setupToolbar()
        addDropdownIcon()
    }

    public func set(notifiable: EmeraldSelectorFieldChangeNotifiable?) {
        self.notifiable = notifiable
    }

    public func set(data: [Selectable]) {
        self.data = [emptySelectable] + data
        selectedRow = self.data.first
        reloadInputViews()
    }

    public func clearData() {
        selectedRow = nil
        setText(with: nil)
        set(selectedRow: emptySelectable)
        data = []
        reloadInputViews()
    }

    public func set(emptyOptionText: String) {
        emptySelectable.set(text: emptyOptionText)
    }

    public func getSelectedRow() -> Selectable? {
        return selectedRow
    }

    public func set(selectedRow: Selectable) {
        if selectedRow === emptySelectable {
            self.selectedRow = nil
        } else {
            self.selectedRow = selectedRow
        }
        setText(with: self.selectedRow?.getSelectableText())
        pickerView.selectRow(data.firstIndex(where: { $0.getSelectableText() == selectedRow.getSelectableText() }) ?? 0, inComponent: 0, animated: true)
        notifiable?.onSelected(row: selectedRow, from: self)
    }

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
        set(selectedRow: data[row])
    }

    override func validateContent() -> Result<Bool, Error> {
        guard let text = getValue(), !text.isEmpty else {
            return .failure(FormFieldError.emptyField)
        }

        guard let selectedRow = self.selectedRow, data.contains(where: { $0.getSelectableText() == selectedRow.getSelectableText()
        }) else {
            return .failure(EmeraldSelectorFieldError.missingSelectedValue)
        }

        guard data.contains(where: { $0.getSelectableText() == getValue() }) else {
            return .failure(EmeraldSelectorFieldError.uiSelectedValueMismatch)
        }

        return .success(true)
    }

    private func setupToolbar() {
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonPressed))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        inputAccessoryView = toolbar
    }

    private func addDropdownIcon() {
        dropdownIcon = UIImage(
            named: InnerConstants.dropdownIconName,
            in: Bundle(for: ClassBundle.self),
            compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)

        guard let image = dropdownIcon,
            subviews.count <= 2 else {
                return
        }

        let imageView = UIImageView(image: image)
        imageView.tintColor = EmeraldTheme.primaryColor
        addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView
            .rightAnchor
            .constraint(
                equalTo: rightAnchor,
                constant: -10)
            .isActive = true

        imageView
            .heightAnchor
            .constraint(equalToConstant: 30)
            .isActive = true

        imageView
            .widthAnchor
            .constraint(equalToConstant: 34)
            .isActive = true

        imageView
            .centerYAnchor
            .constraint(equalTo: centerYAnchor)
            .isActive = true
    }

    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        inputView = pickerView
    }

    private func shloulSetTextFirsTime() {
        if selectedRow?.getSelectableText() == Constants.Values.select {
            selectedRow = nil
        } else {
            text = selectedRow?.getSelectableText()
        }
    }

    @objc private func onDoneButtonPressed() {
        resignFirstResponder()
        toolbar.removeFromSuperview()
        shloulSetTextFirsTime()
        if let selectedRow = self.selectedRow {
            notifiable?.onSelected(row: selectedRow, from: self)
        }

        notifiable?.onDoneButtonPressed(from: self)
    }
}
