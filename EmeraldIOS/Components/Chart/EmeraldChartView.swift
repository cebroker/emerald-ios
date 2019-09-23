//
//  EmeraldChartView.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/18/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public class EmeraldChart: UIView, EmeraldChartViewType {
    private var animated = false
    private var presenter: EmeraldChartPresenterType!
    var steps: Int
    private var sideBar = SideBarReusableView()
    private var collectionView: UICollectionView!
    
    public init(data: [EmeraldChartDataEntry], steps: Int = 5) {
        self.steps = steps
        super.init(frame: .zero)
        self.presenter = EmeraldChartPresenter()
        self.presenter.bind(view: self)
        self.presenter.setData(data: data)
        setupView()
        self.autoresizesSubviews = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: configLayout())
        self.addSubview(collectionView)
        collectionView.anchor(top: self.topAnchor,
                              left: self.leftAnchor,
                              bottom: self.bottomAnchor,
                              right: self.rightAnchor)
        registerCells()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .blue
        collectionView.reloadData()
    }

    public func updateView() {
        configLayout()
    }
    
    private func registerCells() {
        collectionView.register(VerticalDividerView.classForCoder(), forSupplementaryViewOfKind: Constants.ReusableId.verticalDivider, withReuseIdentifier: Constants.ReusableId.verticalDivider)
        collectionView.register(LabelView.classForCoder(), forSupplementaryViewOfKind: Constants.ReusableId.verticalLabel, withReuseIdentifier: Constants.ReusableId.verticalLabel)
        collectionView.register(EmeraldBarChartCell.self, forCellWithReuseIdentifier: Constants.ReusableId.barChartcell)
        collectionView.collectionViewLayout.register(SideBarReusableView.classForCoder(), forDecorationViewOfKind: Constants.ReusableId.sideBar)
    }
    
    @discardableResult
    private func configLayout() -> EmeraldChartViewLayout {
        let collectionViewLayout = EmeraldChartViewLayout()
        collectionViewLayout.chartContentWidth = self.frame.width
        collectionViewLayout.steps = steps
        collectionViewLayout.range = presenter.getDataRange()
        collectionViewLayout.dataEntries = presenter.getDataEntries()
        collectionViewLayout.cellSize = CGSize(width: presenter.getCellWidth(), height: self.frame.width)
        collectionViewLayout.verticalSideBarView = sideBar
        collectionViewLayout.prepare()
        return collectionViewLayout
    }

    public func updatedata(data: [EmeraldChartDataEntry]) {
        presenter.setData(data: data)
        configLayout()
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getDataEntriesCount()
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReusableId.barChartcell, for: indexPath) as? EmeraldBarChartCell else {
            return UICollectionViewCell()
        }
        cell.data = presenter.getCellDataFor(indexPath: indexPath)

        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(presenter.getCellWidth())
        return CGSize(width: presenter.getCellWidth(), height: self.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case Constants.ReusableId.sideBar:
            let sideBar = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.ReusableId.sideBar, for: indexPath)
            return sideBar
        case Constants.ReusableId.verticalDivider:
            let verticalDivider = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.ReusableId.verticalDivider, for: indexPath)
            return verticalDivider
        case Constants.ReusableId.verticalLabel:
            let verticalLabel = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.ReusableId.verticalLabel, for: indexPath)
            return verticalLabel
        default:
            return UICollectionReusableView()
        }
    }
}

protocol EmeraldChartViewType: UICollectionViewDelegate, UICollectionViewDataSource {}
