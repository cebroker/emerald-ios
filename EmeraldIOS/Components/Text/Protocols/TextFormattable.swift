//
//  TextFormattable.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 2/05/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import Foundation

public protocol TextFormattable {
    func set(format: TextFormat)
    func getFormat() -> TextFormat
    func getUnformattedText() -> String?
}
