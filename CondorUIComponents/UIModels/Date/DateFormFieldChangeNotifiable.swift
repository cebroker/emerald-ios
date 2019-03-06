//
//  DateFormFieldChangeNotifiable.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 3/6/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

protocol DateFormFieldChangeNotifiable: class {
    func onSelected(dateString: String, date: Date, from datePicker: DateFormField)
    func onDoneButtonPressed(from datePicker: DateFormField)
}

extension DateFormFieldChangeNotifiable {
    func onDoneButtonPressed(from datePicker: DateFormField) {
        // Method intentionally left in blank
    }
}
