//
//  BarChartViewController.swift
//  ProofOfConcept
//
//  Created by Miguel Roncallo on 9/23/19.
//  Copyright © 2019 Luis David Goyes Garces. All rights reserved.
//

import UIKit
import EmeraldIOS

class BarChartViewController: UIViewController {
    var emeraldSimpleBarChart: EmeraldChart!
    var emeraldMultipleValueBarChart: EmeraldChart!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSimpleBarChartView()
        setupMultipleValuesBarChartView()
    }
    
    private func setupSimpleBarChartView() {
        var dataEntries = [EmeraldChartSimpleDataEntry]()
        dataEntries.append(EmeraldChartSimpleDataEntry(color: EmeraldTheme.yellowColor,
                                                       value: 20, title: "First Data",
                                                       subtitle: nil,
                                                       hasAction: false))
        dataEntries.append(EmeraldChartSimpleDataEntry(color: EmeraldTheme.greenColor,
                                                       value: 30,
                                                       title: "Second Data",
                                                       subtitle: nil,
                                                       hasAction: false))
        dataEntries.append(EmeraldChartSimpleDataEntry(color: EmeraldTheme.redColor,
                                                       value: 10, title: "Third Data",
                                                       subtitle: nil,
                                                       hasAction: false))
        dataEntries.append(EmeraldChartSimpleDataEntry(color: EmeraldTheme.secondaryColor,
                                                       value: 50,
                                                       title: "Fourth Data",
                                                       subtitle: nil,
                                                       hasAction: false))
        dataEntries.append(EmeraldChartSimpleDataEntry(color: EmeraldTheme.Avatar.aquamarineColor,
                                                       value: 100,
                                                       title: "Fifth Data",
                                                       subtitle: nil,
                                                       hasAction: false))
        self.view.backgroundColor = UIColor.white
        let chartOptions = EmeraldChartOptions(cornerRadius: 5, showSubtitle: true)
        let simpleData = EmeraldChartDataEntry(with: dataEntries)
        emeraldSimpleBarChart = EmeraldChart(simpleData: simpleData, withOptions: chartOptions)
        self.view.addSubview(emeraldSimpleBarChart)
        emeraldSimpleBarChart.anchor(top: self.view.topAnchor,
                                     left: self.view.leftAnchor,
                                     bottom: nil,
                                     right: self.view.rightAnchor,
                                     height: (self.view.frame.height/2))
    }
    
    private func setupMultipleValuesBarChartView() {
        let dataEntries =
            [EmeraldChartMultipleValueDataEntry(value: [1,2,3], title: "Jun"),
             EmeraldChartMultipleValueDataEntry(value: [0,5,0], title: "Jul"),
             EmeraldChartMultipleValueDataEntry(value: [0,2,3], title: "Aug"),
             EmeraldChartMultipleValueDataEntry(value: [10,2,0], title: "Sep"),
             EmeraldChartMultipleValueDataEntry(value: [4,2,2], title: "Nov"),
             EmeraldChartMultipleValueDataEntry(value: [1,2,22], title: "Oct")]
        let multipleValueData = EmeraldChartDataEntry(with: dataEntries)
        emeraldMultipleValueBarChart = EmeraldChart(multipleValueData: multipleValueData)
        self.view.addSubview(emeraldMultipleValueBarChart)
        emeraldMultipleValueBarChart.anchor(top: emeraldSimpleBarChart.bottomAnchor,
                                            left: self.view.leftAnchor,
                                            bottom: self.view.bottomAnchor,
                                            right: self.view.rightAnchor)
        
    }
}

