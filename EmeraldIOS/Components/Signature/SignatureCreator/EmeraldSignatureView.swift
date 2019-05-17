//
//  EmeraldSignatureView.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/17/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

@IBDesignable
public class EmeraldSignatureView: UIView {
    
    let signatureView: EmeraldCanvasView = {
        let view = EmeraldCanvasView()
        view.contentMode = .scaleToFill
        view.backgroundColor = EmeraldTheme.whiteColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = EmeraldTheme.borderColor.cgColor
        view.layer.borderWidth = Constants.Values.one
        view.layer.cornerRadius = EmeraldTheme.defaultElevatedViewCornerRadius
        return view
    }()
    
    let signatureIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "xIcon",
                            in: Bundle(for: ClassBundle.self),
                            compatibleWith: nil)?
            .withRenderingMode(.alwaysTemplate)
        imageView.image = image
        imageView.tintColor = EmeraldTheme.grayColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.contentMode = .scaleToFill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let doneButton: EmeraldButton = {
        let button = EmeraldButton()
        button.setTitle("Done signing", for: .normal)
        button.themeStyle = EmeraldButtonStyle.primary.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let clearButton: EmeraldButton = {
        let button = EmeraldButton()
        button.setTitle("Clear signature", for: .normal)
        button.themeStyle = EmeraldButtonStyle.plain.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = EmeraldTheme.grayColor
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "xIcon",
                            in: Bundle(for: ClassBundle.self),
                            compatibleWith: nil)?
            .withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.setImage(image, for: .highlighted)
        button.setImage(image, for: .selected)
        button.tintColor = EmeraldTheme.primaryColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let subtitleLabel: EmeraldLabel = {
        let label = EmeraldLabel()
        label.textAlignment = .center
        label.text = "Sign Here"
        label.contentMode = .scaleToFill
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(signatureView)
        self.addSubview(signatureIcon)
        self.addSubview(lineView)
        self.addSubview(subtitleLabel)
        self.addSubview(closeButton)
        self.addSubview(buttonsStack)
        
        buttonsStack.addArrangedSubview(clearButton)
        buttonsStack.addArrangedSubview(doneButton)
        
        signatureView
            .safeAreaLayoutGuide
            .leadingAnchor
            .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                        constant: 20).isActive = true
        signatureView
            .safeAreaLayoutGuide
            .trailingAnchor
            .constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                        constant: -20).isActive = true
        signatureView
            .centerXAnchor
            .constraint(equalTo: self.centerXAnchor).isActive = true
        signatureView
            .centerYAnchor
            .constraint(equalTo: self.centerYAnchor).isActive = true
        signatureView
            .heightAnchor
            .constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
        
        subtitleLabel
            .centerXAnchor
            .constraint(equalTo: signatureView.centerXAnchor).isActive = true
        subtitleLabel
            .topAnchor
            .constraint(equalTo: lineView.bottomAnchor,
                        constant: 15).isActive = true
        subtitleLabel
            .leadingAnchor
            .constraint(equalTo: signatureView.leadingAnchor,
                        constant: 10).isActive = true
        subtitleLabel
            .trailingAnchor
            .constraint(equalTo: signatureView.trailingAnchor,
                        constant: -10).isActive = true
        subtitleLabel
            .bottomAnchor
            .constraint(equalTo: signatureView.bottomAnchor,
                        constant: -15).isActive = true
        
        lineView
            .centerXAnchor
            .constraint(equalTo: self.centerXAnchor).isActive = true
        lineView
            .heightAnchor
            .constraint(equalToConstant: 2).isActive = true
        lineView
            .leadingAnchor
            .constraint(equalTo: signatureView.leadingAnchor,
                        constant: 15).isActive = true
        lineView
            .trailingAnchor
            .constraint(equalTo: signatureView.trailingAnchor,
                        constant: -15).isActive = true
        lineView
            .bottomAnchor
            .constraint(equalTo: subtitleLabel.topAnchor,
                        constant: -15).isActive = true
        
        signatureIcon
            .bottomAnchor
            .constraint(equalTo: lineView.topAnchor,
                        constant: -5).isActive = true
        signatureIcon
            .leadingAnchor
            .constraint(equalTo: lineView.leadingAnchor).isActive = true
        signatureIcon
            .heightAnchor
            .constraint(equalToConstant: 20).isActive = true
        signatureIcon
            .widthAnchor
            .constraint(equalToConstant: 20).isActive = true
        
        closeButton
            .heightAnchor
            .constraint(equalToConstant: 30).isActive = true
        closeButton
            .widthAnchor
            .constraint(equalToConstant: 30).isActive = true
        closeButton
            .safeAreaLayoutGuide
            .leadingAnchor
            .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                        constant: 20).isActive = true
        closeButton
            .safeAreaLayoutGuide
            .topAnchor
            .constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                        constant: 20).isActive = true

        buttonsStack
            .centerXAnchor
            .constraint(equalTo: self.centerXAnchor).isActive = true
        buttonsStack
            .heightAnchor
            .constraint(equalToConstant: 58).isActive = true
        buttonsStack
            .safeAreaLayoutGuide
            .leadingAnchor
            .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                        constant: 20).isActive = true
        buttonsStack
            .safeAreaLayoutGuide
            .trailingAnchor
            .constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                        constant: -20).isActive = true
        buttonsStack
            .safeAreaLayoutGuide
            .bottomAnchor
            .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
