//
//  ActivityIndicatorType.swift
//  EmeraldIOS
//
//  Created by Cristopher Escorcia on 18/08/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI

public enum ActivityIndicatorType {
    case medium
    case large
    
    func getSize() -> CGFloat {
        switch self {
        case .medium:
            return CGFloat(2.0)
        case .large:
            return CGFloat(4.0)
        }
    }
    
    func getCompatibleSize() -> UIActivityIndicatorView.Style {
        switch  self {
        case .medium:
            return .medium
        case .large:
            return .large
        }
    }
}
