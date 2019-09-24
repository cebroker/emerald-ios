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
    public static let whiteColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    public static let blackColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    public static let redColor = #colorLiteral(red: 0.8705882353, green: 0.2078431373, blue: 0.0431372549, alpha: 1)
    public static let greenColor = #colorLiteral(red: 0, green: 0.662745098, blue: 0.3137254902, alpha: 1)
    public static let blueColor = #colorLiteral(red: 0, green: 0.4509803922, blue: 0.9137254902, alpha: 1)
    public static let yellowColor = #colorLiteral(red: 1, green: 0.6666666667, blue: 0, alpha: 1)
    public static let grayColor = #colorLiteral(red: 0.2941176471, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
    public static let darkGrayColor = #colorLiteral(red: 0.1568627451, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
    public static let extraDarkGrayColor = #colorLiteral(red: 0.1137254902, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
    public static let lightGrayColor = #colorLiteral(red: 0.2941176471, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
    public static let extraLightGrayColor = #colorLiteral(red: 0.3764705882, green: 0.4823529412, blue: 0.4823529412, alpha: 1)
    public static let toastSuccess = #colorLiteral(red: 0.8862745098, green: 0.9450980392, blue: 0.8784313725, alpha: 1)
    public static let toastFailure = #colorLiteral(red: 1, green: 0.9181403518, blue: 0.932766974, alpha: 1)
    
    // MARK: General Colors
    public static let primaryColor = blueColor
    public static let secondaryColor = #colorLiteral(red: 0.0431372549, green: 0.1647058824, blue: 0.3607843137, alpha: 1)
    public static let backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9568627451, blue: 0.9725490196, alpha: 1)
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
    public static let borderColor = #colorLiteral(red: 0.9019607843, green: 0.9098039216, blue: 0.9254901961, alpha: 1)
    public static let chevronColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8, alpha: 1)
    public static let warningColor = yellowColor
    public static let successColor = greenColor
    public static let errorColor = redColor


    // MARK: App Colors
    public static let mainNavigationTintColor = whiteColor
    public static let mainNavigationBarTintColor = #colorLiteral(red: 0.05490196078, green: 0.2705882353, blue: 0.4862745098, alpha: 1)
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
    
    public struct Chart {
        public static let criticalData = UIColor(red: 221/255, green: 53/255, blue: 10/255, alpha: 1)
        public static let warningData = UIColor(red: 255/255, green: 170/255, blue: 0/255, alpha: 1)
        public static let correctData = UIColor(red: 9/255, green: 169/255, blue: 80/255, alpha: 1)
    }
    
    // MARK: Corner Defaults
    public static let defaultCornerRadius: CGFloat = 2
    public static let defaultButtonCornerRadius: CGFloat = 5
    public static let defaultElevatedViewCornerRadius: CGFloat = 5

    // MARK: Border Defaults
    public static let defaultBorderWidth: CGFloat = 1
    public static let simpleBorderWidth: CGFloat = 0
    public static let selectableBorderWidth: CGFloat = 2
}
