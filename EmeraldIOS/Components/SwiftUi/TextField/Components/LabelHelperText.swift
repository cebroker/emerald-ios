//
//  LabelHelperText.swift
//  Components
//
//  Created by Ronal Fabra on 22/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct LabelHelperText: View {
    
    var disabled: Bool = false
    var helperText: String? = nil
    var errorText: String? = nil
    
    public var body: some View {
        Text(
            errorText != nil ?
                errorText ?? "" :
                helperText ?? "")
            .minimumScaleFactor(0.01)
            .fixedSize(
                horizontal: false,
                vertical: true)
            .multilineTextAlignment(.leading)
            .font(Typography(
                    size: .h5,
                    weight: .semibold).suFont)
            .foregroundColor(
                errorText != nil ?
                    Constants.EmeraldSwiftUiTextField.errorColor.suColor :
                    (disabled ?
                        Constants.EmeraldSwiftUiTextField.lightTextColor.suColor :
                        Constants.EmeraldSwiftUiTextField.lightTextColor.suColor))
            .padding(.leading, -10)
    }
}

#if DEBUG
@available(iOS 13.0.0, *)
struct LabelHelperText_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "this field is for help you ") var helperText: String?
        
        var body: some View {
            LabelHelperText(helperText: helperText)
        }
    }
}
#endif
