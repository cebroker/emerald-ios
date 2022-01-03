//
//  Extensions+View.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra Jimenez on 3/01/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
extension View {
    func bodyBold(color: Color = Constants.EmeraldSwiftUiTextField.textColor.suColor,
                  decoration: FontWeight = .semibold) -> some View {
        return self.modifier( TextFontSize(size: FontSize.h5.cgFontSize,
                                           color: color,
                                           decoration: decoration))
    }
}

@available(iOS 13.0, *)
struct TextFontSize: ViewModifier {
    var size: CGFloat = UIFont.labelFontSize
    var color: Color = Color.black
    var decoration: FontWeight = .regular
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content
            .foregroundColor(color)
            .font(.custom(decoration.rawValue, size: scaledSize))
    }
}
