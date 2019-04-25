//
//  EsmeraldInitializer.swift
//  EmeraldIOS
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

class ClassBundle { }

public class EsmeraldInitializer {
    private struct InnerConstants {
        static let fontType = ".ttf"
        static let bundlePath = "."
    }

    public static func registerFonts() throws {

        try OpenSansFonts.allCases.forEach { font in

            try dynamicallyLoadFont(
                name: font.rawValue,
                in: InnerConstants.bundlePath,
                with: InnerConstants.fontType)
        }
    }

    private static func dynamicallyLoadFont(
        name: String,
        in bundlePath: String,
        with type: String) throws {

        let resourceName = "\(bundlePath)/\(name)"

        guard let url = Bundle(for: ClassBundle.self).url(
            forResource: resourceName,
            withExtension: type) else {
            throw DynamicResourceAllocationError.urlNotFound
        }

        guard let cfFontData = try Data(contentsOf: url) as? CFData else {
            throw DynamicResourceAllocationError.cfDataNotFound
        }

        guard let provider = CGDataProvider(data: cfFontData) else {
            throw DynamicResourceAllocationError.providerCannotBeCreated
        }

        guard let font = CGFont(provider) else {
            throw DynamicResourceAllocationError.fontCannotBeInstantiated
        }

        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            let errorDescription = CFErrorCopyDescription(error as! CFError)
            print("Failed to load font: \(errorDescription)")
        }
    }
}

enum DynamicResourceAllocationError: Error {
    case urlNotFound
    case cfDataNotFound
    case providerCannotBeCreated
    case fontCannotBeInstantiated
}
