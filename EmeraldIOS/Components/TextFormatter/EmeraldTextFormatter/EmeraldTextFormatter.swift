//
//  EmeraldTextFromatter.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 30/01/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import Foundation

public class EmeraldTextFormatter: TextFormatterType {
    // MARK: - Fields
    public static let defaultPatternSymbol: Character = "#"
    /// String, that will use for formatting of string replacing patter symbol, example: patternSymbol - "#", format - "### (###) ###-##-##"
      public let textPattern: String
    
    /// Symbol that will be replace by input symbols
      public let patternSymbol: Character
    
    // MARK: - Init
    /**
     Initializes formatter with pattern
     
     - Parameters:
     - textPatterm: String, that will use for formatting of string replacing patter symbol
     - patternSymbol: Character, that will be replaced by input characters in textPattern
     */
    public init(textPattern: String,
                patternSymbol: Character = defaultPatternSymbol) {
      self.textPattern = textPattern
      self.patternSymbol = patternSymbol
    }
    
    // MARK: - TextFormatter
    /**
     Formatting text with current textPattern
     
     - Parameters:
       - unformatted: String, that need to be convert with current textPattern
     
     - Returns: Formatted text with current textPattern
    */
    open func format(_ unformattedText: String?) -> String? {
      guard let unformattedText = unformattedText else { return nil }
      var formatted = String.init()
      var unformattedIndex = 0
      var patternIndex = 0
      
      while patternIndex < textPattern.count && unformattedIndex < unformattedText.count {
        guard let patternCharacter = textPattern.characterAt(patternIndex) else { break }
        if patternCharacter == patternSymbol {
          if let unformattedCharacter = unformattedText.characterAt(unformattedIndex) {
            formatted.append(unformattedCharacter)
          }
          unformattedIndex += 1
        } else {
          formatted.append(patternCharacter)
        }
        patternIndex += 1
      }
      return formatted
    }
    
    /**
     Method for convert string, that sutisfy current textPattern, into unformatted string
     
     - Parameters:
       - formatted: String, that will convert
     
     - Returns: string converted into unformatted with current textPattern
    */
    open func unformat(_ formatted: String?) -> String? {
      guard let formatted = formatted else { return nil }
      var unformatted = String()
      var formattedIndex = 0
      
      while formattedIndex < formatted.count {
        if let formattedCharacter = formatted.characterAt(formattedIndex) {
          if formattedIndex >= textPattern.count {
            unformatted.append(formattedCharacter)
          } else if formattedCharacter != textPattern.characterAt(formattedIndex) {
            unformatted.append(formattedCharacter)
          }
          formattedIndex += 1
        }
      }
      return unformatted
    }

}
