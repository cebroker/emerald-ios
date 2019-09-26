//
//  Extensions+UIColorDarkener.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/26/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

extension UIColor {

func darker(by percentage: CGFloat = 10.0) -> UIColor {
    return self.adjust(by: -abs(percentage))
}

func adjust(by percentage: CGFloat) -> UIColor {
    var alpha, hue, saturation, brightness, red, green, blue, white : CGFloat
    (alpha, hue, saturation, brightness, red, green, blue, white) = (0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

    let multiplier = percentage / 100.0

    if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
        let newBrightness: CGFloat = max(min(brightness + multiplier*brightness, 1.0), 0.0)
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }
    else if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
        let newRed: CGFloat = min(max(red + multiplier*red, 0.0), 1.0)
        let newGreen: CGFloat = min(max(green + multiplier*green, 0.0), 1.0)
        let newBlue: CGFloat = min(max(blue + multiplier*blue, 0.0), 1.0)
        return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
    }
    else if self.getWhite(&white, alpha: &alpha) {
        let newWhite: CGFloat = (white + multiplier*white)
        return UIColor(white: newWhite, alpha: alpha)
    }

    return self
    }
}
