//
//  EmeraldTextFieldPicker.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 18/01/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct EmeraldTextFieldPicker: UIViewRepresentable {
    private let textField = UITextField()
    private let pickerView = UIPickerView()
    private let helper = EmeraldTextFieldPickerHelper()
    
    private var placeholder: String?
    @State private var selectedIndex: Int?
    @Binding private var data: [Selectable]
    @Binding private var lastSelectedIndex: Int?
    @Binding private var isEditing: Bool
    
    init(data: Binding<[Selectable]>,
         placeholder: String?,
         lastSelectedIndex: Binding<Int?>,
         isEditing: Binding<Bool>) {
        self._data = data
        self.placeholder = placeholder
        self._lastSelectedIndex = lastSelectedIndex
        self._isEditing = isEditing
    }
    
    func makeUIView(context: Context) -> UITextField {
        self.setupDataPicker(context: context)
        self.setupTextField()
        self.setupToolbar()
        
        self.helper.doneButtonTapped = {
            if self.selectedIndex != nil {
                self.lastSelectedIndex = selectedIndex
            }
            self.textField.resignFirstResponder()
        }
        
        return self.textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if let lastSelectedIndex = self.lastSelectedIndex {
            uiView.text = self.data[lastSelectedIndex].getSelectableText()
        }
        uiView.placeholder = (self.isEditing && self.lastSelectedIndex == nil) ? self.placeholder : nil
    }
    
    func makeCoordinator() -> EmeraldTextFieldPickerCoordinator {
        return EmeraldTextFieldPickerCoordinator(data: self.$data,
                                                 didSelectedItem: { index in
            self.selectedIndex = index
        }, isEditing: { isEditing in
            if self.selectedIndex == nil {
                self.selectedIndex = 0
            }
            self.isEditing = isEditing
        })
    }
    
    private func setupTextField() {
        self.textField.inputView = self.pickerView
        self.textField.font = Typography(size: .h5, weight: .semibold).uiFont
        self.textField.adjustsFontSizeToFitWidth = true
        self.textField.setContentCompressionResistancePriority(.defaultLow,
                                                               for: .horizontal)
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        let doneButton = UIBarButtonItem(title: Constants.Configuration.done,
                                         style: .plain,
                                         target: self.helper,
                                         action: #selector(self.helper.doneButtonAction))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        self.textField.inputAccessoryView = toolbar
    }
    
    private func setupDataPicker(context: Context) {
        self.textField.delegate = context.coordinator
        self.pickerView.delegate = context.coordinator
        self.pickerView.dataSource = context.coordinator
    }
}
