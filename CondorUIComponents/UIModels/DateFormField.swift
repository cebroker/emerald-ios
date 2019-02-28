//
//  DateFormField.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

protocol DateFormFieldProtocol: TextFormFieldProtocol {
    func set(listener: DateFormFieldListener)
    func set(minimumDate: Date)
    func set(maximumDate: Date)
    func areDatesPreviousThanTodayAllowed(_ state: Bool)
    func areDatesLaterThanTodayAllowed(_ state: Bool)
    func set(format: String)
}

protocol TestableDateFormFieldProtocol: TestableTextFormFieldProtocol {
    func set(date: Date)
    func set(day: Int, month: Int, year: Int)
    func set(hour: Int, minute: Int)
    func setMinimum(day: Int, month: Int, year: Int)
    func setMaximum(day: Int, month: Int, year: Int)
}

protocol DateFormFieldListener: class {
    func onSelected(dateString: String, date: Date, from datePicker: DateFormField)
    func onDoneButtonPressed(from datePicker: DateFormField)
}

extension DateFormFieldListener {
    func onDoneButtonPressed(from datePicker: DateFormField) {
        // Method intentionally left in blank
    }
}

class DateFormField: TextFormField, DateFormFieldProtocol, TestableDateFormFieldProtocol {
    
    private weak var listener: DateFormFieldListener?
    
    private var pickerView: UIDatePicker = UIDatePicker()
    
    private let toolbar: UIToolbar = UIToolbar()
    
    private let previousDatesAllowed: Bool = true
    
    private var date: Date?
    
    private var dateFormatter: DateFormatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func validateContent() -> ValidationResult {
        guard let text = self.text, !text.isEmpty, let date = self.date else {
            return ValidationResult(isValid: false, error: FormFieldError.emptyField)
        }
        
        if let minimumDate = pickerView.minimumDate {
            guard date >= minimumDate else {
                return ValidationResult(isValid: false, error: DateFormFieldError.lowerThanMinimumDate)
            }
        }
        
        if let maximumDate = pickerView.maximumDate {
            guard date <= maximumDate else {
                return ValidationResult(isValid: false, error: DateFormFieldError.greaterThanMaximumDate)
            }
        }
        
        return ValidationResult(isValid: true)
    }
    
    func set(listener: DateFormFieldListener) {
        self.listener = listener
    }
    
    func set(minimumDate: Date) {
        pickerView.minimumDate = minimumDate
    }
    
    func set(maximumDate: Date) {
        pickerView.maximumDate = maximumDate
    }
    
    func set(date: Date) {
        self.date = date
        if let date = self.date {
            let formattedDate = dateFormatter.string(from: date)
            self.text = formattedDate
            listener?.onSelected(dateString: formattedDate, date: date, from: self)
        }
    }
    
    func set(day: Int, month: Int, year: Int) {
        if let date = getDateFrom(day: day, month: month, year: year) {
            self.set(date: date)
        }
    }
    
    func setMinimum(day: Int, month: Int, year: Int) {
        if let date = getDateFrom(day: day, month: month, year: year) {
            self.pickerView.minimumDate = date
        }
    }
    
    func setMaximum(day: Int, month: Int, year: Int) {
        if let date = getDateFrom(day: day, month: month, year: year) {
            self.pickerView.maximumDate = date
        }
    }
    
    func set(hour: Int, minute: Int) {
        if let date = getDateFrom(hour: hour, minute: minute) {
            self.set(date: date)
        }
    }
    
    func areDatesPreviousThanTodayAllowed(_ state: Bool) {
        if !state {
            self.pickerView.minimumDate = Date()
        } else {
            self.pickerView.minimumDate = nil
        }
    }
    
    func areDatesLaterThanTodayAllowed(_ state: Bool) {
        if !state {
            self.pickerView.maximumDate = Date()
        } else {
            self.pickerView.maximumDate = nil
        }
    }
    
    func set(format: String) {
        self.dateFormatter.dateFormat = format
    }
    
    override func commonInit() {
        super.commonInit()
        self.setupPickerView()
        self.setupToolbar()
        self.setupDefaultDateFormat()
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
        self.pickerView.datePickerMode = .date
        
        pickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        self.inputView = pickerView
    }
    
    private func setupDefaultDateFormat() {
        dateFormatter.locale = Locale(identifier: Constants.DateFormat.defaultLocale)
        dateFormatter.timeZone = TimeZone(abbreviation: Constants.DateFormat.defaultTimeZone)
        dateFormatter.dateFormat = Constants.DateFormat.defaultFormat
    }
    
    @objc private func datePickerValueChanged() {
        self.set(date: pickerView.date)
    }
    
    @objc private func onDoneButtonPressed() {
        self.set(date: pickerView.date)
        
        self.resignFirstResponder()
        toolbar.removeFromSuperview()
        pickerView.removeFromSuperview()
        
        listener?.onDoneButtonPressed(from: self)
    }
    
    private func getDateFrom(
        day: Int? = nil,
        month: Int? = nil,
        year: Int? = nil,
        hour: Int? = nil,
        minute: Int? = nil) -> Date? {
        
        var dateComponents = DateComponents()
        
        if let day = day {
            dateComponents.day = day
        }
        
        if let month = month {
            dateComponents.month = month
        }
        
        if let year = year {
            dateComponents.year = year
        }
        
        if let hour = hour {
            dateComponents.hour = hour
        }
        
        if let minute = minute {
            dateComponents.minute = minute
        }
        
        let userCalendar = Calendar.current
        
        return userCalendar.date(from: dateComponents)
    }
}

enum DateFormFieldError: FormFieldErrorProtocol {
    case lowerThanMinimumDate
    case greaterThanMaximumDate
}

extension DateFormFieldError {
    public var description: String? {
        switch self {
        case .lowerThanMinimumDate:
            return "Picked date is lower than minimum."
        case .greaterThanMaximumDate:
            return "Picked date is greater than maximum."
        }
    }
}
