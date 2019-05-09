//
//  MultipleSelectionItemChangeNotifiable.swift
//  EmeraldIOS
//
//  Created by Luis David Goyes Garces on 3/6/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public protocol SingleItemChangeNotifiable: class {
    func onItemClicked(associatedSelectable: Selectable, from item: MultipleSelectionItemType)
}
