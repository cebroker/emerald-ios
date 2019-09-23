//
//  EmeraldChartViewLayout.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/20/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public class EmeraldChartViewLayout: UICollectionViewLayout {
    internal var cellWidth: CGFloat = 100
    internal var verticalIncrements: Int = 5
    
    private var sideBarZIndez = Int.max
    internal var cellSize: CGSize = CGSize(width: 100, height: 100)
    internal var steps: Int = 5
    internal var verticalSideBarView: UICollectionReusableView?
    
    private let labelsZIndex = Int.max
    
    public override func prepare() {
        super.prepare()
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    public override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds)
        
        guard let collectionView = self.collectionView else {
            return context
        }
        
        if collectionView.bounds.size != newBounds.size {
            return context
        }

        return context
    }
    
    private func setAttributesForVerticalDivider(fromIndex indexPath: IndexPath) -> VerticalDividerLayoutAttributes {
        
        
        let attributes = VerticalDividerLayoutAttributes(forSupplementaryViewOfKind: "VerticalDivider", with: indexPath)
        
        if let collectionView = collectionView {
            
            let height = (collectionView.bounds.height - (collectionView.contentInset.top + collectionView.contentInset.bottom + cellSize.height)) / CGFloat(steps)
            let width = collectionView.bounds.width
            
            let frame = CGRect(x: collectionView.contentOffset.x,
                               y: height * CGFloat(indexPath.row) + cellSize.height / 2,
                               width: width,
                               height: height)
            
            attributes.frame = frame
            attributes.inset = collectionView.contentInset.left
            
            attributes.zIndex = -1
        }
        return attributes
    }
    
    private func setAttributesForVerticalLabels(fromIndex indexPath: IndexPath) -> VerticalDividerLayoutAttributes {
        
        let attributes = VerticalDividerLayoutAttributes(forSupplementaryViewOfKind: "VerticalLabels", with: indexPath)
        
        if let collectionView = collectionView {
            
            let height = (collectionView.bounds.height - (collectionView.contentInset.top + collectionView.contentInset.bottom + cellSize.height)) / CGFloat(steps)
            let width = collectionView.contentInset.left
            
            let frame = CGRect(x: collectionView.contentOffset.x,
                               y: (height * CGFloat(indexPath.row)) - (height / 2) + cellSize.height / 2,
                               width: width,
                               height: height)
            
            attributes.frame = frame
            
            attributes.zIndex = labelsZIndex
            
        }
        return attributes
    }
}
