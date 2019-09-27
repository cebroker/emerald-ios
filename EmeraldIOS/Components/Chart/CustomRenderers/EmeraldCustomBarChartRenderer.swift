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
    internal var cornerRadius: CGFloat = 0
    private class Buffer {
        var rects = [CGRect]()
    }
    
    private var buffers = [Buffer]()
    private var barShadowRectBuffer: CGRect = CGRect()
    
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
            
            for i in stride(from: 0, to: barData.dataSetCount, by: 1)  {
                let set = barData.dataSets[i] as! IBarChartDataSet
                let size = set.entryCount * (set.isStacked ? set.stackSize : 1)
                if buffers[i].rects.count != size {
                    buffers[i].rects = [CGRect](repeating: CGRect(), count: size)
                }
            }
        }
        else {
            buffers.removeAll()
        }
    }
    
    private func prepareBuffer(dataSet: IBarChartDataSet, index: Int) {
        guard
            let dataProvider = dataProvider,
            let barData = dataProvider.barData
            else { return }
        
        let barWidthHalf = barData.barWidth / 2.0
    
        let buffer = buffers[index]
        var bufferIndex = 0
        let containsStacks = dataSet.isStacked
        
        let isInverted = dataProvider.isInverted(axis: dataSet.axisDependency)
        let phaseY = animator.phaseY
        var barRect = CGRect()
        var x: Double
        var y: Double

        
        for i in stride(from: 0, to: min(Int(ceil(Double(dataSet.entryCount) * animator.phaseX)), dataSet.entryCount), by: 1) {
            guard let e = dataSet.entryForIndex(i) as? BarChartDataEntry else { continue }
            
            let vals = e.yValues

            x = e.x
            y = e.y

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
                bottom = isInverted ? bottom - bottomOffset : bottom + bottomOffset
                
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
                var negY = -e.negativeSum
                var yStart = 0.0
                
                for k in 0 ..< vals!.count {
                    let value = vals![k]
                    
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
            guard
                let dataProvider = dataProvider,
                let barData = dataProvider.barData
                else { return }

            let dataSets = barData.dataSets

            let valueOffsetPlus: CGFloat = 4.5
            var posOffset: CGFloat
            var negOffset: CGFloat
            let drawValueAboveBar = dataProvider.isDrawValueAboveBarEnabled
            
            for dataSetIndex in 0 ..< barData.dataSetCount {
                guard let
                    dataSet = dataSets[dataSetIndex] as? IBarChartDataSet,
                    shouldDrawValues(forDataSet: dataSet)
                    else { continue }
                
                let isInverted = dataProvider.isInverted(axis: dataSet.axisDependency)
                
                // calculate the correct offset depending on the draw position of the value
                let valueFont = dataSet.valueFont
                let valueTextHeight = valueFont.lineHeight
                posOffset = (drawValueAboveBar ? -(valueTextHeight + valueOffsetPlus) : valueOffsetPlus)
                negOffset = (drawValueAboveBar ? valueOffsetPlus : -(valueTextHeight + valueOffsetPlus))
                
                if isInverted {
                    posOffset = -posOffset - valueTextHeight
                    negOffset = -negOffset - valueTextHeight
                }
                
                let buffer = buffers[dataSetIndex]
                
                guard let formatter = dataSet.valueFormatter else { continue }
                
                let trans = dataProvider.getTransformer(forAxis: dataSet.axisDependency)
                
                let phaseY = animator.phaseY
                
                let iconsOffset = dataSet.iconsOffset
        
                if !dataSet.isStacked {
                    for j in 0 ..< Int(ceil(Double(dataSet.entryCount) * animator.phaseX)) {
                        guard let e = dataSet.entryForIndex(j) as? BarChartDataEntry else { continue }
                        
                        let rect = buffer.rects[j]
                        
                        let x = rect.origin.x + rect.size.width / 2.0
                        
                        if !viewPortHandler.isInBoundsRight(x) {
                            break
                        }
                        
                        if !viewPortHandler.isInBoundsY(rect.origin.y)
                            || !viewPortHandler.isInBoundsLeft(x) {
                            continue
                        }
                        
                        let val = e.y
                        
                        if dataSet.isDrawValuesEnabled {
                            drawValue(
                                context: context,
                                value: formatter.stringForValue(
                                    val,
                                    entry: e,
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
                        
                        if let icon = e.icon, dataSet.isDrawIconsEnabled {
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
                        guard let e = dataSet.entryForIndex(index) as? BarChartDataEntry else { continue }
                        
                        let vals = e.yValues
                        
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
                                        e.y,
                                        entry: e,
                                        dataSetIndex: dataSetIndex,
                                        viewPortHandler: viewPortHandler),
                                    xPos: x,
                                    yPos: rect.origin.y +
                                        (e.y >= 0 ? posOffset : negOffset),
                                    font: valueFont,
                                    align: .center,
                                    color: dataSet.valueTextColorAt(index))
                            }
                            
                            if let icon = e.icon, dataSet.isDrawIconsEnabled {
                                var px = x
                                var py = rect.origin.y +
                                    (e.y >= 0 ? posOffset : negOffset)
                                
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
                            var negY = -e.negativeSum
                            
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
                                
                                if dataSet.isDrawValuesEnabled  {
                                    drawValue(
                                        context: context,
                                        value: formatter.stringForValue(
                                            vals[k],
                                            entry: e,
                                            dataSetIndex: dataSetIndex,
                                            viewPortHandler: viewPortHandler),
                                        xPos: x,
                                        yPos: y,
                                        font: valueFont,
                                        align: .center,
                                        color: dataSet.valueTextColorAt(index))
                                }
                                
                                if let icon = e.icon, dataSet.isDrawIconsEnabled {
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

                prepareBuffer(dataSet: dataSet, index: index)
                trans.rectValuesToPixel(&buffers[index].rects)
                
                context.saveGState()
                
                if dataProvider.isDrawBarShadowEnabled {
                    guard let barData = dataProvider.barData else { return }
                    
                    let barWidth = barData.barWidth
                    let barWidthHalf = barWidth / 2.0
                    var x: Double = 0.0
                    
                    for i in stride(from: 0,
                                    to: min(Int(ceil(Double(dataSet.entryCount) * animator.phaseX)),
                                            dataSet.entryCount), by: 1) {
                        guard let e = dataSet.entryForIndex(i) as? BarChartDataEntry else { continue }
                        
                        x = e.x
                        
                        barShadowRectBuffer.origin.x = CGFloat(x - barWidthHalf)
                        barShadowRectBuffer.size.width = CGFloat(barWidth)
                        
                        trans.rectValueToPixel(&barShadowRectBuffer)
                        
                        if !viewPortHandler.isInBoundsLeft(barShadowRectBuffer.origin.x + barShadowRectBuffer.size.width) {
                            continue
                        }
                        
                        if !viewPortHandler.isInBoundsRight(barShadowRectBuffer.origin.x) {
                            break
                        }
                        
                        barShadowRectBuffer.origin.y = viewPortHandler.contentTop
                        barShadowRectBuffer.size.height = viewPortHandler.contentHeight
                        
                        context.setFillColor(dataSet.barShadowColor.cgColor)
                        context.fill(barShadowRectBuffer)
                    }
                }

                let buffer = buffers[index]
                
                if dataProvider.isDrawBarShadowEnabled {
                    for j in stride(from: 0, to: buffer.rects.count, by: 1)  {
                        let barRect = buffer.rects[j]
                        
                        if (!viewPortHandler.isInBoundsLeft(barRect.origin.x + barRect.size.width)) {
                            continue
                        }
                        
                        if (!viewPortHandler.isInBoundsRight(barRect.origin.x)) {
                            break
                        }
                        
                        context.setFillColor(dataSet.barShadowColor.cgColor)
                        context.fill(barRect)
                    }
                }
                
                let isSingleColor = dataSet.colors.count == 1
                
                if isSingleColor {
                    context.setFillColor(dataSet.color(atIndex: 0).cgColor)
                }

                for j in stride(from: 0, to: buffer.rects.count, by: 1) {
                    let barRect = buffer.rects[j]
                    let bezierPath = UIBezierPath(roundedRect: barRect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))

                    let roundedPath = bezierPath.cgPath

                    if (!viewPortHandler.isInBoundsLeft(barRect.origin.x + barRect.size.width)) {
                        continue
                    }
                    
                    if (!viewPortHandler.isInBoundsRight(barRect.origin.x)) {
                        break
                    }
                    
                    if !isSingleColor {
                        context.setFillColor(dataSet.color(atIndex: j).cgColor)
                    }
                    context.addPath(roundedPath)
                    
                    context.fillPath()
                }
                
                context.restoreGState()
    }
}
