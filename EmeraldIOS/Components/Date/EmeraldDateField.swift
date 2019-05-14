//
//  EmeraldDateField.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/14/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public protocol EmeraldDateFieldType: EmeraldTextFieldType {
    func set(notifiable: EmeraldDateFieldChangeNotifiable?)
    func set(minimumDate: Date?)
    func getMinimumDate() -> Date?
    func set(maximumDate: Date?)
    func getMaximumDate() -> Date?
    func forbidDatesPreviousThanToday()
    func allowDatesPreviousThanToday()
    func forbidDatesLaterThanToday()
    func allowDatesLaterThanToday()
    func set(dateFormat: String)
}

public protocol EmeraldDateFieldTestableType {
    func set(selectedDate: Date)
    func set(day: Int, month: Int, year: Int)
    func set(hour: Int, minute: Int)
    func setMinimum(day: Int, month: Int, year: Int)
    func setMaximum(day: Int, month: Int, year: Int)
}

public class EmeraldDateField: EmeraldTextField, EmeraldDateFieldType, EmeraldDateFieldTestableType {
    
    private var selectedDate: Date?
    private lazy var dateFormatter: DateFormatter = DateFormatter()
    private weak var notifiable: EmeraldDateFieldChangeNotifiable?
    private lazy var pickerView: UIDatePicker = UIDatePicker()
    private lazy var toolbar: UIToolbar = UIToolbar()
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.configureDateField()
        self.setupPickerView()
        self.setupToolbar()
        self.setupDefaultDateFormat()
    }
    
    public func set(selectedDate: Date) {
        self.selectedDate = selectedDate
        let formattedDate = dateFormatter.string(from: selectedDate)
        self.text = formattedDate
        notifiable?.onSelected(dateString: formattedDate, date: selectedDate, from: self)
    }
    
    public func set(day: Int, month: Int, year: Int) {
        if let date = getDateFrom(day: day, month: month, year: year) {
            self.set(selectedDate: date)
        }
    }
    
    public func set(hour: Int, minute: Int) {
        if let date = getDateFrom(hour: hour, minute: minute) {
            self.set(selectedDate: date)
        }
    }
    
    public func setMinimum(day: Int, month: Int, year: Int) {
        if let date = getDateFrom(day: day, month: month, year: year) {
            self.pickerView.minimumDate = date
        }
    }
    
    public func setMaximum(day: Int, month: Int, year: Int) {
        if let date = getDateFrom(day: day, month: month, year: year) {
            self.pickerView.maximumDate = date
        }
    }
    
    public func set(notifiable: EmeraldDateFieldChangeNotifiable?) {
        self.notifiable = notifiable
    }
    
    public func set(minimumDate: Date?) {
        pickerView.minimumDate = minimumDate
    }
    
    public func getMinimumDate() -> Date? {
        return pickerView.minimumDate
    }
    
    public func set(maximumDate: Date?) {
        pickerView.maximumDate = maximumDate
    }
    
    public func getMaximumDate() -> Date? {
        return pickerView.maximumDate
    }
    
    public func forbidDatesPreviousThanToday() {
        self.pickerView.minimumDate = Date()
    }
    
    public func allowDatesPreviousThanToday() {
        self.pickerView.minimumDate = nil
    }
    
    public func forbidDatesLaterThanToday() {
        self.pickerView.maximumDate = Date()
    }
    
    public func allowDatesLaterThanToday() {
        self.pickerView.maximumDate = nil
    }
    
    public func set(dateFormat: String) {
        self.dateFormatter.dateFormat = dateFormat
    }
    
    override func validateContent() -> Result<Bool, Error> {
        guard let text = self.getValue(), !text.isEmpty, let date = self.selectedDate else {
            return .failure(FormFieldError.emptyField)
        }
        
        if let minimumDate = pickerView.minimumDate {
            guard date >= minimumDate else {
                return .failure(EmeraldDateFieldError.lowerThanMinimumDate)
            }
        }
        
        if let maximumDate = pickerView.maximumDate {
            guard date <= maximumDate else {
                return .failure(EmeraldDateFieldError.greaterThanMaximumDate)
            }
        }
        
        return .success(true)
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
    
    private func configureDateField() {
        self.set(format: .date)
    }
    
    private func setupPickerView() {
        self.pickerView.datePickerMode = .date
        
        pickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        //self.inputView = pickerView
    }
    
    @objc private func datePickerValueChanged() {
        self.set(selectedDate: pickerView.date)
    }
    
    @objc private func onDoneButtonPressed() {
        self.set(selectedDate: pickerView.date)
        
        self.resignFirstResponder()
        toolbar.removeFromSuperview()
        pickerView.removeFromSuperview()
        
        notifiable?.onDoneButtonPressed(from: self)
    }
    
    private func setupDefaultDateFormat() {
        dateFormatter.locale = Locale(identifier: Constants.DateFormat.defaultLocale)
        dateFormatter.timeZone = TimeZone(abbreviation: Constants.DateFormat.defaultTimeZone)
        dateFormatter.dateFormat = Constants.DateFormat.defaultFormat
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
        
        return Calendar.current.date(from: dateComponents)
    }
}
