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
    public var accessoryViewImage: UIImage
    public var showSubtitle: Bool
    public var showGrid: Bool
    public var showLeftAxis: Bool
    public var steps: Int
    public var drawBorder: Bool
    
    public init (cornerRadius: CGFloat = 0,
                 titleFont: UIFont = UIFont.systemFont(ofSize: 10),
                 subtitleFont: UIFont = UIFont.boldSystemFont(ofSize: 20),
                 accessoryViewImage: UIImage = UIImage(),
                 showSubtitle: Bool = false,
                 showGrid: Bool = false,
                 showLeftAxis: Bool = true,
                 steps: Int = 5,
                 drawBorder: Bool = false){
        self.cornerRadius = cornerRadius
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
        self.accessoryViewImage = accessoryViewImage
        self.showSubtitle = showSubtitle
        self.showGrid = showGrid
        self.showLeftAxis = showLeftAxis
        self.steps = steps
        self.drawBorder = drawBorder
    }
}
