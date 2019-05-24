//
//  SegmentedTitleAppearance.swift
//  EmeraldIOS
//
//  Created by Felipe Correa on 5/23/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public struct SegmentedTitleAppearance {
    let fontWhenHighlighted: UIFont
    let fontWhenSelected: UIFont
    let colorWhenHighlighted: UIColor
    let colorWhenSelected: UIColor
    
    public static func `default`() -> SegmentedTitleAppearance {
        return SegmentedTitleAppearance(fontWhenHighlighted: Font(size: .h4, weight: .regular).uiFont,
                                        fontWhenSelected: Font(size: .h4, weight: .regular).uiFont,
                                        colorWhenHighlighted: EmeraldTheme.extraLightTextColor,
                                        colorWhenSelected: EmeraldTheme.whiteColor)
    }
}

