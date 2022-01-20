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
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `yes`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder func `no`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if !condition() {
            transform(self)
        } else {
            self
        }
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
