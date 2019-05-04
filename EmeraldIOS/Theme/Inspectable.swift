//
//  Inspectable.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/3/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

protocol ThemeInspectableType {}

extension String: ThemeInspectableType {}
extension CGFloat: ThemeInspectableType {}
extension Float: ThemeInspectableType {}
extension Int: ThemeInspectableType {}
extension UIColor: ThemeInspectableType {}

protocol Inspectable {
    associatedtype InspectableType: ThemeInspectableType
    var IBInspectable: InspectableType { get }
    init(IBInspectable: InspectableType)
}

extension RawRepresentable where Self: Inspectable, RawValue == String {
    init(stringValue: String) {
        self.init(rawValue: stringValue)!
    }
}
