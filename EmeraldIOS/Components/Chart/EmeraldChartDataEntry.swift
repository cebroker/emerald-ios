//
//  EmeraldChartDataEntry.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/13/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public protocol EmeraldChartDataEntry {
    var color: UIColor { get set }
    var value: Float { get set }
    var title: String { get set }
    var subtitle: String? { get set }
    var hasAction: Bool { get set }
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
