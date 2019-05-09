/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The `CanvasView` tracks `UITouch`es and represents them as a series of `Line`s.
 */

import UIKit

class SignatureView: CanvasView {
    
    let signatureIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "xIcon.png").withRenderingMode(.alwaysTemplate)
        icon.tintColor = EmeraldTheme.extraLightGrayColor
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let signatureBottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = EmeraldTheme.extraLightGrayColor
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let bottomTextLabel: EmeraldLabel = {
        let label = EmeraldLabel()
        label.textAlignment = .center
        label.themeStyle = EmeraldLabelStyle.subtitle.IBInspectable
        label.text = "I understand this is a legal representation of my signature"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = EmeraldTheme.whiteColor
        addSubview(signatureIcon)
        addSubview(signatureBottomLine)
        addSubview(bottomTextLabel)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        bottomTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bottomTextLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        bottomTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        signatureBottomLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        signatureBottomLine.bottomAnchor.constraint(equalTo: bottomTextLabel.topAnchor, constant: -5).isActive = true
        signatureBottomLine.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        signatureBottomLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true

        signatureIcon.leadingAnchor.constraint(equalTo: signatureBottomLine.leadingAnchor, constant: -5).isActive = true
        signatureIcon.bottomAnchor.constraint(equalTo: signatureBottomLine.topAnchor).isActive = true
        signatureIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
