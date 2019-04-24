//
//  FormButton.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 4/24/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public class FormButton: UIButton {
    struct InnerConstants {
        static let cornerRadius: CGFloat = 3.0
    }

    override public func didMoveToWindow() {
        super.didMoveToWindow()

        self.setupTheme()
    }

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 50.0)
    }

    private func setupTheme() {
        if let font = UIFont(
            name: Constants.Design.font,
            size: Constants.Design.FontSize.button) {
            self.titleLabel?.font = font
        }
        self.titleLabel?.textColor = UIColor.white
        self.backgroundColor = Constants.Design.Color.blueAccent
        self.layer.cornerRadius = InnerConstants.cornerRadius
    }
}
