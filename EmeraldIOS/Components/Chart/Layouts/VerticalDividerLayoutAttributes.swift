//
//  VerticalDividerLayoutAttributes.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/19/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

class VerticalDividerLayoutAttributes: UICollectionViewLayoutAttributes {
    var text: String = ""
    var inset: CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone)
        if let copy = copy as? VerticalDividerLayoutAttributes{
            copy.text = text
            copy.inset = inset
        }
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? VerticalDividerLayoutAttributes {
            if attributes.text == text && attributes.inset == inset {
                return super.isEqual(object)
            }
        }
        return false
    }
}
