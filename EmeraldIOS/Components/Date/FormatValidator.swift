//
//  FormatValidator.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 10/15/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public class FormatValidator {


    private let maxYearCharacter = 4
    private var date: Date?
    private var textFormat: TextFormat?
    private var year: String?
    private var month: String?
    private var dateString: String? {
        willSet {
            self.setProperties(date: newValue)
        }
    }

    public init() { }

    func setDistanceDate(date: Date) {
        self.date = date
    }

    func set(textFormat: TextFormat) {
        self.textFormat = textFormat
    }

    private func setProperties(date: String?) {
        let components = date?.components(separatedBy: "/")
        self.month = components?.first
        self.year = components?.last
    }

    public func fillYear(date: String?) -> String {
        self.dateString = date
        guard let dateString = date else {
            return ""
        }

        switch textFormat {
        case .shortDate:
            return self.buildYear(dateString: dateString)
        default:
            return dateString
        }
    }

    private func buildYear(dateString: String) -> String {
        guard let year = self.year else {
            return ""
        }
        
        var yearMutable = String()
        if validateYear() {
            return dateString
        } else {
            for (index, i) in Date().getYear().enumerated() {
                if year.count + index <= maxYearCharacter - 1 {
                    yearMutable.append(i)
                }
            }
        }

        yearMutable.append(self.complemented())
        return concatenation(month: self.month, year: yearMutable)
    }
    
    private func concatenation(month: String?, year: String) -> String {
        guard let month = month else {
            return ""
        }
        return month + "/" + year
    }

    private func validateYear() -> Bool {
        guard let dateString = self.dateString else {
            return false
        }

        guard let date = self.date else {
            return false
        }
        return dateString.validate(with: date)
    }

    private func complemented() -> String {
        guard let year = self.year else {
            return ""
        }

        return year
    }

    func dateFromString() -> Date? {
        guard let dateString = self.dateString else {
            return Date()
        }
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM/yyyy"
        return dateFormat.date(from: dateString)
    }
}
