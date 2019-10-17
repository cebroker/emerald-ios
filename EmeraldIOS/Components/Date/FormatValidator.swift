//
//  FormatValidator.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 10/15/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

enum ComponentslongDate: Int {
    case month
    case day
    case year
}

public class FormatValidator {

    typealias constants = Constants.Values
    private let maxYearCharacter = 4
    private var date: Date?
    private var textFormat: TextFormat?
    private var day: String?
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
        let components = date?.components(separatedBy: constants.slash)
        switch textFormat {
        case .shortDate:
            self.month = components?.first
            self.year = components?.last
        case .longDate:
            for (index, component) in components!.enumerated() {
                let componentsDate = ComponentslongDate(rawValue: index)
                switch componentsDate {
                case .month:
                    self.month = component
                case .day:
                    self.day = component
                case .year:
                    self.year = component
                case .none: break
                }
            }
        default: break
        }
    }

    public func fillYear(date: String?) -> String {
        self.dateString = date
        guard let dateString = date else {
            return constants.empty
        }

        switch textFormat {
        case .shortDate, .longDate:
            return self.buildYear(dateString: dateString)
        default:
            return dateString
        }
    }

    private func buildYear(dateString: String) -> String {
        guard let year = self.year else {
            return constants.empty
        }

        var yearMutable = String()
        for (index, i) in Date().getYear().enumerated() {
            if year.count + index <= maxYearCharacter - 1 {
                yearMutable.append(i)
            }
        }

        yearMutable.append(self.complemented())
        return concatenation(year: yearMutable)
    }

    private func concatenation(year: String) -> String {
        var date = String()

        if let month = self.month {
            date.append(month)
            date.append(constants.slash)
        }

        if let day = self.day {
            date.append(day)
            date.append(constants.slash)
        }

        date.append(year)
        return date
    }

    private func complemented() -> String {
        guard let year = self.year else {
            return constants.empty
        }

        return year
    }
}
