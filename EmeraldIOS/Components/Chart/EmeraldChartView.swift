//
//  EmeraldChartView.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/18/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public class EmeraldChart: UIView, EmeraldChartViewType {
    private var animated = false
    private var presenter: EmeraldChartPresenterType!
    var steps: Int
    let collectionViewLayout = EmeraldChartViewLayout()
    
    var collectionView = UICollectionView()
    
    init(data: [EmeraldChartDataEntry], steps: Int){
        self.steps = steps
        super.init(frame: .zero)
        self.presenter = EmeraldChartPresenter()
        self.presenter.bind(view: self)
        presenter.setData(data: data)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configLayout() {
        collectionView.collectionViewLayout = collectionViewLayout
    }
    public func updatedata(data: [EmeraldChartDataEntry]) {
        configLayout()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getDataEntriesCount()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell", for: indexPath) as? EmeraldBarChartCell else {
            return UICollectionViewCell()
        }
        cell.data = presenter.getCellDataFor(indexPath: indexPath)

        return cell
    }
}

protocol EmeraldChartViewType: UICollectionViewDelegate, UICollectionViewDataSource {}
