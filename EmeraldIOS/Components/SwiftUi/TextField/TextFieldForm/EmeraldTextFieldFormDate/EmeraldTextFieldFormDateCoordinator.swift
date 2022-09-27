//
//  EmeraldTextFieldFormDateCoordinator.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra Jimenez on 4/01/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import Foundation

protocol EmeraldTextFieldFormDateCoordinatorType: TextFormatter {
    func getFormat() -> TextFormat
    func getMinimumDate() -> Date?
    func getMaximumDate() -> Date?
    func fillYear(date: String?) -> String
    func getDate(from string: String) -> Date?
    func getString(from date: Date) -> String
    func formatText(_ text: String) -> String
}

final class EmeraldTextFieldFormDateCoordinator {
    private var formatValidator = FormatValidator()
    private let dateFormat: EmeraldIOS.TextFormat
    private lazy var dateFormatter = DateFormatter()
    
    private var minimumDate: Date?
    private var maximumDate: Date?
    
    init(
        dateFormat: TextFormat,
        minimumDate: Date? = nil,
        maximunDate: Date? = nil
    ) {
        self.dateFormat = dateFormat
        self.minimumDate = minimumDate
        self.maximumDate = maximunDate
        setupDefaultDateFormat()
    }
    
    // MARK: Private methods
    private func setupDefaultDateFormat() {
        dateFormatter.locale = Locale(identifier: Constants.Values.localIdentifier)
        //dateFormatter.timeZone = TimeZone(abbreviation: Constants.Values.gmt0)
        dateFormatter.dateFormat = getDateFormat()
    }
    
    private func getDateFormat() -> String {
        dateFormat == .longDate ? Constants.DateFormat.defaultFormat : Constants.DateFormat.shortFormat
    }
}

extension EmeraldTextFieldFormDateCoordinator : EmeraldTextFieldFormDateCoordinatorType {
    func apply(to date: String) -> String? {
        return try? apply(format: dateFormat, to: date)
    }
    
    func remove(to date: String) -> String? {
        return try? remove(format: dateFormat, to: date)
    }
    
    func getFormat() -> TextFormat {
        dateFormat
    }
    
    func getMinimumDate() -> Date?{
        minimumDate
    }
    
    func getMaximumDate() -> Date? {
        maximumDate
    }
    
    func fillYear(date: String?) -> String {
        formatValidator.fillYear(date: date)
    }
    
    func getDate(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
    
    func getString(from date: Date) -> String {
        dateFormatter.string(from: date)
    }
    
    func formatText(_ text: String) -> String {
        let maxCharacter = dateFormat == .shortDate ?
        Constants.TextFormating.maximumShortDateLength :
        Constants.TextFormating.maximumDateLength
        let clearText = text.filter{ Constants.TextFormating.numbers.contains($0)}
        let string = String(clearText.prefix(maxCharacter))
        let textWithoutFormat = remove(to: string)
        let newText = apply(to: textWithoutFormat ?? string)
        return String((newText ?? string).prefix(maxCharacter))
    }
}
