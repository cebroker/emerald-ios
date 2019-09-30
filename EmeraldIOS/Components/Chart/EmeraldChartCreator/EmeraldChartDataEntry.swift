//
//  EmeraldChartDataEntry.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/13/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation
import Charts

public class EmeraldChartDataEntry: EmeraldChartDataType{
    var simpleDataEntries: [EmeraldChartSimpleDataEntry]?
    var multipleValueDataEntries: [EmeraldChartMultipleValueDataEntry]?
    
    public init(with simpleData: [EmeraldChartSimpleDataEntry]) {
        self.simpleDataEntries = simpleData
    }
    
    public init(with multipleValueData: [EmeraldChartMultipleValueDataEntry]) {
        self.multipleValueDataEntries = multipleValueData
    }
    
    func getDataEntriesCount() -> Int {
        if let dataEntries = simpleDataEntries {
            return dataEntries.count
        } else if let dataEntries = multipleValueDataEntries {
            return dataEntries.count
        }
        return 0
    }
    
    func getHorizontalDataEntries() -> [String] {
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
    
    func getSimpleDataSubtitleColor() -> [String: UIColor] {
        var colorsDict = [String: UIColor]()
        if let entries = simpleDataEntries {
            for i in stride(from: 0, to: entries.count, by: 1) {
                colorsDict[entries[i].title] = entries[i].color
            }
        }
        return colorsDict
    }
    
    func getSimpleDataSubtitles() -> [String] {
        var subtitles = [String]()
        if let entries = simpleDataEntries {
            for entry in entries {
                subtitles.append(String(entry.value))
            }
        }
        return subtitles
    }
    
    func getValueForMultipleValueDataEntry(index: Int) -> [Double] {
        var values = [Double]()
        if let dataEntries = multipleValueDataEntries {
            values = dataEntries[index].value.compactMap{value in Double(value)}
        }
        return values
    }
}

protocol EmeraldChartDataType {
    func getDataEntriesCount() -> Int
    func getHorizontalDataEntries() -> [String]
    
    func getSimpleDataVerticalEntries() -> [Float]
    func getSimpleDataEntries() -> [EmeraldChartSimpleDataEntry]
    func getValueForSimpleDataEntry(index: Int) -> Float
    func getSimpleDataSetColors() -> [UIColor]
    func getSimpleDataSubtitleColor() -> [String: UIColor]
    func getSimpleDataSubtitles() -> [String]
    
    func getValueForMultipleValueDataEntry(index: Int) -> [Double]
}

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
