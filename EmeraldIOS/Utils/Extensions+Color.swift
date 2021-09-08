//
//  Extensions+Color.swift
//  EmeraldIOS
//
//  Created by Daniel Crespo Duarte on 7/21/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
extension Color {
    
    // MARK: Base Colors
    public static let cWhite = EmeraldTheme.whiteColor.suColor
    public static let cBlack = EmeraldTheme.blackColor.suColor
    public static let cRed = EmeraldTheme.redColor.suColor
    public static let cGreen = EmeraldTheme.greenColor.suColor
    public static let cBlue = EmeraldTheme.blueColor.suColor
    public static let cYellow = EmeraldTheme.yellowColor.suColor
    public static let cGray = EmeraldTheme.grayColor.suColor
    public static let cDarkGray = EmeraldTheme.darkGrayColor.suColor
    public static let cExtraDarkGray = EmeraldTheme.extraDarkGrayColor.suColor
    public static let cLightGray = EmeraldTheme.lightGrayColor.suColor
    public static let cExtraLightGray = EmeraldTheme.extraLightGrayColor.suColor
    public static let cToastSuccess = EmeraldTheme.toastSuccess.suColor
    public static let cToastFailure = EmeraldTheme.toastFailure.suColor
    public static let cAxisChart = EmeraldTheme.axisChart.suColor
    public static let cChartBaseLine = EmeraldTheme.chartBaseLineColor.suColor
    public static let cHeaderImageBorder = EmeraldTheme.headerImageBorderColor.suColor
    public static let cHeaderImage = EmeraldTheme.headerImageColor.suColor
    public static let cHeaderSubtitle = EmeraldTheme.headerSubtitleColor.suColor
    public static let cWitheAndBlue = EmeraldTheme.witheAndBlueColor.suColor
    
    // MARK: General Colors
    public static let cPrimary = EmeraldTheme.primaryColor.suColor
    public static let cSecondary = EmeraldTheme.secondaryColor.suColor
    public static let cBackground = EmeraldTheme.backgroundColor.suColor
    public static let cDarkTint = EmeraldTheme.darkTintColor.suColor
    public static let cLightTint = EmeraldTheme.lightTintColor.suColor
    public static let cText = EmeraldTheme.textColor.suColor
    public static let cDarkText = EmeraldTheme.darkTextColor.suColor
    public static let cLightText = EmeraldTheme.lightTextColor.suColor
    public static let cExtraLightText = EmeraldTheme.extraLightTextColor.suColor
    public static let cLink = EmeraldTheme.linkColor.suColor
    public static let cPrimaryButton = EmeraldTheme.primaryButtonColor.suColor
    public static let cPrimaryButtonHighlighted = EmeraldTheme.primaryButtonHighlightedColor.suColor
    public static let cSuccessButtonHighlighted = EmeraldTheme.successButtonHighlightedColor.suColor
    public static let cWarningButtonHighlighted = EmeraldTheme.warningButtonHighlightedColor.suColor
    public static let cErrorButtonHighlighted = EmeraldTheme.errorButtonHighlightedColor.suColor
    public static let cSecondaryButton = EmeraldTheme.secondaryButtonColor.suColor
    public static let cPlaceholder = EmeraldTheme.placeholderColor.suColor
    public static let cBorder = EmeraldTheme.borderColor.suColor
    public static let cChevron = EmeraldTheme.chevronColor.suColor
    public static let cWarning = EmeraldTheme.warningColor.suColor
    public static let cSuccess = EmeraldTheme.successColor.suColor
    public static let cError = EmeraldTheme.errorColor.suColor
    public static let cChipDefault = EmeraldTheme.chipDefaultColor.suColor
    public static let cWarningBackground = EmeraldTheme.warningBackgroundColor.suColor
    
    // MARK: App Colors
    public static let cMainNavigationTint = EmeraldTheme.mainNavigationTintColor.suColor
    public static let cMainNavigationBarTint = EmeraldTheme.mainNavigationBarTintColor.suColor
    public static let cSkeletonBackground = EmeraldTheme.skeletonBackgroundColor.suColor
    public static let cPagerBackgroundColor = EmeraldTheme.pagerBackgroundColor.suColor
    public static let cProgressCompleted = EmeraldTheme.progressCompletedColor.suColor
    public static let cProgressNotCompleted = EmeraldTheme.progressNotCompletedColor.suColor
    public static let cElevatedViewPrimary = EmeraldTheme.elevatedViewPrimaryColor.suColor
    public static let cElevatedViewSecondary = EmeraldTheme.elevatedViewSecondaryColor.suColor

    // MARK: Avatar Colors
    public static let cAquamarineColor = EmeraldTheme.Avatar.aquamarineColor.suColor
    public static let cReddishBrownColor = EmeraldTheme.Avatar.reddishBrownColor.suColor
    public static let cCYanColor = EmeraldTheme.Avatar.cyanColor.suColor
    public static let cChelseaCucumberColor = EmeraldTheme.Avatar.chelseaCucumberColor.suColor
    public static let cHillaryColor = EmeraldTheme.Avatar.hillaryColor.suColor
    public static let cBullShotColor = EmeraldTheme.Avatar.bullShotColor.suColor
    public static let cPurpleColor = EmeraldTheme.Avatar.purpleColor.suColor
    public static let cLavenderColor = EmeraldTheme.Avatar.lavenderColor.suColor
    public static let cDownyColor = EmeraldTheme.Avatar.downyColor.suColor
}

extension UIColor {
    // MARK: Base Colors
    public static let cWhite = EmeraldTheme.whiteColor
    public static let cBlack = EmeraldTheme.blackColor
    public static let cRed = EmeraldTheme.redColor
    public static let cGreen = EmeraldTheme.greenColor
    public static let cBlue = EmeraldTheme.blueColor
    public static let cYellow = EmeraldTheme.yellowColor
    public static let cGray = EmeraldTheme.grayColor
    public static let cDarkGray = EmeraldTheme.darkGrayColor
    public static let cExtraDarkGray = EmeraldTheme.extraDarkGrayColor
    public static let cLightGray = EmeraldTheme.lightGrayColor
    public static let cExtraLightGray = EmeraldTheme.extraLightGrayColor
    public static let cToastSuccess = EmeraldTheme.toastSuccess
    public static let cToastFailure = EmeraldTheme.toastFailure
    public static let cAxisChart = EmeraldTheme.axisChart
    public static let cChartBaseLine = EmeraldTheme.chartBaseLineColor
    public static let cHeaderImageBorder = EmeraldTheme.headerImageBorderColor
    public static let cHeaderImage = EmeraldTheme.headerImageColor
    public static let cHeaderSubtitle = EmeraldTheme.headerSubtitleColor
    public static let cWitheAndBlue = EmeraldTheme.witheAndBlueColor
    
    // MARK: General Colors
    public static let cPrimary = EmeraldTheme.primaryColor
    public static let cSecondary = EmeraldTheme.secondaryColor
    public static let cBackground = EmeraldTheme.backgroundColor
    public static let cDarkTint = EmeraldTheme.darkTintColor
    public static let cLightTint = EmeraldTheme.lightTintColor
    public static let cText = EmeraldTheme.textColor
    public static let cDarkText = EmeraldTheme.darkTextColor
    public static let cLightText = EmeraldTheme.lightTextColor
    public static let cExtraLightText = EmeraldTheme.extraLightTextColor
    public static let cLink = EmeraldTheme.linkColor
    public static let cPrimaryButton = EmeraldTheme.primaryButtonColor
    public static let cPrimaryButtonHighlighted = EmeraldTheme.primaryButtonHighlightedColor
    public static let cSuccessButtonHighlighted = EmeraldTheme.successButtonHighlightedColor
    public static let cWarningButtonHighlighted = EmeraldTheme.warningButtonHighlightedColor
    public static let cErrorButtonHighlighted = EmeraldTheme.errorButtonHighlightedColor
    public static let cSecondaryButton = EmeraldTheme.secondaryButtonColor
    public static let cPlaceholder = EmeraldTheme.placeholderColor
    public static let cBorder = EmeraldTheme.borderColor
    public static let cChevron = EmeraldTheme.chevronColor
    public static let cWarning = EmeraldTheme.warningColor
    public static let cSuccess = EmeraldTheme.successColor
    public static let cError = EmeraldTheme.errorColor
    public static let cChipDefault = EmeraldTheme.chipDefaultColor
    public static let cWarningBackground = EmeraldTheme.warningBackgroundColor
    
    // MARK: App Colors
    public static let cMainNavigationTint = EmeraldTheme.mainNavigationTintColor
    public static let cMainNavigationBarTint = EmeraldTheme.mainNavigationBarTintColor
    public static let cSkeletonBackground = EmeraldTheme.skeletonBackgroundColor
    public static let cPagerBackgroundColor = EmeraldTheme.pagerBackgroundColor
    public static let cProgressCompleted = EmeraldTheme.progressCompletedColor
    public static let cProgressNotCompleted = EmeraldTheme.progressNotCompletedColor
    public static let cElevatedViewPrimary = EmeraldTheme.elevatedViewPrimaryColor
    public static let cElevatedViewSecondary = EmeraldTheme.elevatedViewSecondaryColor

    // MARK: Avatar Colors
    public static let cAquamarineColor = EmeraldTheme.Avatar.aquamarineColor
    public static let cReddishBrownColor = EmeraldTheme.Avatar.reddishBrownColor
    public static let cCYanColor = EmeraldTheme.Avatar.cyanColor
    public static let cChelseaCucumberColor = EmeraldTheme.Avatar.chelseaCucumberColor
    public static let cHillaryColor = EmeraldTheme.Avatar.hillaryColor
    public static let cBullShotColor = EmeraldTheme.Avatar.bullShotColor
    public static let cPurpleColor = EmeraldTheme.Avatar.purpleColor
    public static let cLavenderColor = EmeraldTheme.Avatar.lavenderColor
    public static let cDownyColor = EmeraldTheme.Avatar.downyColor
}

extension UIColor {
    @available(iOS 13.0, *)
    var suColor: Color { Color(self) }
}
