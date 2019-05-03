//
//  Theme.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/3/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

class EmeraldTheme {
    
    // MARK: Base Colors
    static let whiteColor = UIColor(hex: 0xFFFFFF)
    static let blackColor = UIColor(hex: 0x000000)
    static let redColor = UIColor(hex: 0xDE350B)
    static let greenColor = UIColor(hex: 0x00A950)
    static let blueColor = UIColor(hex: 0x0073E9)
    static let yellowColor = UIColor(hex: 0xFFAA00)
    static let grayColor = UIColor(hex: 0x4B5353)
    static let darkGrayColor = UIColor(hex: 0x282E2E)
    static let extraDarkGrayColor = UIColor(hex: 0x1D2121)
    static let lightGrayColor = UIColor(hex: 0x607B7B)
    static let extraLightGrayColor = UIColor(hex: 0x607B7B)
    
    // MARK: General Colors
    static let primaryColor = blueColor
    static let secondaryColor = UIColor(hex: 0x0B2A5C)
    static let backgroundColor = UIColor(hex: 0xF2F4F8)
    static let darkTintColor = UIColor.black.withAlphaComponent(0.15)
    static let lightTintColor = UIColor.white.withAlphaComponent(0.15)
    static let textColor = darkGrayColor
    static let darkTextColor = extraDarkGrayColor
    static let lightTextColor = grayColor
    static let extraLightTextColor = lightGrayColor
    static let linkColor = blueColor
    static let primaryButtonColor = blueColor
    static let primaryButtonHighlightedColor = UIColor(hex: 0x2385E9)
    static let secondaryButtonColor = whiteColor
    static let borderColor = UIColor(hex: 0xE6E8EC)
    static let chevronColor = UIColor(hex: 0xC7C7CC)
    static let warningColor = yellowColor
    static let successColor = greenColor
    static let errorColor = redColor
    
    // MARK: App Colors
    static let mainNavigationTintColor = whiteColor
    static let mainNavigationBarTintColor = UIColor(hex: 0x0E457C)
    static let skeletonBackgroundColor = UIColor(hex: 0xBEC6C6)
    static let progressCompletedColor = UIColor(hex: 0x5BD672)
    static let progressNotCompletedColor = warningColor
    static let elevatedViewPrimaryColor = UIColor(hex: 0xCACADA)
    static let elevatedViewSecondaryColor = UIColor(hex: 0x000000)
    
    // MARK: Corner Defaults
    static let defaultCornerRadius: CGFloat = 5
    static let defaultButtonCornerRadius: CGFloat = 5
    static let defaultElevatedViewCornerRadius: CGFloat = 5
}
