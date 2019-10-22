//
//  EmeraldChartView.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/18/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit
import Charts

public enum ChartType {
    case simpleBarColor
    case multipleBarColor
}

public class EmeraldChart: UIView {

    private let presenter: EmeraldChartPresenterType = EmeraldChartPresenter()
    private let barChartView: BarChartView = BarChartView(frame: .zero)
    private let chartLabelHeight: CGFloat = 100
    private let chartExtraBottomOffset: CGFloat = 40

    private var chartType: ChartType!
    private var chartOptions: EmeraldChartOptions!
    internal var barChartRenderer: EmeraldCustomBarChartRenderer!
    internal weak var delegate: EmeraldChartViewDelegate?

    public init(
        type: ChartType = .simpleBarColor,
        data: EmeraldChartDataEntry,
        and options: EmeraldChartOptions = EmeraldChartOptions()) {
        super.init(frame: .zero)
        self.presenter.bind(view: self)
        self.chartType = type
        self.presenter.setDataEntries(data: data)
        self.chartOptions = options
        self.initialSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialSetup() {
        self.setUpView()

        switch chartType {
        case .simpleBarColor:
            self.setupSimpleChartData()
        case .multipleBarColor:
            self.presenter.setMultipleValueDataSetcolors(colors: self.chartOptions.multipleValueDataColors)
            self.setupMultipleValuesChartData()
        default: break
        }
    }

    private func setUpView() {
        self.addSubview(self.barChartView)
        self.barChartView.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            bottom: self.bottomAnchor,
            right: self.rightAnchor)
        self.configBarChartView()
    }

    private func configBarChartView() {
        self.setChartOptions()
        self.setupChartAxis()
        self.barChartView.delegate = self
        self.barChartView.animate(yAxisDuration: 1)

        if self.chartOptions.showSubtitle {
            self.barChartView.xAxis.labelHeight = chartLabelHeight
            self.barChartView.extraBottomOffset = chartExtraBottomOffset
        }

        self.barChartView.drawBarShadowEnabled = false
        self.barChartView.drawGridBackgroundEnabled = false
        self.barChartView.doubleTapToZoomEnabled = false
        self.barChartView.legend.enabled = false
        self.barChartView.maxVisibleCount = self.presenter.getDataEntriesCount()
    }

    private func setupChartAxis() {
        self.barChartView.xAxis.gridColor = .clear
        self.barChartView.xAxis.labelPosition = .bottom
        self.barChartView.xAxis.labelTextColor = self.chartOptions.titleFontColor
        self.barChartView.xAxis.labelFont = self.chartOptions.titleFont
        self.barChartView.xAxis.granularity = 1

        self.barChartView.leftAxis.enabled = self.chartOptions.showLeftAxis
        self.barChartView.leftAxis.labelTextColor = self.chartOptions.titleFontColor
        self.barChartView.leftAxis.drawAxisLineEnabled = self.chartOptions.drawLeftAxisLine
        self.barChartView.leftAxis.labelCount = self.chartOptions.steps
        self.barChartView.leftAxis.axisMinimum = 0
        self.barChartView.leftAxis.labelPosition = .outsideChart

        if chartOptions.barReachesTop { self.barChartView.leftAxis.spaceTop = 0 }
        if self.chartOptions.showGrid { self.barChartView.leftAxis.gridColor = EmeraldTheme.axisChart }

        self.barChartView.rightAxis.enabled = false
        self.barChartView.rightAxis.gridColor = .clear
    }

    private func setChartOptions() {
        self.barChartRenderer = EmeraldCustomBarChartRenderer(
            dataProvider: self.barChartView,
            animator: self.barChartView.chartAnimator,
            viewPortHandler: self.barChartView.viewPortHandler)

        self.barChartRenderer.cornerRadius = self.chartOptions.cornerRadius
        self.barChartView.renderer = barChartRenderer
    }

    private func setupSimpleChartData() {
        var chartDataSet = [BarChartDataEntry]()
        for dataIndex in 0..<self.presenter.getDataEntriesCount() {
            chartDataSet.append(
                BarChartDataEntry(
                    x: Double(dataIndex),
                    y: Double(self.presenter.getValueForSimpleDataEntry(index: dataIndex))))
        }

        let xAxisRenderer = EmeraldChartXAxisRenderer(
            viewPortHandler: self.barChartView.viewPortHandler,
            xAxis: self.barChartView.xAxis,
            transformer: self.barChartView.getTransformer(forAxis: .left),
            icon: self.chartOptions.accessoryViewImage)

        xAxisRenderer.colorsDictionary = self.presenter.getSimpleDataSubtitleColor()
        self.barChartView.xAxisRenderer = xAxisRenderer

        if self.chartOptions.showSubtitle {
            xAxisRenderer.subtitlesFont = chartOptions.subtitleFont
            xAxisRenderer.dataEntries = presenter.getSimpleDataEntries()
        }

        self.commonSetupChartData(chartDataSet, colors: self.presenter.getSimpleDataSetColors())
    }

    private func setupMultipleValuesChartData() {
        var chartDataSet = [BarChartDataEntry]()
        for dataIndex in 0..<self.presenter.getDataEntriesCount() {
            chartDataSet.append(
                BarChartDataEntry(
                    x: Double(dataIndex),
                    yValues: self.presenter.getValueForMultipleValueDataEntry(index: dataIndex)))
        }

        self.barChartView.xAxisRenderer = XAxisRenderer(
            viewPortHandler: self.barChartView.viewPortHandler,
            xAxis: self.barChartView.xAxis,
            transformer: self.barChartView.getTransformer(forAxis: .left))

        self.commonSetupChartData(chartDataSet, colors: self.presenter.getMultipleValueDataSetColors())
    }

    private func commonSetupChartData(_ data: [BarChartDataEntry], colors: [UIColor]) {
        let barChartDataSet = BarChartDataSet(entries: data, label: "")
        barChartDataSet.colors = colors
        barChartDataSet.highlightEnabled = false

        self.barChartView.data = BarChartData(dataSet: barChartDataSet)

        if !self.chartOptions.barReachesTop {
            self.barChartView.leftAxis.axisMaximum = self.presenter.getYValueOffset(
                maxYValue: self.barChartView.data!.yMax,
                steps: self.chartOptions.steps)
        }

        self.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: self.presenter.getDataHorizontalEntries())

        self.barChartView.barData?.barWidth = self.chartOptions.barWidthPercentage
        self.barChartView.data?.setDrawValues(false)
        self.barChartView.data?.notifyDataChanged()
        self.barChartView.setNeedsDisplay()
        self.barChartView.notifyDataSetChanged()
    }
}

extension EmeraldChart: ChartViewDelegate {
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        self.delegate?.didSelectItemAt(index: Int(entry.x))
    }
}
