//
//  TextFontSize.swift
//  EmeraldIOS
//
//  Created by Luis Pineda on 8/09/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct TextFontSize: ViewModifier {
    var size: CGFloat = FontSize.body.cgFontSize
    var color: Color = Color.cText
    var decoration: OpenSansFonts = .Regular
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content
            .foregroundColor(color)
            .font(.custom(decoration.rawValue, size: scaledSize))
    }
}

@available(iOS 13.0, *)
extension View {
    public func bigTitleFont(color: Color = .cText,
                             decoration: OpenSansFonts = .Regular) -> some View {
        self.modifier( TextFontSize(size: FontSize.h1.cgFontSize,
                                    color: color,
                                    decoration: decoration))
    }
    
    public func titleFont(color: Color = .cText,
                          decoration: OpenSansFonts = .Regular) -> some View {
        self.modifier( TextFontSize(size: FontSize.h2.cgFontSize,
                                    color: color,
                                    decoration: decoration))
    }
    
    public func textFont(color: Color = .cText,
                         decoration: OpenSansFonts = .Regular) -> some View {
        self.modifier( TextFontSize(size: FontSize.body.cgFontSize,
                                    color: color,
                                    decoration: decoration))
    }
    
    public func mediumTextFont(color: Color = .cText,
                               decoration: OpenSansFonts = .Regular) -> some View {
        self.modifier( TextFontSize(size: FontSize.h6.cgFontSize,
                                    color: color,
                                    decoration: decoration))
    }
    
    public func smallTextFont(color: Color = .cText,
                              decoration: OpenSansFonts = .Regular) -> some View {
        self.modifier( TextFontSize(size: FontSize.h7.cgFontSize,
                                    color: color,
                                    decoration: decoration))
    }
    
    public func textFontSize(size: FontSize = .body ,
                             color: Color = .cText,
                             decoration: OpenSansFonts = .Regular) -> some View {
        self.modifier( TextFontSize(size: size.cgFontSize,
                                    color: color,
                                    decoration: decoration))
    }
    
    public func textFontSize(size: CGFloat,
                             color: Color = .cText,
                             decoration: OpenSansFonts = .Regular) -> some View {
        self.modifier( TextFontSize(size: size,
                                    color: color,
                                    decoration: decoration))
    }
}
