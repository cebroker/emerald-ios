//
//  EmeraldSwiftUiTextField+Extensions.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 27/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
extension EmeraldSwiftUiTextField {
    
    static func getBorderWidth(focused: Bool) -> CGFloat {
        let borderWidth = focused ?
            Constants.EmeraldSwiftUiTextField.borderWidthFocused :
            Constants.EmeraldSwiftUiTextField.borderWidth
        
        return borderWidth
    }
    
    static func getBorderColor(errorText: String?, focused: Bool, disabled: Bool) -> Color {
        var borderColor = errorText != nil ?
                            Constants.EmeraldSwiftUiTextField.errorColor :
                            Constants.EmeraldSwiftUiTextField.focusColor
        if errorText == nil {
            borderColor = focused ?
                borderColor :
                Constants.EmeraldSwiftUiTextField.placeHolderColor
            
            borderColor = disabled ?
                borderColor.opacity(0.5) :
                borderColor
        }
        
        return borderColor
    }
}
