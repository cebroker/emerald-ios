//
//  EmeraldChartPresenter.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/20/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

class EmeraldChartPresenter: EmeraldChartPresenterType {

    private var chartView: EmeraldChart!
    private var dataEntries: EmeraldChartDataEntry!
    private var multipleValueColors = [UIColor]()

    func setDataEntries(data: EmeraldChartDataEntry) {
        dataEntries = data
    }
    
    func getDataEntriesCount() -> Int {
        return dataEntries.getDataEntriesCount()
    }
    
    func bind(view: EmeraldChart) {
        self.chartView = view
    }
    
    func getDataHorizontalEntries() -> [String] {
        return dataEntries.getHorizontalDataEntries()
    }

    func getSimpleDataEntries() -> [EmeraldChartSimpleDataEntry] {
        return dataEntries.getSimpleDataEntries()
    }
    
    func getValueForSimpleDataEntry(index: Int) -> Float {
        return dataEntries.getValueForSimpleDataEntry(index: index)
    }
    
    func getSimpleDataSetColors() -> [UIColor] {
        return dataEntries.getSimpleDataSetColors()
    }
    
    func getValueForMultipleValueDataEntry(index: Int) -> [Double] {
        return dataEntries.getValueForMultipleValueDataEntry(index: index)
    }
    
    func getMultipleValueDataSetColors() -> [UIColor] {
        return multipleValueColors
    }
    
    func setMultipleValueDataSetcolors(colors: [UIColor]) {
        self.multipleValueColors = colors
    }
    
    func getSimpleDataSubtitleColor() -> [String: UIColor] {
        return dataEntries.getSimpleDataSubtitleColor()
    }
    
    func getYValueOffset(maxYValue: Double, steps: Int) -> Double {
        return maxYValue + (maxYValue/Double(steps))
    }
}

protocol EmeraldChartPresenterType {
    func bind(view: EmeraldChart)
    func setDataEntries(data: EmeraldChartDataEntry)
    func setMultipleValueDataSetcolors(colors: [UIColor])
    func getDataEntriesCount() -> Int
    func getValueForSimpleDataEntry(index: Int) -> Float
    func getSimpleDataSubtitleColor() -> [String: UIColor]
    func getSimpleDataEntries() -> [EmeraldChartSimpleDataEntry]
    func getSimpleDataSetColors() -> [UIColor]
    func getValueForMultipleValueDataEntry(index: Int) -> [Double]
    func getDataHorizontalEntries() -> [String]
    func getMultipleValueDataSetColors() -> [UIColor]
    func getYValueOffset(maxYValue: Double, steps: Int) -> Double
}
