//
//  EmeraldTextFieldFormDate.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra Jimenez on 4/01/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct EmeraldTextFieldFormDate: View {
    private let hint: String?
    private let placeholder: String?
    private var errorText: String?
    @Binding private var text: String
    private let keyboardType: UIKeyboardType
    private let onEditingFinished: (() -> Void)?
    private let coordinator: EmeraldTextFieldFormDateCoordinatorType
    private var hasError: Bool =  false
    private var dateFormat: EmeraldIOS.TextFormat = .longDate
    
    @State private var isEditing: Bool = false
    private var isActive: Bool {
        self.isEditing || !self.text.isEmpty
    }
    
    public init(
        text: Binding<String>,
        hint: String? = nil,
        placeholder: String? = nil, 
        dateFormat: EmeraldIOS.TextFormat = .longDate,
        keyboardType: UIKeyboardType = .default,
        minDate: Date? = nil,
        maxDate: Date? = nil,
        onEditingFinished: (() -> Void)? = nil
    ) {
        self.placeholder = placeholder
        self.hint = hint
        self._text = text
        self.keyboardType = keyboardType
        self.onEditingFinished = onEditingFinished
        self.dateFormat = dateFormat
        
        self.coordinator = EmeraldTextFieldFormDateCoordinator(
            dateFormat: dateFormat,
            minimumDate: minDate,
            maximunDate: maxDate)
    }
    
    public var body: some View {
        EmeraldTextFieldFormContainer(
            text: $text,
            hint: hint,
            placeholder: placeholder,
            errorText: errorText,
            isEditing: _isEditing
        ) {
            HStack {
                TextField(isActive ? placeholder ?? Constants.Values.empty : Constants.Values.empty,
                          text: $text,
                          onEditingChanged: {
                    isEditing = $0
                }, onCommit: {
                    isEditing = false
                    onEditingFinished?()
                })
                    .multilineTextAlignment(.leading)
                    .keyboardType(keyboardType)
                    .onReceive(text.publisher.collect()) {
                        formatDate(String($0))
                    }
                Spacer()
                Button(action: openDatePicker,
                       label: calendarImage)
                    .yes(isEditing || !text.isEmpty) { view in
                        view.offset(y: -10)
                    }
            }
        }
                                      .hasError(hasError)
    }
    
    private func calendarImage() -> some View {
        Image(uiImage: UIImage(named: Constants.Icons.calendar,
                               in: Bundle(for: ClassBundle.self),
                               compatibleWith: nil) ??
              UIImage(systemName: Constants.Icons.systemCalendar)!)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(Constants.EmeraldSwiftUiTextField.primaryColor.suColor)
            .frame(
                width: Constants.EmeraldSwiftUiTextField.widthIcon,
                height: Constants.EmeraldSwiftUiTextField.widthIcon)
    }
    
    private func getPicker() -> EmeraldDatePickerAlertType {
        coordinator.getFormat() == .longDate ?
        EmeraldDatePickerAlert() :
        EmeraldShortDatePickerAlert()
    }
    
    func openDatePicker() {
        let datePicker = getPicker()
        
        if let minimumDate = coordinator.getMinimumDate() {
            datePicker.set(minimumDate: minimumDate)
        }
        
        if let maximumDate = coordinator.getMaximumDate() {
            datePicker.set(maximumDate: maximumDate)
        }
        let text = coordinator.fillYear(date: self.text)
        if let currentDate = coordinator.getDate(from: text) {
            datePicker.set(currentDateValue: currentDate)
        }
        
        datePicker.show(title: placeholder ?? Constants.Values.empty,
                        doneButtonTitle: Constants.Configuration.done,
                        cancelButtonTitle: Constants.Configuration.cancel,
                        datePickerMode: .date) { date in
            guard let date = date else {
                return
            }
            
            self.set(selectedDate: date)
        }
    }
    
    private func set(selectedDate: Date) {
        let formattedDate = coordinator.getString(from: selectedDate)
        DispatchQueue.main.async {
            text = formattedDate
        }
    }
    
    private func formatDate(_ text: String) {
        DispatchQueue.main.async {
            self.text = coordinator.formatText(text)
        }
    }
    
    public func hasError(_ hasError: Bool, errorText: String? = nil) -> Self {
        var view = self
        view.hasError = hasError
        view.errorText = errorText
        return view
    }
}

@available(iOS 13.0.0, *)
struct DateTextField_Previews: PreviewProvider {
    static var previews: some View {
        EmeraldTextFieldFormDate(text: .constant(""),
                                 dateFormat: .longDate)
    }
}
