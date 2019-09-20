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
}
