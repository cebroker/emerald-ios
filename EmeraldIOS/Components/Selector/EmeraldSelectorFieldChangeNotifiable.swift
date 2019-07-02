//
//  EmeraldSelectorFieldChangeNotifiable.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 3/6/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol EmeraldSelectorFieldChangeNotifiable: class {
    func onSelected(row: Selectable?, from selector: EmeraldSelectorField)
    func onDoneButtonPressed(from selector: EmeraldSelectorField)
}

public extension EmeraldSelectorFieldChangeNotifiable {
    func onDoneButtonPressed(from selector: EmeraldSelectorField) {
        // Method intentionally left in blank
    }
}
