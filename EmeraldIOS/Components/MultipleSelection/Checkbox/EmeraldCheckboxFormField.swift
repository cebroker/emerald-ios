//
//  EmeraldCheckboxFormField.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public class EmeraldCheckboxFormField: EmeraldMultipleSelectionField {
    public override func set(data: [Selectable]) {
        super.set(data: data)

        getChildren()?.forEach {
            $0.setSquareShape(true)
        }
    }
}
