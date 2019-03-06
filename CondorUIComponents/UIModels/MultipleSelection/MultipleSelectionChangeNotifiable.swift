//
//  MultipleSelectionChangeNotifiable.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 3/6/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol MultipleSelectionChangeNotifiable: class {
    func onSelected(option: Selectable, from group: MultipleSelectionFormField)
    func onDoneButtonPressed(from group: MultipleSelectionFormField)
}

public extension MultipleSelectionChangeNotifiable {
    func onDoneButtonPressed(from group: MultipleSelectionFormField) {
        // Method intentionally left in blank
    }
}
