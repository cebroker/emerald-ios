//
//  EmeraldCustomBarChartRenderer.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/26/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation
import Charts

class EmeraldCustomBarChartRenderer: BarChartRenderer {

    private class Buffer {
        var rects = [CGRect]()
    }

    internal var cornerRadius: CGFloat = 0
    internal var isSimpleChart: Bool = false
    private var buffers = [Buffer]()

    override func initBuffers() {
        if let barData = dataProvider?.barData {
            if buffers.count != barData.dataSetCount {
                while buffers.count < barData.dataSetCount {
                    buffers.append(Buffer())
                }
                while buffers.count > barData.dataSetCount {
                    buffers.removeLast()
                }
            }

            let dataSets = barData.dataSets.compactMap({ $0 as? BarChartDataSetProtocol })
            for set in dataSets.enumerated() {
                let size = set.element.entryCount * (set.element.isStacked ? set.element.stackSize : 1)
                if buffers[set.offset].rects.count != size {
                    buffers[set.offset].rects = [CGRect](repeating: CGRect(), count: size)
                }
            }
        } else {
            buffers.removeAll()
        }
    }

    private func prepareBuffer(dataSet: BarChartDataSetProtocol, index: Int) {
        guard let dataProvider = dataProvider,
            let barData = dataProvider.barData else {
                return
        }

        let isInverted = dataProvider.isInverted(axis: dataSet.axisDependency)
        let containsStacks = dataSet.isStacked
        let barWidthHalf = barData.barWidth / 2.0
        let buffer = buffers[index]
        let phaseY = animator.phaseY

        var bufferIndex = 0
        var barRect = CGRect()
        var x: Double
        var y: Double

        for i in stride(from: 0, to: min(Int(ceil(Double(dataSet.entryCount) * animator.phaseX)), dataSet.entryCount), by: 1) {
            guard let entry = dataSet.entryForIndex(i) as? BarChartDataEntry else { continue }

            let vals = entry.yValues

            x = entry.x
            y = entry.y

            if !containsStacks || vals == nil {
                let left = CGFloat(x - barWidthHalf)
                let right = CGFloat(x + barWidthHalf)
                var top = isInverted
                    ? (y <= 0.0 ? CGFloat(y) : 0)
                    : (y >= 0.0 ? CGFloat(y) : 0)
                var bottom = isInverted
                    ? (y >= 0.0 ? CGFloat(y) : 0)
                    : (y <= 0.0 ? CGFloat(y) : 0)

                var topOffset: CGFloat = 0.0
                var bottomOffset: CGFloat = 0.0
                if let offsetView = dataProvider as? BarChartView {
                    let offsetAxis = offsetView.getAxis(dataSet.axisDependency)
                    if y >= 0 {
                        if offsetAxis.axisMaximum < y {
                            topOffset = CGFloat(y - offsetAxis.axisMaximum)
                        }
                        if offsetAxis.axisMinimum > 0 {
                            bottomOffset = CGFloat(offsetAxis.axisMinimum)
                        }
                    } else {
                        if offsetAxis.axisMaximum < 0 {
                            topOffset = CGFloat(offsetAxis.axisMaximum * -1)
                        }
                        if offsetAxis.axisMinimum > y {
                            bottomOffset = CGFloat(offsetAxis.axisMinimum - y)
                        }
                    }

                    if isInverted {
                        (topOffset, bottomOffset) = (bottomOffset, topOffset)
                    }
                }
                top = isInverted ? top + topOffset : top - topOffset
                bottom = isInverted ? bottom - bottomOffset: bottom + bottomOffset

                if top > 0 + topOffset {
                    top *= CGFloat(phaseY)
                } else {
                    bottom *= CGFloat(phaseY)
                }

                barRect.origin.x = left
                barRect.origin.y = top
                barRect.size.width = right - left
                barRect.size.height = bottom - top
                buffer.rects[bufferIndex] = barRect
                bufferIndex += 1
            } else {
                var posY = 0.0
                var negY = -entry.negativeSum
                var yStart = 0.0

                for value in vals! {
                    if value == 0.0 && (posY == 0.0 || negY == 0.0) {
                        y = value
                        yStart = y
                    } else if value >= 0.0 {
                        y = posY
                        yStart = posY + value
                        posY = yStart
                    } else {
                        y = negY
                        yStart = negY + abs(value)
                        negY += abs(value)
                    }
                    let left = CGFloat(x - barWidthHalf)
                    let right = CGFloat(x + barWidthHalf)
                    var top = isInverted
                        ? (y <= yStart ? CGFloat(y) : CGFloat(yStart))
                        : (y >= yStart ? CGFloat(y) : CGFloat(yStart))
                    var bottom = isInverted
                        ? (y >= yStart ? CGFloat(y) : CGFloat(yStart))
                        : (y <= yStart ? CGFloat(y) : CGFloat(yStart))

                    top *= CGFloat(phaseY)
                    bottom *= CGFloat(phaseY)

                    barRect.origin.x = left
                    barRect.size.width = right - left
                    barRect.origin.y = top
                    barRect.size.height = bottom - top

                    buffer.rects[bufferIndex] = barRect
                    bufferIndex += 1
                }
            }
        }
    }

    func shouldDrawValues(forDataSet set: ChartDataSetProtocol) -> Bool {
        return set.isVisible && (set.isDrawValuesEnabled || set.isDrawIconsEnabled)
    }

    override func drawDataSet(context: CGContext, dataSet: BarChartDataSetProtocol, index: Int) {
        guard let dataProvider = dataProvider else { return }

        let trans = dataProvider.getTransformer(forAxis: dataSet.axisDependency)
        self.prepareBuffer(dataSet: dataSet, index: index)

        trans.rectValuesToPixel(&buffers[index].rects)
        context.saveGState()

        let buffer = buffers[index]
        let isSingleColor = dataSet.colors.count == 1

        if isSingleColor {
            context.setFillColor(dataSet.color(atIndex: 0).cgColor)
        }

        for j in 0..<buffer.rects.count {
            let barRect = buffer.rects[j]
            let bezierPath = UIBezierPath(roundedRect: barRect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))

            if (!viewPortHandler.isInBoundsLeft(barRect.origin.x + barRect.size.width)) {
                continue
            }

            if (!viewPortHandler.isInBoundsRight(barRect.origin.x)) {
                break
            }

            if !isSingleColor {
                context.setFillColor(dataSet.color(atIndex: j).cgColor)
            }

            if isSimpleChart {
                let color = dataSet.color(atIndex: j)
                color.setStroke()

                bezierPath.lineWidth = 2
                bezierPath.stroke()
                context.setFillColor(color.withAlphaComponent(0.7).cgColor)
            }

            context.addPath(bezierPath.cgPath)
            context.fillPath()
        }

        context.restoreGState()
    }
}
