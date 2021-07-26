//
//  ClearButton.swift
//  Components
//
//  Created by Ronal Fabra on 22/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct ClearButton: View {
    
    static let widthClearButton:CGFloat = 12
    
    var action: () -> Void
    
    public var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: "xmark")
                .resizable()
                .foregroundColor(Constants.EmeraldSwiftUiTextField.textColor)
        }
        .clipShape(Circle())
        .frame(
            width: ClearButton.widthClearButton,
            height: ClearButton.widthClearButton)
    }
}

@available(iOS 13.0.0, *)
struct ClearButton_Previews: PreviewProvider {
    static var previews: some View {
        ClearButton {}
    }
}
