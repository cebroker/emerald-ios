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
        dataEntries.append(EmeraldChartSimpleDataEntry(color: EmeraldTheme.Chart.correctData , value: 20, title: "First Data", subtitle: nil, hasAction: false))
        dataEntries.append(EmeraldChartSimpleDataEntry(color: EmeraldTheme.Chart.warningData, value: 30, title: "Second Data", subtitle: nil, hasAction: false))
        dataEntries.append(EmeraldChartSimpleDataEntry(color: EmeraldTheme.Chart.criticalData, value: 10, title: "Third Data", subtitle: nil, hasAction: false))
        self.view.backgroundColor = UIColor.white
        emeraldSimpleBarChart = EmeraldChart(simpleData: dataEntries)
        self.view.addSubview(emeraldSimpleBarChart)
        emeraldSimpleBarChart.anchor(top: nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, height: (self.view.frame.height/2))
    }
    
    private func setupMultipleValuesBarChartView() {
        let dataEntries =
            [
                EmeraldChartMultipleValueDataEntry(value: [1,2,3], title: "June"),
                EmeraldChartMultipleValueDataEntry(value: [0,5,0], title: "July"),
                EmeraldChartMultipleValueDataEntry(value: [0,2,3], title: "August"),
                EmeraldChartMultipleValueDataEntry(value: [10,2,0], title: "September"),
                EmeraldChartMultipleValueDataEntry(value: [4,2,2], title: "November"),
                EmeraldChartMultipleValueDataEntry(value: [1,2,22], title: "October")]
        emeraldMultipleValueBarChart = EmeraldChart(multipleValueData: dataEntries)
        self.view.addSubview(emeraldMultipleValueBarChart)
        emeraldMultipleValueBarChart.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, height: (self.view.frame.height/2) - 50)
        
    }
}

