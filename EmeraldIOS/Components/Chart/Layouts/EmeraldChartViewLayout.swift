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
    internal var dataEntries: [EmeraldChartDataEntry]?
    internal var range: (min: CGFloat, max: CGFloat)!
    private var sideBarZIndez = Int.max
    internal var cellSize: CGSize = CGSize(width: 100, height: 100)
    internal var steps: Int = 5
    internal var chartContentWidth: CGFloat?
    internal var verticalSideBarView: UICollectionReusableView?
    internal var staticAttributes: [UICollectionViewLayoutAttributes]?
    
    private let labelsZIndex = Int.max
    private let sideBarZIndex = Int.max - 1
    
    public override func prepare() {
        super.prepare()
        createStaticAttributes()
    }
    
    func createStaticAttributes() {
        self.staticAttributes = layoutAttributesForCell()
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
    
    public override var collectionViewContentSize: CGSize {
        if let collectionView = collectionView {
            
            let initialSize = collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
            
            var width = initialSize
            
            if let chartContentWidth = chartContentWidth {
                width = chartContentWidth + cellSize.width
            }
            
            let height = collectionView.bounds.height - (collectionView.contentInset.top + collectionView.contentInset.bottom + cellSize.height)
            
            let contentSize = CGSize(width: width, height: height)
            
            return contentSize
        }
        
        return CGSize(width: 200, height: 200)
    }
    
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

        let frame = CGRect(x: 0,
                           y: 0,
                           width: cellSize.width,
                           height: cellSize.height)
        
        attributes.frame = frame
        attributes.zIndex = sideBarZIndex - 1 - indexPath.item
        
        return attributes
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var attributes = [UICollectionViewLayoutAttributes]()
        
        attributes += temporaryAttributes()
        
        for staticAttributes in staticAttributes! {
            if staticAttributes.frame.intersects(rect) {
                attributes += [staticAttributes]
            }
        }
        
        return attributes
    }
    
    public override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

        let attributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: Constants.ReusableId.sideBar, with: indexPath)

        if let collectionView = collectionView {

            let width = collectionView.contentInset.left
            let height = collectionView.frame.height

            attributes.zIndex = sideBarZIndex

            attributes.frame = CGRect(x: collectionView.contentOffset.x, y: 40, width: width, height: height)
        }
        return attributes
    }
    
    public override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        switch elementKind {
        case Constants.ReusableId.verticalDivider:
            return setAttributesForVerticalDivider(fromIndex: indexPath)
        case Constants.ReusableId.verticalLabel:
            return setAttributesForVerticalLabels(fromIndex: indexPath)
        default:
            return nil
        }
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
    
    internal func temporaryAttributes() -> [UICollectionViewLayoutAttributes] {
        var tempAttributes = [UICollectionViewLayoutAttributes]()
        
        tempAttributes += self.layoutAttributesForVerticalDividerLines()
        
        tempAttributes += self.layoutAttributesForVerticalLabels()
        
        if verticalSideBarView != nil {
            tempAttributes += self.layoutAttributesForSideBar()
        }
        
        return tempAttributes
    }
    
    private func setAttributesForVerticalLabels(fromIndex indexPath: IndexPath) -> VerticalDividerLayoutAttributes {
        
        let attributes = VerticalDividerLayoutAttributes(forSupplementaryViewOfKind: Constants.ReusableId.verticalLabel, with: indexPath)
        
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
    
    private func verticalGraphPosition(indexPath: IndexPath) -> CGFloat {
        if let collectionView = collectionView {
            let delta = collectionView.bounds.height - (collectionView.contentInset.top + collectionView.contentInset.bottom + cellSize.height)
            
            let position = delta - (delta * (range.max)) + cellSize.height / 2
            
            return position.isNaN ? 0 : position
        }
        return 0
    }
    
    private func layoutAttributesForVerticalDividerLines() -> [UICollectionViewLayoutAttributes] {
        
        var tempAttributes = [UICollectionViewLayoutAttributes]()
        
        if let _ = collectionView {
            for number in 0 ..< steps {
                let indexPath = IndexPath(item: number, section: 0)
                let supplementaryAttribute = layoutAttributesForSupplementaryView(ofKind: Constants.ReusableId.verticalDivider, at: indexPath)
                if let supplementaryAttribute = supplementaryAttribute {
                    tempAttributes += [supplementaryAttribute]
                }
            }
        }
        return tempAttributes
    }
    
    private func layoutAttributesForVerticalLabels() -> [UICollectionViewLayoutAttributes] {
        
        var tempAttributes = [UICollectionViewLayoutAttributes]()
        
        for number in 0 ..< steps {
            
            let indexPath = IndexPath(item: number, section: 0)
            
            let supplementaryAttribute = layoutAttributesForSupplementaryView(ofKind: Constants.ReusableId.verticalLabel, at: indexPath)
            
            if let supplementaryAttribute = supplementaryAttribute {
                tempAttributes += [supplementaryAttribute]
            }
        }
        return tempAttributes
    }
    
    private func layoutAttributesForSideBar() -> [UICollectionViewLayoutAttributes] {
        
        var tempAttributes = [UICollectionViewLayoutAttributes]()
        
        if let _ = collectionView {
            let indexPath = IndexPath(item: 0, section: 0)
            let attribute = layoutAttributesForDecorationView(ofKind: Constants.ReusableId.sideBar, at: indexPath)
            
            if let attribute = attribute {
                tempAttributes += [attribute]
            }
        }
        
        return tempAttributes
    }
    
    private func layoutAttributesForCell() -> [UICollectionViewLayoutAttributes] {
        var tempAttributes = [UICollectionViewLayoutAttributes]()
        if let collectionView = collectionView {
            for itemNumber in 0 ..< collectionView.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: itemNumber, section: 0)
                if let attributes = layoutAttributesForItem(at: indexPath) {
                    print(attributes)
                    tempAttributes += [attributes]
                }
            }
        }
        return tempAttributes
    }
}
