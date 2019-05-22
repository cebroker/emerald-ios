//
//  EmeraldRadioGroupFormField.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public class EmeraldRadioGroupFormField: EmeraldMultipleSelectionField {
    public override func onItemClicked(associatedSelectable: Selectable,
                                from item: EmeraldMultipleSelectionItemType) {
        super.onItemClicked(associatedSelectable: associatedSelectable, from: item)

        guard let radioButtonsToBeUnselected = self.getChildren()?.filter({
            !$0.equals(item)
        }) else {
            return
        }

        radioButtonsToBeUnselected.forEach {
            $0.set(status: false)
        }

        item.set(status: true)

        notifiable?.onItemClicked(associatedSelectable: associatedSelectable, from: item)
    }
}
