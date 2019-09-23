//
//  EmeraldChartDataEntry.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/13/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public struct EmeraldChartDataEntry {
    var color: UIColor
    var value: Float
    var title: String
    var subtitle: String?
    var hasAction: Bool
    
    public init(color: UIColor,
                value: Float,
                title: String,
                subtitle: String? = nil,
                hasAction: Bool = false) {
        self.color = color
        self.value = value
        self.title = title
        self.subtitle = subtitle
        self.hasAction = hasAction
    }
}

struct EmeraldChartCellData {
    let color: UIColor
    let barHeight: CGFloat
    let barWidth: CGFloat
    let title: String
    let subtitle: String?
    let hasAction: Bool
    
    init(color: UIColor,
         barHeight: CGFloat,
         barWidth: CGFloat,
         title: String,
         subtitle: String? = nil,
         hasAction: Bool = false) {
        
        self.color = color
        self.barHeight = barHeight
        self.barWidth = barWidth
        self.title = title
        self.subtitle = subtitle
        self.hasAction = hasAction
    }
}
