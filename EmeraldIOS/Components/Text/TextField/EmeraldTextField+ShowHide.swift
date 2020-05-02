//
//  EmeraldTextField+ShowHide.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 9/9/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

extension EmeraldTextField {
    public func setPasswordRightView() {
        rightButton = EmeraldButton(frame: CGRect(
            x: 0.0,
            y: 0.0,
            width: 50,
            height: placeholderLabel.frame.height))

        rightButton?.themeStyle = EmeraldButtonStyle.link.rawValue
        rightButton?.setTitle("SHOW", for: .normal)
        rightButton?.addTarget(nil, action: #selector(togglePasswordVisibility), for: .touchUpInside)

        isSecureTextEntry = true
        if let rightButton = self.rightButton {
            addRightView(with: rightButton, x: -10.0)
        }
    }

    @objc private func togglePasswordVisibility() {
        guard rightButton != nil else {
            return
        }

        let buttonTitle = isSecureTextEntry ? "HIDE" : "SHOW"
        rightButton?.setTitle(buttonTitle, for: .normal)
        isSecureTextEntry.toggle()
    }
}
