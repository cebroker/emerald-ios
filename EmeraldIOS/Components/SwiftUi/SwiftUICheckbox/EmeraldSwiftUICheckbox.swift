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
        static let twenty = 12
        static let ten = 10
        static let thirty = 30
        static let one = 1
        static let three = 3
    }
    
    public init(checked: Binding<Bool>, text: String) {
        _checked = checked
        self.text = text
    }
    
    public var body: some View {
        HStack {
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .resizable()
                .scaledToFit()
                .foregroundColor(checked ? EmeraldTheme.primaryColor.suColor :
                                    EmeraldTheme.borderColor.suColor)
                .frame(width: CGFloat(InnerConstant.twenty),
                       height: CGFloat(InnerConstant.twenty))
            
            Spacer()
            
            Text(text)
                .bodyBold()
        }
        .padding(.vertical, CGFloat(InnerConstant.twenty))
        .padding(.leading, CGFloat(InnerConstant.ten))
        .padding(.trailing, CGFloat(InnerConstant.thirty))
        .background(
            RoundedRectangle(cornerRadius: CGFloat(InnerConstant.three))
                .stroke(checked ? EmeraldTheme.primaryColor.suColor :
                            EmeraldTheme.borderColor.suColor,
                        lineWidth: CGFloat(InnerConstant.one))
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
