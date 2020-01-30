//
//  TextFormatterType.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 30/01/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import Foundation

public protocol TextFormatterType: AnyObject {
    func format(_ unformattedText: String?) -> String?
    func unformat(_ formattedText: String?) -> String?
}
