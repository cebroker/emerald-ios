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

            let dataSets = barData.dataSets.compactMap({ $0 as? IBarChartDataSet })
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

    private func prepareBuffer(dataSet: IBarChartDataSet, index: Int) {
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

    override func drawValues(context: CGContext) {
        if isDrawingValuesAllowed(dataProvider: dataProvider) {
            guard let dataProvider = dataProvider,
                let barData = dataProvider.barData else {
                    return
            }

            let dataSets = barData.dataSets
            let valueOffsetPlus: CGFloat = 4.5
            let drawValueAboveBar = dataProvider.isDrawValueAboveBarEnabled
            var posOffset: CGFloat
            var negOffset: CGFloat

            for dataSetIndex in 0 ..< barData.dataSetCount {
                guard let dataSet = dataSets[dataSetIndex] as? IBarChartDataSet,
                    shouldDrawValues(forDataSet: dataSet)
                    else { continue }

                // calculate the correct offset depending on the draw position of the value
                let valueFont = dataSet.valueFont
                let valueTextHeight = valueFont.lineHeight
                posOffset = (drawValueAboveBar ? -(valueTextHeight + valueOffsetPlus) : valueOffsetPlus)
                negOffset = (drawValueAboveBar ? valueOffsetPlus : -(valueTextHeight + valueOffsetPlus))

                let buffer = buffers[dataSetIndex]
                
                guard let formatter = dataSet.valueFormatter else { continue }

                let trans = dataProvider.getTransformer(forAxis: dataSet.axisDependency)

                let phaseY = animator.phaseY

                let iconsOffset = dataSet.iconsOffset
                
                if !dataSet.isStacked {
                    for j in 0 ..< Int(ceil(Double(dataSet.entryCount) * animator.phaseX)) {
                        guard let entry = dataSet.entryForIndex(j) as? BarChartDataEntry else { continue }

                        let rect = buffer.rects[j]

                        let x = rect.origin.x + rect.size.width / 2.0

                        if !viewPortHandler.isInBoundsRight(x) {
                            break
                        }

                        if !viewPortHandler.isInBoundsY(rect.origin.y)
                            || !viewPortHandler.isInBoundsLeft(x) {
                            continue
                        }

                        let val = entry.y

                        if dataSet.isDrawValuesEnabled {
                            drawValue(
                                context: context,
                                value: formatter.stringForValue(
                                    val,
                                    entry: entry,
                                    dataSetIndex: dataSetIndex,
                                    viewPortHandler: viewPortHandler),
                                xPos: x,
                                yPos: val >= 0.0
                                    ? (rect.origin.y + posOffset)
                                    : (rect.origin.y + rect.size.height + negOffset),
                                font: valueFont,
                                align: .center,
                                color: dataSet.valueTextColorAt(j))
                        }

                        if let icon = entry.icon, dataSet.isDrawIconsEnabled {
                            var px = x
                            var py = val >= 0.0
                                ? (rect.origin.y + posOffset)
                                : (rect.origin.y + rect.size.height + negOffset)

                            px += iconsOffset.x
                            py += iconsOffset.y

                            ChartUtils.drawImage(
                                context: context,
                                image: icon,
                                x: px,
                                y: py,
                                size: icon.size)
                        }
                    }
                } else {

                    var bufferIndex = 0

                    for index in 0 ..< Int(ceil(Double(dataSet.entryCount) * animator.phaseX)) {
                        guard let entry = dataSet.entryForIndex(index) as? BarChartDataEntry else { continue }

                        let vals = entry.yValues

                        let rect = buffer.rects[bufferIndex]

                        let x = rect.origin.x + rect.size.width / 2.0

                        // we still draw stacked bars, but there is one non-stacked in between
                        if vals == nil {
                            if !viewPortHandler.isInBoundsRight(x) {
                                break
                            }

                            if !viewPortHandler.isInBoundsY(rect.origin.y)
                                || !viewPortHandler.isInBoundsLeft(x) {
                                continue
                            }

                            if dataSet.isDrawValuesEnabled {
                                drawValue(
                                    context: context,
                                    value: formatter.stringForValue(
                                        entry.y,
                                        entry: entry,
                                        dataSetIndex: dataSetIndex,
                                        viewPortHandler: viewPortHandler),
                                    xPos: x,
                                    yPos: rect.origin.y +
                                        (entry.y >= 0 ? posOffset : negOffset),
                                    font: valueFont,
                                    align: .center,
                                    color: dataSet.valueTextColorAt(index))
                            }

                            if let icon = entry.icon, dataSet.isDrawIconsEnabled {
                                var px = x
                                var py = rect.origin.y +
                                    (entry.y >= 0 ? posOffset : negOffset)

                                px += iconsOffset.x
                                py += iconsOffset.y

                                ChartUtils.drawImage(
                                    context: context,
                                    image: icon,
                                    x: px,
                                    y: py,
                                    size: icon.size)
                            }
                        } else {

                            let vals = vals!
                            var transformed = [CGPoint]()

                            var posY = 0.0
                            var negY = -entry.negativeSum

                            for k in 0 ..< vals.count {
                                let value = vals[k]
                                var y: Double

                                if value == 0.0 && (posY == 0.0 || negY == 0.0) {
                                    y = value
                                } else if value >= 0.0 {
                                    posY += value
                                    y = posY
                                } else {
                                    y = negY
                                    negY -= value
                                }

                                transformed.append(CGPoint(x: 0.0, y: CGFloat(y * phaseY)))
                            }

                            trans.pointValuesToPixel(&transformed)

                            for k in 0 ..< transformed.count {
                                let val = vals[k]
                                let drawBelow = (val == 0.0 && negY == 0.0 && posY > 0.0) || val < 0.0
                                let y = transformed[k].y + (drawBelow ? negOffset : posOffset)

                                if !viewPortHandler.isInBoundsRight(x) {
                                    break
                                }

                                if !viewPortHandler.isInBoundsY(y) || !viewPortHandler.isInBoundsLeft(x) {
                                    continue
                                }

                                if dataSet.isDrawValuesEnabled {
                                    drawValue(
                                        context: context,
                                        value: formatter.stringForValue(
                                            vals[k],
                                            entry: entry,
                                            dataSetIndex: dataSetIndex,
                                            viewPortHandler: viewPortHandler),
                                        xPos: x,
                                        yPos: y,
                                        font: valueFont,
                                        align: .center,
                                        color: dataSet.valueTextColorAt(index))
                                }

                                if let icon = entry.icon, dataSet.isDrawIconsEnabled {
                                    ChartUtils.drawImage(
                                        context: context,
                                        image: icon,
                                        x: x + iconsOffset.x,
                                        y: y + iconsOffset.y,
                                        size: icon.size)
                                }
                            }
                        }

                        bufferIndex = vals == nil ? (bufferIndex + 1) : (bufferIndex + vals!.count)
                    }
                }
            }
        }
    }

    func shouldDrawValues(forDataSet set: IChartDataSet) -> Bool {
        return set.isVisible && (set.isDrawValuesEnabled || set.isDrawIconsEnabled)
    }

    override func drawDataSet(context: CGContext, dataSet: IBarChartDataSet, index: Int) {
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
