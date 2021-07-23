//
//  LabelTextFieldTitle.swift
//  Components
//
//  Created by Ronal Fabra on 22/07/21.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct LabelTextFieldTitle: View {
    
    var label: String
    var disabled: Bool = false
    var errorText: String? = nil
    @Binding var focused: Bool
    
    public var body: some View {
        Text(label)
            .padding(
                .horizontal,
                label.isEmpty ?
                    .zero :
                    Constants.EmeraldSwiftUiTextField.horizontalLabelSpacing)
            .background(Constants.EmeraldSwiftUiTextField.whiteColor)
            .font(Typography(
                    size: .h5,
                    weight: .semibold).suFont)
            .foregroundColor(
                errorText != nil ?
                    Constants.EmeraldSwiftUiTextField.errorColor :
                    (focused ?
                        Constants.EmeraldSwiftUiTextField.focusColor :
                        (disabled ?
                            Constants.EmeraldSwiftUiTextField.disabledColor :
                            Constants.EmeraldSwiftUiTextField.textColor)))
            .lineLimit(1)
            .offset(
                x: Constants.EmeraldSwiftUiTextField.leadingContentSpacing -
                    Constants.EmeraldSwiftUiTextField.horizontalLabelSpacing,
                y: .zero)
    }
}

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
