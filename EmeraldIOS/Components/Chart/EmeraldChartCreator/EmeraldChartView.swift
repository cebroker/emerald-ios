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
    internal var delegate: EmeraldChartViewDelegate?
    private let chartOptions: EmeraldChartOptions
    var barChartRenderer: EmeraldCustomBarChartRenderer!
    private let chartLabelHeight: CGFloat = 100
    private let chartExtraBottomOffset: CGFloat = 40
    
    public init(simpleData: EmeraldChartDataEntry,
                withOptions chartOptions: EmeraldChartOptions = EmeraldChartOptions()) {
        self.chartOptions = chartOptions
        super.init(frame: .zero)
        self.presenter = EmeraldChartPresenter()
        self.presenter.bind(view: self)
        self.presenter.setDataEntries(data: simpleData)
        setUpView()
        setupSimpleChartData()
    }
    
    public init (multipleValueData: EmeraldChartDataEntry,
                 withOptions chartOptions: EmeraldChartOptions = EmeraldChartOptions()) {
        self.chartOptions = chartOptions
        super.init(frame: .zero)
        self.presenter = EmeraldChartPresenter()
        self.presenter.bind(view: self)
        presenter.setMultipleValueDataSetcolors(colors: chartOptions.multipleValueDataColors)
        presenter.setDataEntries(data: multipleValueData)
        setUpView()
        setupMultipleValuesChartData()
    }
    
    public init(withOptions chartOptions: EmeraldChartOptions = EmeraldChartOptions()) {
        self.chartOptions = chartOptions
        super.init(frame: .zero)
        self.presenter = EmeraldChartPresenter()
        self.presenter.bind(view: self)
        setUpView()
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
    
    public func updateWithMultipleValueData(_ data: EmeraldChartDataEntry){
        self.presenter.setDataEntries(data: data)
        presenter.setMultipleValueDataSetcolors(colors: chartOptions.multipleValueDataColors)
        setupMultipleValuesChartData()
    }
    
    public func updateWithSimpleData(_ data: EmeraldChartDataEntry) {
        self.presenter.setDataEntries(data: data)
        setupSimpleChartData()
    }
    
    private func setChartOptions() {
        barChartView.leftAxis.enabled = chartOptions.showLeftAxis
        if !chartOptions.showGrid { barChartView.leftAxis.gridColor = .clear }
        barChartView.leftAxis.labelCount = chartOptions.steps
        barChartView.xAxis.labelFont = chartOptions.titleFont
        self.barChartRenderer = EmeraldCustomBarChartRenderer(dataProvider: self.barChartView, animator: self.barChartView.chartAnimator, viewPortHandler: self.barChartView.viewPortHandler)
        barChartRenderer.cornerRadius = chartOptions.cornerRadius
    }
    
    private func configBarChartView() {
        setChartOptions()
        barChartView.delegate = self
        barChartView.animate(yAxisDuration: 1)
        barChartView.xAxis.gridColor = .clear
        barChartView.xAxis.labelPosition = .bottom
        barChartView.leftAxis.axisMinimum = 0
        if chartOptions.showSubtitle {
            barChartView.xAxis.labelHeight = chartLabelHeight
            barChartView.extraBottomOffset = chartExtraBottomOffset
        }
        barChartView.rightAxis.enabled = false
        barChartView.rightAxis.gridColor = .clear
        barChartView.renderer = barChartRenderer
        barChartView.leftAxis.labelPosition = .outsideChart
        barChartView.drawBarShadowEnabled = false
        barChartView.drawGridBackgroundEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.legend.enabled = false
    }
    
    
    private func setupSimpleChartData() {
        var chartDataSet = [BarChartDataEntry]()
        barChartView.maxVisibleCount = presenter.getDataEntriesCount()
        for dataIndex in 0..<presenter.getDataEntriesCount() {
            chartDataSet.append(BarChartDataEntry(x: Double(dataIndex), y: Double(presenter.getValueForSimpleDataEntry(index: dataIndex))))
        }
        let xAxisRenderer = EmeraldChartXAxisRenderer(viewPortHandler: barChartView.viewPortHandler,
                                                      xAxis: barChartView.xAxis,
                                                      transformer: barChartView.getTransformer(forAxis: .left),
                                                      icon: chartOptions.accessoryViewImage)
        xAxisRenderer.colorsDictionary = presenter.getSimpleDataSubtitleColor()
        barChartView.xAxisRenderer = xAxisRenderer
         if chartOptions.showSubtitle {
             xAxisRenderer.subtitlesFont = chartOptions.subtitleFont
             xAxisRenderer.dataEntries = presenter.getSimpleDataEntries()
         }
        let barChartDataSet = BarChartDataSet(entries: chartDataSet, label: "")
        barChartDataSet.colors = presenter.getSimpleDataSetColors()
        barChartView.data = BarChartData(dataSet: barChartDataSet)
        barChartView.xAxis.valueFormatter  = IndexAxisValueFormatter(values: presenter.getDataHorizontalEntries())
        barChartView.xAxis.granularity = 1
        barChartView.data?.setDrawValues(false)
        
    }
    
    private func setupMultipleValuesChartData() {
        var chartDataSet = [BarChartDataEntry]()
        barChartView.maxVisibleCount = presenter.getDataEntriesCount()
        for dataIndex in 0..<presenter.getDataEntriesCount() {
            chartDataSet.append(BarChartDataEntry(x: Double(dataIndex), yValues: presenter.getValueForMultipleValueDataEntry(index: dataIndex)))
        }
        let barChartDataSet = BarChartDataSet(entries: chartDataSet, label: "")
        barChartDataSet.colors = presenter.getMultipleValueDataSetColors()
        barChartView.data = BarChartData(dataSet: barChartDataSet)
        barChartView.xAxisRenderer = XAxisRenderer(viewPortHandler: barChartView.viewPortHandler,
                                                   xAxis: barChartView.xAxis,
                                                   transformer: barChartView.getTransformer(forAxis: .left))
        barChartView.xAxis.valueFormatter  = IndexAxisValueFormatter(values: presenter.getDataHorizontalEntries())
        barChartView.data?.setDrawValues(false)
        barChartView.data?.notifyDataChanged()
        barChartView.notifyDataSetChanged()
    }
}

extension EmeraldChart: ChartViewDelegate {
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        self.delegate?.didSelectItemAt(index: Int(entry.x))
    }
}
