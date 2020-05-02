//
//  TextConfigurable.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 2/05/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import Foundation

public protocol TextConfigurable {
    func set(placeholder: String?)
    func getPlaceholder() -> String?
    func set(hint: String?)
    func getHint() -> String?
    func setText(with value: String?)
    func clearText()
}
