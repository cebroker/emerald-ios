//
//  SelectorFormFieldChangeNotifiable.swift
//  EmeraldIOS
//
//  Created by Luis David Goyes Garces on 3/6/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol SelectorFormFieldChangeNotifiable: class {
    func onSelected(row: Selectable, from selector: SelectorFormField)
    func onDoneButtonPressed(from selector: SelectorFormField)
}

public extension SelectorFormFieldChangeNotifiable {
    func onDoneButtonPressed(from selector: SelectorFormField) {
        // Method intentionally left in blank
    }
}
