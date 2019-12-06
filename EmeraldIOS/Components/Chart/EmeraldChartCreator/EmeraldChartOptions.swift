//
//  EmeraldChartOptions.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/26/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public struct EmeraldChartOptions {
    
    public var cornerRadius: CGFloat
    public var titleFont: UIFont
    public var subtitleFont: UIFont
    public var titleFontColor: UIColor
    public var accessoryViewImage: UIImage?
    public var barWidthPercentage: Double
    public var barReachesTop: Bool
    public var showSubtitle: Bool
    public var showGrid: Bool
    public var showLeftAxis: Bool
    public var drawLeftAxisLine: Bool
    public var steps: Int
    public var multipleValueDataColors: [UIColor]
    
    public init (cornerRadius: CGFloat = 0,
                 titleFont: UIFont = Font(size: .body, weight: .regular).uiFont,
                 subtitleFont: UIFont = Font(size: .h5, weight: .bold).uiFont,
                 titleFontColor: UIColor = EmeraldTheme.chartBaseLineColor,
                 accessoryViewImage: UIImage? = nil,
                 barWidthPercentage: Double = 0.85,
                 barReachesTop: Bool = false,
                 showSubtitle: Bool = false,
                 showGrid: Bool = true,
                 showLeftAxis: Bool = true,
                 drawLeftAxisLine: Bool = false,
                 steps: Int = 5,
                 multipleValueDataColors: [UIColor] = [EmeraldTheme.greenColor,
                                                       EmeraldTheme.yellowColor,
                                                       EmeraldTheme.redColor]) {
        self.cornerRadius = cornerRadius
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
        self.accessoryViewImage = accessoryViewImage
        self.showSubtitle = showSubtitle
        self.showGrid = showGrid
        self.showLeftAxis = showLeftAxis
        self.drawLeftAxisLine = drawLeftAxisLine
        self.steps = steps
        self.multipleValueDataColors = multipleValueDataColors
        self.titleFontColor = titleFontColor
        self.barWidthPercentage = barWidthPercentage
        self.barReachesTop = barReachesTop
    }
}
