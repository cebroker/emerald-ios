//
//  RangeFinder.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/20/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

protocol RangeFinder {
    func yDataRange(barData: [EmeraldChartDataEntry], numberOfSteps steps: Int) -> (min: CGFloat, max: CGFloat)
}

extension RangeFinder {
    func yDataRange(barData: [EmeraldChartDataEntry], numberOfSteps steps: Int) -> (min: CGFloat, max: CGFloat) {
        let yValues = barData.compactMap{
            return $0.value
        }
        let maxY = CGFloat(yValues.max() ?? 0)

        var remainder = maxY.truncatingRemainder(dividingBy: CGFloat(steps))
        if remainder.isNaN {
            remainder = 0
        }

        var max: CGFloat = 0

        if remainder == 0 {
            max = maxY
        } else {
            max = maxY - remainder + CGFloat(steps)
        }

        let min = CGFloat(yValues.min() ?? 0)

        return (min, max)
    }
}
