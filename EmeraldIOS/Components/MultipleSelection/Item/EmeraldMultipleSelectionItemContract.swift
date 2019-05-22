//
//  EmeraldMultipleSelectionItemContract.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public protocol SingleItemChangeNotifiable: class {
    func onItemClicked(associatedSelectable: Selectable,
                       from item: EmeraldMultipleSelectionItemType)
}
