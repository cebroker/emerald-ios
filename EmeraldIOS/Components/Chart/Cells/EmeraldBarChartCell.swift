//
//  EmeraldBarChartCell.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/20/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

class EmeraldBarChartCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var barView: UIView = {
        let view = UIView()
        return view
    }()
    
    var data: EmeraldChartCellData! {
        didSet {
            setupCellData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUIComponents()
    }
    
    private func setupCellData() {
        setLabelsText()
        setDataBar()
        setupUIComponents()
    }
    
    private func setLabelsText(){
        titleLabel.text = data.title
        titleLabel.numberOfLines = 1
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        if let subtitle = data.subtitle {
            subtitleLabel.text = subtitle
            subtitleLabel.numberOfLines = 1
            subtitleLabel.sizeToFit()
            subtitleLabel.textColor = data.color
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setDataBar(){
        let bar = CAShapeLayer()
        let barStartingPoint = (contentView.frame.width/2) - (data.barWidth/2) - 5
        let barRect = CGRect(x: barStartingPoint, y: 40, width: data.barWidth, height: data.barHeight)
        bar.path = UIBezierPath(rect: barRect).cgPath
        bar.fillColor = data.color.cgColor
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.layer.addSublayer(bar)
        
    }
    
    private func setupUIComponents() {
        
        let labelsStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        labelsStack.axis = .vertical
        labelsStack.distribution = .fillEqually
        labelsStack.spacing = 5
        labelsStack.isLayoutMarginsRelativeArrangement = true
        labelsStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8)

        labelsStack.anchor(top: nil,
                     left: contentView.leftAnchor,
                     bottom: contentView.bottomAnchor,
                     right: contentView.rightAnchor,
                     height: 50)
        
        let barViewStack = UIStackView(arrangedSubviews: [barView])
        barViewStack.axis = .vertical
        barViewStack.distribution = .fillEqually
        barViewStack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: labelsStack.topAnchor, right: contentView.rightAnchor)

        contentView.addSubview(labelsStack)
        contentView.addSubview(barViewStack)
    }
}
