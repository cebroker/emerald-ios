//
//  SwiftUICheckbox.swift
//  EmeraldIOS
//
//  Created by David Polania on 16/08/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI

public struct EmeraldSwiftUICheckbox: View {
    @Binding var checked: Bool
    var text: String
    
    private struct InnerConstant {
        static let twenty: CGFloat = 12
        static let ten: CGFloat = 10
        static let thirty: CGFloat = 30
        static let one: CGFloat = 1
        static let three: CGFloat = 3
        static let checkmarkImage = "checkmark.square.fill"
        static let squareImage = "square"
    }
    
    public init(checked: Binding<Bool>, text: String) {
        _checked = checked
        self.text = text
    }
    
    public var body: some View {
        HStack {
            Image(systemName: checked ?
                  InnerConstant.checkmarkImage :
                    InnerConstant.squareImage)
            .resizable()
            .scaledToFit()
            .foregroundColor(checked ? EmeraldTheme.primaryColor.suColor :
                                       EmeraldTheme.borderColor.suColor)
            .frame(width: InnerConstant.twenty,
                   height: InnerConstant.twenty)
            
            Text(text)
                .bodyBold()
            
            Spacer()
        }
        .padding(.vertical, InnerConstant.twenty)
        .padding(.leading, InnerConstant.ten)
        .padding(.trailing, InnerConstant.thirty)
        .background(
            RoundedRectangle(cornerRadius: InnerConstant.three)
                .stroke(checked ? EmeraldTheme.primaryColor.suColor :
                            EmeraldTheme.borderColor.suColor,
                        lineWidth: InnerConstant.one)
        )
        .onTapGesture {
            withAnimation {
                checked.toggle()
            }
        }
    }
}
#if DEBUG
@available(iOS 13.0.0, *)
struct EmeraldSwiftUICheckbox_Previews: PreviewProvider {
    static var previews: some View {
        EmeraldSwiftUICheckbox(checked: .constant(true),
                               text: "I currently work alonside this peer.")
    }
}
#endif
