//
//  EmeraldTextFieldFormDateCoordinator.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra Jimenez on 4/01/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import Foundation

final class EmeraldTextFieldFormDateCoordinator: TextFormatter {
    private var formatValidator = FormatValidator()
    private let dateFormat: EmeraldIOS.TextFormat
    private lazy var dateFormatter = DateFormatter()
    
    var minimumDate: Date?
    var maximumDate: Date?
    
    init(dateFormat: TextFormat) {
        self.dateFormat = dateFormat
        setupDefaultDateFormat()
    }
    
    func getFormat() -> TextFormat {
        dateFormat
    }
    
    func apply(to date: String) -> String? {
        return try? apply(format: dateFormat, to: date)
    }
    
    func remove(to date: String) -> String? {
        return try? remove(format: dateFormat, to: date)
    }
    
    func fillYear(date: String?) -> String {
        formatValidator.fillYear(date: date)
    }
    
    func getFormatDate(_ selectedDate: Date) -> String {
        dateFormatter.string(from: selectedDate)
    }
    
    func getDate(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = getDateFormat()
        dateFormatter.locale = Locale(identifier: Constants.Values.localIdentifier)
        return dateFormatter.date(from: string)
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
    
    // MARK: Private methods

    private func setupDefaultDateFormat() {
        dateFormatter.locale = Locale(identifier: Constants.Values.localIdentifier)
        dateFormatter.timeZone = TimeZone(abbreviation: Constants.Values.gmt0)
        dateFormatter.dateFormat = getDateFormat()
    }
    
    private func getDateFormat() -> String {
        dateFormat == .longDate ? Constants.DateFormat.defaultFormat : Constants.DateFormat.shortFormat
    }
}
