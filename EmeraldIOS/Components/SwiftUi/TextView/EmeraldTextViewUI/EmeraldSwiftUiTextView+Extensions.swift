//
//  EmeraldSwiftUiTextView+Extensions.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 27/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
extension EmeraldSwiftUiTextView {
    
    static func getBorderWidth(focused: Bool) -> CGFloat {
        let borderWidth = focused ?
            Constants.EmeraldSwiftUiTextField.borderWidthFocused :
            Constants.EmeraldSwiftUiTextField.borderWidth
        
        return borderWidth
    }
    
    static func getBorderColor(errorText: String?, focused: Bool, disabled: Bool) -> Color {
        var borderColor: Color
        if errorText == nil {
            borderColor = focused ?
                Constants.EmeraldSwiftUiTextField.focusColor.suColor :
            Color.gray.opacity(0.8)
            
            borderColor = disabled ?
                borderColor.opacity(0.5) :
                borderColor
        } else {
            borderColor = Constants.EmeraldSwiftUiTextField.errorColor.suColor
        }
        
        return borderColor
    }
}
