//
//  VerticalDividerView.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/19/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

class VerticalDividerView: UICollectionReusableView {
    var line = CAShapeLayer()
    var lineWidth: CGFloat = 1
    var lineColor = UIColor.lightGray
    var textColor = UIColor.darkText
    var inset: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        if let attributes = layoutAttributes as? VerticalDividerLayoutAttributes {
            inset = attributes.inset
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawLine()
    }
    
    func viewSetup() {
        line.fillColor = UIColor.clear.cgColor
        line.strokeColor = lineColor.cgColor
        line.lineWidth = lineWidth
        layer.addSublayer(line)
    }
    
    func drawLine() {
        let start = CGPoint(x: self.bounds.minX + inset, y: self.bounds.minY)
        let end = CGPoint(x: self.bounds.maxX, y: self.bounds.minY)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        self.line.path = path.cgPath
    }
}
