//
//  EmeraldTextInputFormatter.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 30/01/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import Foundation

public class EmeraldTextInputFormatter: EmeraldTextFormatter, EmeraldTextInputFormatterType {
    private let positionCorrector: PositionCorrector
    
    // MARK: - Init
    /**
     Initializes formatter with patternString
     
     - Parameters:
     - textPattern: String with special characters, that will be used for formatting
     - patternSymbol: Optional parameter, that represent character, that will be replaced in formatted string
     - prefix: String, that always will be at beggining of text during editing
     */
    public override init(textPattern: String,
                         patternSymbol: Character = "#") {
        self.positionCorrector = PositionCorrector(textPattern: textPattern, patternSymbol: patternSymbol)
        super.init(textPattern: textPattern, patternSymbol: patternSymbol)
    }
    
    // MARK: - open
    
    open func formatInput(currentText: String, range: NSRange, replacementString text: String) -> EmeraldFormattedTextValue {
        let unformattedRange = self.unformattedRange(from: range)
        let oldUnformattedText = (unformat(currentText) ?? "") as NSString
        
        let newText = oldUnformattedText.replacingCharacters(in: unformattedRange, with: text)
        let formattedText = self.format(newText) ?? ""
        
        let caretOffset = getCorrectedCaretPosition(range: range, replacementString: text)
        
        return EmeraldFormattedTextValue(formattedText: formattedText, caretBeginOffset: caretOffset)
    }
    
    private func getCorrectedCaretPosition(range: NSRange, replacementString: String) -> Int {
        let offset = positionCorrector.calculateCaretPositionOffset(originalRange: range, replacementFiltered: replacementString)
        return offset
    }
    
    private func unformattedRange(from range: NSRange) -> NSRange {
        let newRange = NSRange(
            location: range.location - textPattern[..<textPattern.index(textPattern.startIndex, offsetBy: range.location)]
                .replacingOccurrences(of: String(patternSymbol), with: "").count,
            length: range.length - (textPattern as NSString).substring(with: range)
                .replacingOccurrences(of: String(patternSymbol), with: "").count)
        return newRange
    }
}
