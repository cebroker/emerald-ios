//
//  Extensions+String.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public extension String {
    
    func toDateFormat(with format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        if let date = dateFormatter.date(from: self) {
            return date
        }
        return Date()
    }
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = Constants.DateFormat.backend
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            dateFormatter.dateFormat = Constants.DateFormat.yyyyMMdd
            if let date = dateFormatter.date(from: self) {
                return date
            } else {
                dateFormatter.dateFormat = Constants.DateFormat.defaultFormat
                if let date = dateFormatter.date(from: self) {
                    return date
                } else {
                    dateFormatter.dateFormat = Constants.DateFormat.hyphenDateFormat
                    if let date = dateFormatter.date(from: self) {
                        return date
                    } else {
                        dateFormatter.dateFormat = Constants.DateFormat.shortFormat
                        if let date = dateFormatter.date(from: self){
                            return date
                        }
                    }
                }
            }
            return Date()
        }
    }
}
