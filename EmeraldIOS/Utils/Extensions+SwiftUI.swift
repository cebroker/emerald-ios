//
//  Extensions+SwiftUI.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra Jimenez on 3/01/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
extension SwiftUI.Color {
    static func isActive(_ isActive: Bool) -> Color {
        isActive ? Constants.EmeraldSwiftUiTextField.focusColor.suColor : Constants.EmeraldSwiftUiTextField.borderColor.suColor
    }
    
    static func fieldColor(hasError: Bool, isActive: Bool) -> Color {
        if hasError {
            return Constants.EmeraldSwiftUiTextField.errorColor.suColor
        } else {
            return isActive ? Constants.EmeraldSwiftUiTextField.focusColor.suColor : Constants.EmeraldSwiftUiTextField.borderColor.suColor
        }
    }
}
