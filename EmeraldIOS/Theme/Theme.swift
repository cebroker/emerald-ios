//
//  Theme.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/3/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public class EmeraldTheme {
    
    // MARK: Base Colors
    public static let whiteColor = UIColor(hex: 0xFFFFFF)
    public static let blackColor = UIColor(hex: 0x000000)
    public static let redColor = UIColor(hex: 0xDE350B)
    public static let greenColor = UIColor(hex: 0x00A950)
    public static let blueColor = UIColor(hex: 0x0073E9)
    public static let yellowColor = UIColor(hex: 0xFFAA00)
    public static let grayColor = UIColor(hex: 0x4B5353)
    public static let darkGrayColor = UIColor(hex: 0x282E2E)
    public static let extraDarkGrayColor = UIColor(hex: 0x1D2121)
    public static let lightGrayColor = UIColor(hex: 0x607B7B)
    public static let extraLightGrayColor = UIColor(hex: 0x607B7B)
    
    // MARK: General Colors
    public static let primaryColor = blueColor
    public static let secondaryColor = UIColor(hex: 0x0B2A5C)
    public static let backgroundColor = UIColor(hex: 0xF2F4F8)
    public static let darkTintColor = UIColor.black.withAlphaComponent(0.15)
    public static let lightTintColor = UIColor.white.withAlphaComponent(0.15)
    public static let textColor = darkGrayColor
    public static let darkTextColor = extraDarkGrayColor
    public static let lightTextColor = grayColor
    public static let extraLightTextColor = lightGrayColor
    public static let linkColor = blueColor
    public static let primaryButtonColor = blueColor
    public static let primaryButtonHighlightedColor = UIColor(hex: 0x2385E9)
    public static let secondaryButtonColor = whiteColor
    public static let placeholderColor = UIColor.lightGray
    public static let borderColor = UIColor(hex: 0xE6E8EC)
    public static let chevronColor = UIColor(hex: 0xC7C7CC)
    public static let warningColor = yellowColor
    public static let successColor = greenColor
    public static let errorColor = redColor
    
    // MARK: App Colors
    public static let mainNavigationTintColor = whiteColor
    public static let mainNavigationBarTintColor = UIColor(hex: 0x0E457C)
    public static let skeletonBackgroundColor = UIColor(hex: 0xBEC6C6)
    public static let progressCompletedColor = UIColor(hex: 0x5BD672)
    public static let progressNotCompletedColor = warningColor
    public static let elevatedViewPrimaryColor = UIColor(hex: 0xCACADA)
    public static let elevatedViewSecondaryColor = UIColor(hex: 0x000000)
    
    // MARK: Corner Defaults
    public static let defaultCornerRadius: CGFloat = 2
    public static let defaultButtonCornerRadius: CGFloat = 5
    public static let defaultElevatedViewCornerRadius: CGFloat = 5
    
    // MARK: Border Defaults
    public static let defaultBorderWidth: CGFloat = 1
}
