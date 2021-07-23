//
//  CurrencySymbol.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 23/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct CurrencySymbol: View {
    var disabled: Bool = false
    
    public var body: some View {
        HStack {
            Text("$")
                .frame(width: Constants.EmeraldSwiftUiTextField.widthCurrencySymbol)
                .font(Typography(
                        size: .h3,
                        weight: .semibold).suFont)
                .foregroundColor(
                    disabled ?
                        Constants.EmeraldSwiftUiTextField.disabledColor :
                        Constants.EmeraldSwiftUiTextField.textColor)
            Spacer()
        }
    }
}

@available(iOS 13.0.0, *)
struct CurrencySymbol_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySymbol()
    }
}
