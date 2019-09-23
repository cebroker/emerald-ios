//
//  LabelViewAttributes.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/23/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

class XLabelViewAttributes: UICollectionViewLayoutAttributes {
    var text = ""
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone)
        if let copy = copy as? XLabelViewAttributes {
            copy.text = text
        }
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? XLabelViewAttributes {
            if attributes.text == text {
                return super.isEqual(object)
            }
        }
        return false
    }
    
}
