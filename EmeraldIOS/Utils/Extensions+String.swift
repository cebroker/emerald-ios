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
    
    func characterAt(_ index: Int) -> Character? {
      guard index < count else { return nil }
      return self[self.index(self.startIndex, offsetBy: index)]
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
                        if let date = dateFormatter.date(from: self) {
                            return date
                        }
                    }
                }
            }
            return Date()
        }
    }
    
    func currencyInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix,
                                                          options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                          range: NSMakeRange(0, self.count),
                                                          withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number) ?? ""
    }
}
