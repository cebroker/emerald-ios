//
//  LabelTextFieldTitle.swift
//  Components
//
//  Created by Ronal Fabra on 22/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct LabelTextFieldTitle: View {
    
    var label: String
    var disabled: Bool = false
    var text: String = ""
    var errorText: String? = nil
    @Binding var focused: Bool
    
    public var body: some View {
        Text(label)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 30)
            .fixedSize(horizontal: false, vertical: true)
            .font(Typography(
                    size: focused || !text.isEmpty ?
                        .h6 :
                        .h5,
                    weight: .semibold).suFont)
            .foregroundColor(
                errorText != nil ?
                    Constants.EmeraldSwiftUiTextField.errorColor.suColor :
                    (focused ?
                        Constants.EmeraldSwiftUiTextField.focusColor.suColor :
                        (disabled ?
                            Constants.EmeraldSwiftUiTextField.borderColor.suColor.opacity(0.5) :
                            Constants.EmeraldSwiftUiTextField.borderColor.suColor)))
   }
}

#if DEBUG
@available(iOS 13.0.0, *)
struct LabelTextFieldTitle_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: false) var focused: Bool
        
        var body: some View {
            LabelTextFieldTitle(
                label: "name asda s sada s asda sdasda s d sdas dasds as dfs dfs df",
                focused: $focused)
        }
    }
}
#endif
