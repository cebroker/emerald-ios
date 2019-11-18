//
//  EmeralAvatarStyle.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 6/18/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public enum EmeraldAvatarStyle: String, Inspectable {
    case xxs
    case xs
    case md
    case lg

    var font: UIFont {
        switch self {
        case .xxs:
            return UIFont.systemFont(ofSize: FontSize.h7.cgFontSize, weight: .regular)
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
        case .xxs:
            return CGFloat(integerLiteral: 20)
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

public enum EmeraldAvatarColor: String, CaseIterable {
    typealias colors = EmeraldTheme.Avatar

    case aquamarineColor
    case reddishBrownColor
    case cyanColor
    case chelseaCucumberColor
    case hillaryColor
    case bullShotColor
    case purpleColor
    case lavenderColor
    case downyColor

    var color: UIColor {
        switch self {
        case .aquamarineColor:
            return colors.aquamarineColor
        case .reddishBrownColor:
            return colors.reddishBrownColor
        case .cyanColor:
            return colors.cyanColor
        case .chelseaCucumberColor:
            return colors.chelseaCucumberColor
        case .hillaryColor:
            return colors.hillaryColor
        case .bullShotColor:
            return colors.bullShotColor
        case .purpleColor:
            return colors.purpleColor
        case .lavenderColor:
            return colors.lavenderColor
        case .downyColor:
            return colors.downyColor
        }
    }
}
