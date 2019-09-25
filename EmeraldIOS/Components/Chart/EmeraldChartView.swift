//
//  EmeraldChartView.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/18/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit
import Charts

public class EmeraldChart: UIView {
    private var presenter: EmeraldChartPresenterType!
    private var barChartView: BarChartView!
    
    public init(simpleData: [EmeraldChartSimpleDataEntry]) {
        super.init(frame: .zero)
        self.presenter = EmeraldChartPresenter()
        self.presenter.bind(view: self)
        self.presenter.setSimpleData(data: simpleData)
        setUpView()
        setupSimpleChartData()
    }
    
    public init (multipleValueData: [EmeraldChartMultipleValueDataEntry], valueColors: [UIColor]? = nil) {
        super.init(frame: .zero)
        self.presenter = EmeraldChartPresenter()
        self.presenter.bind(view: self)
        if let colors = valueColors{
            self.presenter.setMultipleValueDataSetcolors(colors: colors)
        }
        setUpView()
        presenter.setMultipleValueData(data: multipleValueData)
        setupMultipleValuesChartData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        barChartView = BarChartView(frame: .zero)
        self.addSubview(barChartView)
        barChartView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        configBarChartView()
    }
    
    private func configBarChartView() {
        barChartView.maxVisibleCount = presenter.getDataEntriesCount()
        barChartView.animate(yAxisDuration: 1)
        barChartView.xAxis.gridColor = .clear
        barChartView.leftAxis.gridColor = .clear
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelHeight = 100
        barChartView.extraBottomOffset = 40
        barChartView.rightAxis.enabled = false
        barChartView.rightAxis.gridColor = .clear
        barChartView.xAxis.labelCount = 3
        let xAxisRenderer = EmeraldChartXAxisRenderer(viewPortHandler: barChartView.viewPortHandler, xAxis: barChartView.xAxis, transformer: barChartView.getTransformer(forAxis: .left))
        xAxisRenderer.colorsDictionary = presenter.getSimpleDataSubtitleColor()
        barChartView.xAxisRenderer = xAxisRenderer
        barChartView.leftAxis.labelCount = 5
        barChartView.leftAxis.labelPosition = .outsideChart
        barChartView.drawBarShadowEnabled = false
        barChartView.drawGridBackgroundEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.legend.enabled = false
    }
    
    
    private func setupSimpleChartData() {
        var chartDataSet = [BarChartDataEntry]()
        for dataIndex in 0..<presenter.getDataEntriesCount() {
            chartDataSet.append(BarChartDataEntry(x: Double(dataIndex), y: Double(presenter.getValueForSimpleDataEntry(index: dataIndex))))
        }
        let barChartDataSet = BarChartDataSet(entries: chartDataSet, label: "")
        barChartDataSet.colors = presenter.getSimpleDataSetColors()
        barChartView.data = BarChartData(dataSet: barChartDataSet)
        barChartView.xAxis.valueFormatter  = IndexAxisValueFormatter(values: presenter.getDataHorizontalEntries())
        barChartView.data?.setDrawValues(false)
        
    }
    
    private func setupMultipleValuesChartData() {
        var chartDataSet = [BarChartDataEntry]()
        for dataIndex in 0..<presenter.getDataEntriesCount() {
            chartDataSet.append(BarChartDataEntry(x: Double(dataIndex), yValues: presenter.getValueForMultipleValueDataEntry(index: dataIndex)))
        }
        let barChartDataset = BarChartDataSet(entries: chartDataSet, label: "")
        barChartDataset.colors = presenter.getMultipleValueDataSetColors()
        barChartView.data = BarChartData(dataSet: barChartDataset)
        barChartView.xAxis.valueFormatter  = IndexAxisValueFormatter(values: presenter.getDataHorizontalEntries())
        barChartView.data?.setDrawValues(false)
    }
}
