//
//  LabelCounterField.swift
//  Components
//
//  Created by Ronal Fabra on 22/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct LabelTextFieldCounter: View {
    
    @Binding var text: String
    var disabled: Bool = false
    var maxLength: Int? = nil
    
    public var body: some View {
        Text(String(
                format: "%d/%d",
                text.count,
                maxLength ?? 0))
            .font(Typography(
                    size: .h4,
                    weight: .semibold).suFont)
            .foregroundColor(
                disabled ?
                    Constants.EmeraldSwiftUiTextField.textColor.suColor.opacity(0.5) :
                    Constants.EmeraldSwiftUiTextField.textColor.suColor)
            .lineLimit(1)
    }
}

#if DEBUG
@available(iOS 13.0.0, *)
struct LabelTextFieldCounter_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        @State(initialValue: 3) var maxLength: Int?
        
        var body: some View {
            LabelTextFieldCounter(text: $name, maxLength: maxLength)
        }
    }
}
#endif
