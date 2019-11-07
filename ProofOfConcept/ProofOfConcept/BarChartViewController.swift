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

    var emeraldSimpleBarChart: EmeraldChartViewType!
    var emeraldMultipleValueBarChart: EmeraldChart!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSimpleBarChartView()
        self.setupMultipleValuesBarChartView()
    }

    private func setupSimpleBarChartView() {
        var dataEntries = [EmeraldChartSimpleDataEntry]()

        dataEntries.append(EmeraldChartSimpleDataEntry(
            color: EmeraldTheme.yellowColor,
            value: 2,
            title: "First Data",
            subtitle: nil,
            hasAction: false))

        dataEntries.append(EmeraldChartSimpleDataEntry(
            color: EmeraldTheme.greenColor,
            value: 30,
            title: "Second Data",
            subtitle: nil,
            hasAction: false))

        dataEntries.append(EmeraldChartSimpleDataEntry(
            color: EmeraldTheme.redColor,
            value: 10, title: "Third Data",
            subtitle: nil,
            hasAction: false))

        dataEntries.append(EmeraldChartSimpleDataEntry(
            color: EmeraldTheme.secondaryColor,
            value: 50,
            title: "Fourth Data",
            subtitle: nil,
            hasAction: false))

        dataEntries.append(EmeraldChartSimpleDataEntry(
            color: EmeraldTheme.Avatar.aquamarineColor,
            value: 1200,
            title: "Fifth Data",
            subtitle: nil,
            hasAction: false))

        let chartOptions = EmeraldChartOptions(
            cornerRadius: 5,
            barWidthPercentage: 0.3,
            barReachesTop: true,
            showSubtitle: true)

        let simpleData = EmeraldChartDataEntry(with: dataEntries)
        self.emeraldSimpleBarChart = EmeraldChart(options: chartOptions)
        self.emeraldSimpleBarChart.setData(simpleData)
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(emeraldSimpleBarChart as! UIView)

        (self.emeraldSimpleBarChart as! UIView).anchor(
            top: self.view.topAnchor,
            left: self.view.leftAnchor,
            bottom: nil,
            right: self.view.rightAnchor,
            height: (self.view.frame.height / 2))
    }

    private func setupMultipleValuesBarChartView() {
        let multipleVaueDataEntries =
            [EmeraldChartMultipleValueDataEntry(value: [1, 2, 3], title: "Jun"),
                EmeraldChartMultipleValueDataEntry(value: [0, 5, 0], title: "Jul"),
                EmeraldChartMultipleValueDataEntry(value: [0, 2, 3], title: "Aug"),
                EmeraldChartMultipleValueDataEntry(value: [10, 2, 0], title: "Sep"),
                EmeraldChartMultipleValueDataEntry(value: [4, 2, 2], title: "Nov"),
                EmeraldChartMultipleValueDataEntry(value: [1, 2, 22], title: "Oct")]

        let multipleValueData = EmeraldChartDataEntry(with: multipleVaueDataEntries)
        self.emeraldMultipleValueBarChart = EmeraldChart(type: .multipleBarColor, data: multipleValueData)
        self.view.addSubview(emeraldMultipleValueBarChart)

        self.emeraldMultipleValueBarChart.anchor(
            top: (emeraldSimpleBarChart as! UIView).bottomAnchor,
            left: self.view.leftAnchor,
            bottom: self.view.bottomAnchor,
            right: self.view.rightAnchor)
    }
}
