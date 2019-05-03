//
//  EmeraldInitializer.swift
//  EmeraldIOS
//
//  Created by Luis David Goyes Garces on 4/24/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

class ClassBundle { }

public class EmeraldInitializer {
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

        let cfFontData = try Data(contentsOf: url) as CFData

        guard let provider = CGDataProvider(data: cfFontData) else {
            throw DynamicResourceAllocationError.providerCannotBeCreated
        }

        guard let font = CGFont(provider) else {
            throw DynamicResourceAllocationError.fontCannotBeInstantiated
        }

        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            let errorDescription = CFErrorCopyDescription((error as! CFError))
            print("Failed to load font: \(String(describing: errorDescription))")
        }
    }
}

enum DynamicResourceAllocationError: Error {
    case urlNotFound
    case cfDataNotFound
    case providerCannotBeCreated
    case fontCannotBeInstantiated
}
