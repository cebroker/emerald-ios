//
//  EmeraldDateFieldView.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 4/12/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public class EmeraldDateFieldView: EmeraldTextFieldView {

    public var emeraldDateField: EmeraldDateField = EmeraldDateField()
    override public var textField: EmeraldTextField {
        get {
            return emeraldDateField
        }
        set {
            emeraldDateField = newValue as! EmeraldDateField
        }
    }

    public var errorMessages: EmeraldDateField.ErrorMessages {
        get {
            return self.emeraldDateField.errorMessages
        }
        set { }
    }

    public func set(selectedDate: Date) {
        self.emeraldDateField.set(selectedDate: selectedDate)
    }

    public func set(day: Int, month: Int, year: Int) {
        self.emeraldDateField.set(day: day, month: month, year: year)
    }

    public func set(hour: Int, minute: Int) {
        self.emeraldDateField.set(hour: hour, minute: minute)
    }

    public func set(notifiable: EmeraldDateFieldChangeNotifiable?) {
        self.emeraldDateField.set(notifiable: notifiable)
    }

    public func set(dateFormat: String) {
        self.emeraldDateField.set(dateFormat: dateFormat)
    }

    public func getDate(from string: String) -> Date? {
        self.emeraldDateField.getDate(from: string)
    }

    public func set(minimumDate: Date?) {
        self.emeraldDateField.set(minimumDate: minimumDate)
    }

    public func getMinimumDate() -> Date? {
        self.emeraldDateField.getMaximumDate()
    }

    public func set(maximumDate: Date?) {
        self.emeraldDateField.set(minimumDate: maximumDate)
    }

    public func getMaximumDate() -> Date? {
        self.emeraldDateField.getMaximumDate()
    }

    public func forbidDatesPreviousThanToday() {
        self.emeraldDateField.forbidDatesPreviousThanToday()
    }

    public func allowDatesPreviousThanToday() {
        self.emeraldDateField.allowDatesPreviousThanToday()
    }
    public func forbidDatesLaterThanToday() {
        self.emeraldDateField.forbidDatesLaterThanToday()
    }
    public func allowDatesLaterThanToday() {
        self.emeraldDateField.allowDatesLaterThanToday()
    }

    public func setDependantField(with dateField: EmeraldDateFieldType) {
        self.emeraldDateField.setDependantField(with: dateField)
    }
    
    public func openPickerDate() {
        self.emeraldDateField.openPicker()
    }
}
