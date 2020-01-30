//
//  TextInputFormatterType.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 30/01/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import Foundation

public struct EmeraldFormattedTextValue: Equatable {
  public let formattedText: String
  public let caretBeginOffset: Int
}

public protocol EmeraldTextInputFormatterType: TextFormatterType {
  
  func formatInput(currentText: String,
                   range: NSRange,
                   replacementString text: String) -> EmeraldFormattedTextValue
}
