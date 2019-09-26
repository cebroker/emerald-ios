//
//  EmeraldChartDataEntry.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/13/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation
import Charts

public struct EmeraldChartSimpleDataEntry {
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

public struct EmeraldChartMultipleValueDataEntry {
    var value: [Float]
    var title: String
    
    public init (value: [Float], title: String) {
        self.value = value
        self.title = title
    }
}
