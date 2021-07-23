//
//  ClearButton.swift
//  Components
//
//  Created by Ronal Fabra on 22/07/21.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct ClearButton: View {
    
    struct Constants {
        static let iconClear: Image = Image(systemName: "xmark")
        static let textColor: Color = ColorPallete.black.uiColor.suColor
    }
    
    static let widthClearButton:CGFloat = 12
    
    var action: () -> Void
    
    public var body: some View {
        HStack(alignment: .top) {
            Spacer()
            VStack(alignment: .trailing) {
                Button(action: {
                    action()
                }) {
                    Constants.iconClear
                        .resizable()
                        .frame(width: ClearButton.widthClearButton,
                               height: ClearButton.widthClearButton)
                        .foregroundColor(Constants.textColor)
                }
                .clipShape(Circle())
                Spacer()
            }
        }
    }
}

@available(iOS 13.0.0, *)
struct ClearButton_Previews: PreviewProvider {
    static var previews: some View {
        ClearButton {}
    }
}
