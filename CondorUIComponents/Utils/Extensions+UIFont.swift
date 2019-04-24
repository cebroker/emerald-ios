//
//  Extensions+UIFont.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 4/24/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

enum RegisterFontError: Error {
    case invalidFontFile
    case fontPathNotFound
    case initFontError
    case registerFailed
}

class GetBundle {}

extension UIFont {
    
    static func register(path: String, fileNameString: String, type: String) throws {
        
        let frameworkBundle = Bundle(for: GetBundle.self)

        frameworkBundle.paths(forResourcesOfType: ".ttf", inDirectory: "CondorUIComponentsIOS/Fonts")
        
        guard let resourceBundleURL = frameworkBundle.path(
            forResource: path + "/" + fileNameString, ofType: type) else {
            throw RegisterFontError.fontPathNotFound
        }
        
        guard let fontData = NSData(contentsOfFile: resourceBundleURL),    let dataProvider = CGDataProvider.init(data: fontData) else {
            throw RegisterFontError.invalidFontFile
        }
        
        guard let fontRef = CGFont.init(dataProvider) else {
            throw RegisterFontError.initFontError
        }
        
        var errorRef: Unmanaged<CFError>? = nil
        
        guard CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) else   {
            throw RegisterFontError.registerFailed
        }
    }
}
