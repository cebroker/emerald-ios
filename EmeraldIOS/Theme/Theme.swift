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
    private static let bundle = Bundle(for: ClassBundle.self)
    public static let whiteColor = UIColor(named: "whiteColor", in: bundle, compatibleWith: nil)!
    public static let blackColor = UIColor(named: "blackColor", in: bundle, compatibleWith: nil)!
    public static let redColor = UIColor(named: "redColor", in: bundle, compatibleWith: nil)!
    public static let greenColor = UIColor(named: "greenColor", in: bundle, compatibleWith: nil)!
    public static let blueColor = UIColor(named: "blueColor", in: bundle, compatibleWith: nil)!
    public static let yellowColor = UIColor(named: "yellowColor", in: bundle, compatibleWith: nil)!
    public static let grayColor = UIColor(named: "grayColor", in: bundle, compatibleWith: nil)!
    public static let darkGrayColor = UIColor(named: "darkGrayColor", in: bundle, compatibleWith: nil)!
    public static let extraDarkGrayColor = UIColor(named: "extraDarkGrayColor", in: bundle, compatibleWith: nil)!
    public static let lightGrayColor = UIColor(named: "lightGrayColor", in: bundle, compatibleWith: nil)!
    public static let extraLightGrayColor = UIColor(named: "extraLightGrayColor", in: bundle, compatibleWith: nil)!
    public static let toastSuccess = UIColor(named: "toastSuccess", in: bundle, compatibleWith: nil)!
    public static let toastFailure = UIColor(named: "toastFailure", in: bundle, compatibleWith: nil)!
    public static let axisChart = UIColor(named: "axisChartColor", in: bundle, compatibleWith: nil)!
    public static let chartBaseLineColor = UIColor(named: "chartBaseLineColor", in: bundle, compatibleWith: nil)!
    public static let headerImageBorderColor = UIColor(named: "headerImageBorderColor", in: bundle, compatibleWith: nil)!
    public static let headerImageColor = UIColor(named: "headerImageColor", in: bundle, compatibleWith: nil)!
    public static let headerSubtitleColor = UIColor(named: "headerSubtitleColor", in: bundle, compatibleWith: nil)!
    public static let witheAndBlueColor = UIColor(named: "witheAndBlueColor", in: bundle, compatibleWith: nil)!
    
    // MARK: General Colors

    public static let primaryColor = blueColor
    public static let secondaryColor = UIColor(named: "secondaryColor", in: bundle, compatibleWith: nil)!
    public static let backgroundColor = UIColor(named: "backgroundColor", in: bundle, compatibleWith: nil)!
    public static let darkTintColor = blackColor.withAlphaComponent(0.15)
    public static let lightTintColor = whiteColor.withAlphaComponent(0.15)
    public static let textColor = darkGrayColor
    public static let darkTextColor = extraDarkGrayColor
    public static let lightTextColor = lightGrayColor
    public static let extraLightTextColor = extraLightGrayColor
    public static let linkColor = blueColor
    public static let primaryButtonColor = blueColor
    public static let primaryButtonHighlightedColor = #colorLiteral(red: 0.137254902, green: 0.5215686275, blue: 0.9137254902, alpha: 1)
    public static let successButtonHighlightedColor = successColor.withAlphaComponent(0.15)
    public static let warningButtonHighlightedColor = warningColor.withAlphaComponent(0.15)
    public static let errorButtonHighlightedColor = errorColor.withAlphaComponent(0.15)
    public static let secondaryButtonColor = whiteColor
    public static let placeholderColor = UIColor.lightGray
    public static let borderColor = UIColor(named: "borderColor", in: bundle, compatibleWith: nil)!
    public static let chevronColor = UIColor(named: "chevronColor", in: bundle, compatibleWith: nil)!
    public static let warningColor = yellowColor
    public static let successColor = greenColor
    public static let errorColor = redColor
    public static let chipDefaultColor = UIColor(named: "chipDefaultColor", in: bundle, compatibleWith: nil)!


    // MARK: App Colors
    public static let mainNavigationTintColor = whiteColor
    public static let mainNavigationBarTintColor = UIColor(named: "mainNavigationBarTintColor", in: bundle, compatibleWith: nil)!
    public static let skeletonBackgroundColor = #colorLiteral(red: 0.7450980392, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
    public static let pagerBackgroundColor = #colorLiteral(red: 0.9019607843, green: 0.937254902, blue: 0.9529411765, alpha: 1)
    public static let progressCompletedColor = greenColor
    public static let progressNotCompletedColor = warningColor
    public static let elevatedViewPrimaryColor = #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.8549019608, alpha: 1)
    public static let elevatedViewSecondaryColor = blackColor
    
    // MARK: - Avatar Colors
    public struct Avatar {
        public static let aquamarineColor = #colorLiteral(red: 0, green: 0.6784313725, blue: 0.6235294118, alpha: 1)
        public static let reddishBrownColor = #colorLiteral(red: 0.6078431373, green: 0.1921568627, blue: 0.2392156863, alpha: 1)
        public static let cyanColor = #colorLiteral(red: 0.231372549, green: 0.9254901961, blue: 0.9725490196, alpha: 1)
        public static let chelseaCucumberColor = #colorLiteral(red: 0.5529411765, green: 0.768627451, blue: 0.3254901961, alpha: 1)
        public static let hillaryColor = #colorLiteral(red: 0.6862745098, green: 0.662745098, blue: 0.5529411765, alpha: 1)
        public static let bullShotColor = #colorLiteral(red: 0.4901960784, green: 0.3058823529, blue: 0.1294117647, alpha: 1)
        public static let purpleColor = #colorLiteral(red: 0.568627451, green: 0, blue: 0.6784313725, alpha: 1)
        public static let lavenderColor = #colorLiteral(red: 0.7058823529, green: 0.5215686275, blue: 0.8588235294, alpha: 1)
        public static let downyColor = #colorLiteral(red: 0.4431372549, green: 0.8352941176, blue: 0.7490196078, alpha: 1)
    }
    
    // MARK: Corner Defaults
    public static let defaultCornerRadius: CGFloat = 2
    public static let defaultButtonCornerRadius: CGFloat = 5
    public static let defaultElevatedViewCornerRadius: CGFloat = 5
    public static let withoutCornerRadius : CGFloat = 0

    // MARK: Border Defaults
    public static let defaultBorderWidth: CGFloat = 1
    public static let simpleBorderWidth: CGFloat = 0
    public static let selectableBorderWidth: CGFloat = 2
}
