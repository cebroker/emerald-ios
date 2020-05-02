//
//  EmeraldTextField+ShowHide.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 9/9/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

extension EmeraldTextField {
    public func setPasswordRightView() {
        self.rightButton = EmeraldButton(frame: CGRect(x: 0.0,
                                                       y: 0.0,
                                                       width: 50,
                                                       height: placeholderLabel.frame.height))
        self.rightButton?.themeStyle = EmeraldButtonStyle.link.rawValue
        self.rightButton?.setTitle("SHOW",
                             for: .normal)
        self.rightButton?.addTarget(nil,
                              action: #selector(togglePasswordVisibility),
                              for: .touchUpInside)
        self.isSecureTextEntry = true
        if let rightButton = self.rightButton {
            self.addRightView(with: rightButton, x: -10.0)
        }
    }
    
    @objc private func togglePasswordVisibility() {
        guard (self.rightButton != nil) else {
            return
        }
        let buttonTitle = self.isSecureTextEntry ? "HIDE" : "SHOW"
        self.rightButton?.setTitle(buttonTitle,
                                   for: .normal)
        self.isSecureTextEntry.toggle()
    }
}
