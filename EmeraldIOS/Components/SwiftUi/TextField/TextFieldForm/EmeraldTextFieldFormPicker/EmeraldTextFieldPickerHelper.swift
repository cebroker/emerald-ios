//
//  EmeraldTextFieldPickerHelper.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 18/01/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import Foundation

final class EmeraldTextFieldPickerHelper {
    public var doneButtonTapped: (() -> Void)?
    
    @objc func doneButtonAction() {
        self.doneButtonTapped?()
    }
}
