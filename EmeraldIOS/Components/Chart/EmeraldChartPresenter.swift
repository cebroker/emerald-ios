//
//  EmeraldChartPresenter.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/20/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

class EmeraldChartPresenter: EmeraldChartPresenterType {
    
    private var barWidth: CGFloat = 0
    private let cellSpacing: CGFloat = 20
    private let bottomSpacing: CGFloat = 40
    private var chartView: EmeraldChart!
    private var simpleDataEntries: [EmeraldChartSimpleDataEntry]?
    private var multipleValueDataEntries: [EmeraldChartMultipleValueDataEntry]?
    private var multipleValueColors = [EmeraldTheme.Chart.correctData, EmeraldTheme.Chart.warningData, EmeraldTheme.Chart.criticalData]
    
    init() {
    }
    
    func setSimpleData(data: [EmeraldChartSimpleDataEntry]) {
        simpleDataEntries = data
    }
    
    func getDataEntriesCount() -> Int {
        if let dataEntries = simpleDataEntries {
            return dataEntries.count
        } else if let dataEntries = multipleValueDataEntries {
            return dataEntries.count
        }
        return 0
    }
    
    func bind(view: EmeraldChart) {
        self.chartView = view
    }
    
    func getDataHorizontalEntries() -> [String] {
        var labels = [String]()
        if let dataEntries = simpleDataEntries {
            for entry in dataEntries {
                labels.append(entry.title)
            }
        } else if let dataEntries = multipleValueDataEntries {
            for entry in dataEntries {
                labels.append(entry.title)
            }
        }
        return labels
    }
    
    func getSimpleDataVerticalEntries() -> [Float] {
        var values = [Float]()
        if let dataEntries = simpleDataEntries {
            for entry in dataEntries {
                values.append(entry.value)
            }
        }
        return values
    }

    func getSimpleDataEntries() -> [EmeraldChartSimpleDataEntry] {
        if let dataEntries = simpleDataEntries {
            return dataEntries
        }
        return [EmeraldChartSimpleDataEntry]()
    }
    
    func getValueForSimpleDataEntry(index: Int) -> Float {
        if let dataEntries = simpleDataEntries{
            return dataEntries[index].value
        }
        return 0
    }
    
    func getSimpleDataSetColors() -> [UIColor] {
        var colors = [UIColor]()
        if let dataEntries = simpleDataEntries {
            for entry in dataEntries {
                colors.append(entry.color)
            }
        }
        return colors
    }
    
    func getValueForMultipleValueDataEntry(index: Int) -> [Double] {
        if let dataEntries = multipleValueDataEntries {
            let values = dataEntries[index].value.compactMap{value in Double(value)}
            return values
        }
        return [Double]()
    }
    
    func getMultipleValueDataSetColors() -> [UIColor] {
        return multipleValueColors
    }
    
    func setMultipleValueDataSetcolors(colors: [UIColor]) {
        self.multipleValueColors = colors
    }
    
    func setMultipleValueData(data: [EmeraldChartMultipleValueDataEntry]) {
        self.multipleValueDataEntries = data
    }
    
    func getSimpleDataSubtitleColor() -> [String: UIColor] {
        var colorsDict = [String: UIColor]()
        if let entries = simpleDataEntries {
            for i in stride(from: 0, to: entries.count, by: 1) {
                colorsDict[entries[i].title] = entries[i].color
            }
        }
        
        return colorsDict
    }
}

protocol EmeraldChartPresenterType {
    func bind(view: EmeraldChart)
    func getDataEntriesCount() -> Int
    func getDataHorizontalEntries() -> [String]
    
    func setSimpleData(data: [EmeraldChartSimpleDataEntry])
    func getSimpleDataVerticalEntries() -> [Float]
    func getSimpleDataEntries() -> [EmeraldChartSimpleDataEntry]
    func getValueForSimpleDataEntry(index: Int) -> Float
    func getSimpleDataSetColors() -> [UIColor]
    func getSimpleDataSubtitleColor() -> [String: UIColor]
    
    func getValueForMultipleValueDataEntry(index: Int) -> [Double]
    func setMultipleValueDataSetcolors(colors: [UIColor])
    func getMultipleValueDataSetColors() -> [UIColor]
    func setMultipleValueData(data: [EmeraldChartMultipleValueDataEntry])
}
