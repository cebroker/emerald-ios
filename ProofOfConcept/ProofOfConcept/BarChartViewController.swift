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
    var emeraldBarChart: EmeraldChart!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        emeraldBarChart.updateView()
    }
    
    private func setupView() {
        var dataEntries = [EmeraldChartDataEntry]()
        dataEntries.append(EmeraldChartDataEntry(color: .blue, value: 20, title: "First Data", subtitle: nil, hasAction: false))
        dataEntries.append(EmeraldChartDataEntry(color: .red, value: 30, title: "Second Data", subtitle: nil, hasAction: false))
        dataEntries.append(EmeraldChartDataEntry(color: .brown, value: 20, title: "Third Data", subtitle: nil, hasAction: false))
        self.view.backgroundColor = UIColor.white
        emeraldBarChart = EmeraldChart(data: dataEntries)
        self.view.addSubview(emeraldBarChart)
        emeraldBarChart.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}

