//
//  TextViewType.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra Jimenez on 7/12/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import Foundation

public enum TextViewType {
    case normal
    case numeric
    
    func getKeyboardType() -> UIKeyboardType {
        switch self {
        case .normal:
            return .default
        case .numeric:
            return .numberPad
        }
    }
    
    func getTextFormat() -> TextFormat {
        return .none
    }
}
