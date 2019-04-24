//
//  EsmeraldInitializer.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 4/24/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

enum OpenSansFonts: String, CaseIterable {
    case SemiBold = "OpenSans-SemiBold"
    case Light = "OpenSans-Light"
    case Italic = "OpenSans-Italic"
    case ExtraBold = "OpenSans-ExtraBold"
    case LightItalic = "OpenSans-LightItalic"
    case Bold = "OpenSans-Bold"
    case SemiBoldItalic = "OpenSans-SemiBoldItalic"
    case ExtraBoldItalic = "OpenSans-ExtraBoldItalic"
    case Regular = "OpenSans-Regular"
    case BoldItalic = "OpenSans-BoldItalic"
}

public class EsmeraldInitializer {
    private struct InnerConstants {
        static let path = "CondorUIComponentsIOS/Fonts"
        static let fontType = ".ttf"
    }

    public static func registerFonts() throws {
        UIFont.familyNames.forEach { familiName in
            let fontNames = UIFont.fontNames(forFamilyName: familiName)
            print(familiName, fontNames)
        }
        try OpenSansFonts.allCases.forEach { font in
            try UIFont.register(
                path: InnerConstants.path,
                fileNameString: font.rawValue,
                type: InnerConstants.fontType)
        }
    }
}
