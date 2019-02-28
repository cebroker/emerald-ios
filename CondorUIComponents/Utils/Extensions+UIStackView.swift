//
//  Extensions+UIStackView.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public extension UIStackView {
    public func removeAllArrangedSubviews() {
        let arrangedSubviewsSize = arrangedSubviews.count
        for i in 0 ..< arrangedSubviewsSize {
            let subview = arrangedSubviews[i]
            self.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
}
