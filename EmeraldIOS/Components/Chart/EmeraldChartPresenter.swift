//
//  EmeraldChartPresenter.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/20/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

class EmeraldChartPresenter: RangeFinder, EmeraldChartPresenterType {
    
    
    private var barWidth: CGFloat = 0
    private let cellSpacing: CGFloat = 20
    private let bottomSpacing: CGFloat = 40
    private var chartView: EmeraldChart!
    private var dataEntries: [EmeraldChartDataEntry] = []
    
    init() {
    }
    
    private func computeBarWidth () -> CGFloat{
        let expectedEntriesSpace = CGFloat((dataEntries.count - 1) * Int(cellSpacing))
        let contentFrame = chartView.frame
        let expectedBarWidth: CGFloat = (contentFrame.width - expectedEntriesSpace - cellSpacing)/CGFloat(dataEntries.count)
        return expectedBarWidth
    }
    
     private func computeBarHeight(dataEntry: EmeraldChartDataEntry) -> CGFloat {
        let range = yDataRange(barData: dataEntries, numberOfSteps: chartView.steps)
        let contentFrame = chartView.frame
        let barHeight = (contentFrame.height * (CGFloat(dataEntry.value)/range.max)) - bottomSpacing
        return barHeight
    }
    
   
    
    func getCellDataFor(indexPath: IndexPath) -> EmeraldChartCellData{
        let dataEntry = dataEntries[indexPath.row]
        let barWidth = computeBarWidth()
        let barHeight = computeBarHeight(dataEntry: dataEntry)
        let cellData = EmeraldChartCellData(color: dataEntry.color,
                                            barHeight: barHeight,
                                            barWidth: barWidth,
                                            title: dataEntry.title,
                                            subtitle: dataEntry.subtitle,
                                            hasAction: dataEntry.hasAction)
        return cellData
    }
    
    func getCellWidth() -> CGFloat{
        return (chartView.frame.width / CGFloat(dataEntries.count))
    }
    
    func setData(data: [EmeraldChartDataEntry]) {
        dataEntries = data
    }
    
    func getDataEntriesCount() -> Int {
        return self.dataEntries.count
    }
    
    func bind(view: EmeraldChart) {
        self.chartView = view
    }
    
    func getDataRange() -> (min: CGFloat, max: CGFloat) {
        return yDataRange(barData: dataEntries, numberOfSteps: chartView.steps)
    }
    
    func getDataEntries() -> [EmeraldChartDataEntry] {
        return dataEntries
    }
}

protocol EmeraldChartPresenterType {
    func bind(view: EmeraldChart)
    func getDataEntriesCount() -> Int
    func getCellDataFor(indexPath: IndexPath) -> EmeraldChartCellData
    func getCellWidth() -> CGFloat
    func setData(data: [EmeraldChartDataEntry])
    func getDataRange() -> (min: CGFloat, max: CGFloat)
    func getDataEntries() -> [EmeraldChartDataEntry]
}
