//
//  Extensions+Date.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public extension Date {
    func toString(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Constants.Values.localIdentifier)
        formatter.timeZone = TimeZone(abbreviation: Constants.DateFormat.defaultTimeZone)
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
