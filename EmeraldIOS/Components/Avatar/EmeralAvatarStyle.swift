//
//  EmeralAvatarStyle.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 6/18/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public enum EmeraldAvatarStyle: String, Inspectable {
    case xs
    case md
    case lg

    var font: UIFont {
        switch self {
        case .xs:
            return UIFont.systemFont(ofSize: FontSize.h5.cgFontSize, weight: .regular)
        case .md:
            return UIFont.systemFont(ofSize: FontSize.h2.cgFontSize, weight: .regular)
        case .lg:
            return UIFont.systemFont(ofSize: FontSize.h1.cgFontSize, weight: .regular)
        }
    }

    var size: CGFloat {
        switch self {
        case .xs:
            return CGFloat(integerLiteral: 40)
        case .md:
            return CGFloat(integerLiteral: 60)
        case .lg:
            return CGFloat(integerLiteral: 80)
        }
    }

    var IBInspectable: String {
        return rawValue
    }

    init(IBInspectable: String) {
        self.init(stringValue: IBInspectable)
    }
}

public enum EmeraldAvatarColors: String, CaseIterable {
    case white
    case black

    var uiColor: UIColor {
        switch self {
        case .white:
            return EmeraldTheme.whiteColor
        case .black:
            return EmeraldTheme.blackColor
        }
    }
}
