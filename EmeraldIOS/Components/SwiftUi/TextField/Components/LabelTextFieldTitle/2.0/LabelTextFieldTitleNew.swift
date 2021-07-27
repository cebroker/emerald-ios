//
//  LabelTextFieldTitleNew.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 26/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct LabelTextFieldTitleNew: View {
    
    var label: String
    var disabled: Bool = false
    var errorText: String? = nil
    @Binding var focused: Bool
    
    var body: some View {
        Text(label)
            .padding(
                .horizontal,
                label.isEmpty ?
                    .zero :
                    Constants.EmeraldSwiftUiTextField.horizontalLabelSpacing)
            .background(Color(UIColor.systemBackground))
            .font(Typography(
                    size: .h5,
                    weight: .semibold).suFont)
            .foregroundColor(
                errorText != nil ?
                    Constants.EmeraldSwiftUiTextField.errorColor :
                    (focused ?
                        Constants.EmeraldSwiftUiTextField.focusColor :
                        (disabled ?
                            Constants.EmeraldSwiftUiTextField.placeHolderColor.opacity(0.5) :
                            Constants.EmeraldSwiftUiTextField.placeHolderColor)))
            .lineLimit(1)
            .offset(
                x: Constants.EmeraldSwiftUiTextField.leadingContentSpacing -
                    Constants.EmeraldSwiftUiTextField.horizontalLabelSpacing,
                y: .zero)
    }
}

@available(iOS 13.0.0, *)
struct LabelTextFieldTitleNew_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: false) var focused: Bool
        
        var body: some View {
            LabelTextFieldTitleNew(
                label: "name asda s sada s asda sdasda s d sdas dasds as dfs dfs df",
                focused: $focused)
        }
    }
}
