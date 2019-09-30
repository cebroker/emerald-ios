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
        print(dataEntries.getDataEntriesCount())
        return dataEntries.getDataEntriesCount()
    }
    
    func bind(view: EmeraldChart) {
        self.chartView = view
    }
    
    func getDataHorizontalEntries() -> [String] {
        return dataEntries.getHorizontalDataEntries()
    }
    
    func getSimpleDataVerticalEntries() -> [Float] {
        return dataEntries.getSimpleDataVerticalEntries()
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
    
    func getSimpleDataSubtitles() -> [String] {
        return dataEntries.getSimpleDataSubtitles()
    }
}

protocol EmeraldChartPresenterType {
    func bind(view: EmeraldChart)
    func getDataEntriesCount() -> Int
    func getDataHorizontalEntries() -> [String]
    func setDataEntries(data: EmeraldChartDataEntry)
    
    func getSimpleDataVerticalEntries() -> [Float]
    func getSimpleDataEntries() -> [EmeraldChartSimpleDataEntry]
    func getValueForSimpleDataEntry(index: Int) -> Float
    func getSimpleDataSetColors() -> [UIColor]
    func getSimpleDataSubtitleColor() -> [String: UIColor]
    func getSimpleDataSubtitles() -> [String]
    
    func getValueForMultipleValueDataEntry(index: Int) -> [Double]
    func setMultipleValueDataSetcolors(colors: [UIColor])
    func getMultipleValueDataSetColors() -> [UIColor]
}
