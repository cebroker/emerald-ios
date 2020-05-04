//
//  Extensions+Optional.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 2/05/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        guard let string = self else { return true }
        return string.isEmpty
    }
}
