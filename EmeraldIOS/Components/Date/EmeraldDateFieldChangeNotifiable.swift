//
//  EmeraldDateFieldChangeNotifiable.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/14/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol EmeraldDateFieldChangeNotifiable: class {
    func onSelected(dateString: String,
                    date: Date,
                    from datePicker: EmeraldDateField)
    func onDoneButtonPressed(from datePicker: EmeraldDateField)
}
