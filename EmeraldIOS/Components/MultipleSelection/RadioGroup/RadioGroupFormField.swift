////
////  RadioGroupFormField.swift
////  EmeraldIOS
////
////  Created by Luis David Goyes Garces on 2/28/19.
////  Copyright © 2019 Condor Labs. All rights reserved.
////
//
//import Foundation
//
//protocol TestableRadioGroupFormFieldType {
//    func select(option: Selectable)
//}
//
//class RadioGroupFormField: MultipleSelectionFormField, TestableRadioGroupFormFieldType {
//
//    func select(option: Selectable) {
//        self.getChildren()?.forEach({
//            $0.set(status: $0.getAssociatedSelectable()?.getSelectableText() == option.getSelectableText())
//        })
//    }
//
//    override func onItemClicked(associatedSelectable: Selectable, from item: MultipleSelectionItemType) {
//        super.onItemClicked(associatedSelectable: associatedSelectable, from: item)
//
//        guard let radioButtonsToBeUnselected = self.getChildren()?.filter({
//            !$0.equals(item)
//        }) else {
//            return
//        }
//
//        radioButtonsToBeUnselected.forEach {
//            $0.set(status: false)
//        }
//
//        item.set(status: true)
//
//        notifiable?.onItemClicked(associatedSelectable: associatedSelectable, from: item)
//    }
//}
