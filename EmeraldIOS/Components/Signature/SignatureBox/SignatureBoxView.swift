//
//  SignatureBoxView.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/15/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol SignatureBoxViewType {
    func setSignature(with currentSignature: UIImage)
}

public class SignatureBoxView: UIView, SignatureBoxViewType {
    
    let tapToSignButton: EmeraldButton = {
        let button = EmeraldButton()
        button.setTitle("Tap to sign", for: .normal)
        button.addTarget(self,
                         action: #selector(goToSignatureView),
                         for: .touchUpInside)
        button.themeStyle = EmeraldButtonStyle.plain.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signatureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = EmeraldTheme.borderColor.cgColor
        imageView.layer.borderWidth = EmeraldTheme.defaultBorderWidth
        imageView.layer.cornerRadius = EmeraldTheme.defaultElevatedViewCornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let changeButton: EmeraldButton = {
        let button = EmeraldButton()
        button.setTitle("Change", for: .normal)
        button.addTarget(self,
                         action: #selector(goToSignatureView),
                         for: .touchUpInside)
        button.themeStyle = EmeraldButtonStyle.link.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    public var delegate: UIViewController?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        prepareForInterfaceBuilder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.backgroundColor = EmeraldTheme.whiteColor
        signatureImageView.image == nil ? self.setupInitialView() : self.setupViewWithSignature()
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        prepareForInterfaceBuilder()
    }
    
    public func setSignature(with currentSignature: UIImage) {
        self.signatureImageView.image = currentSignature
    }
    
    private func setupInitialView() {
        self.addSubview(tapToSignButton)
        tapToSignButton
            .centerYAnchor
            .constraint(
                equalTo: self.centerYAnchor
            ).isActive = true
        tapToSignButton
            .widthAnchor
            .constraint(equalTo: self.widthAnchor,
                        multiplier: 1
            ).isActive = true
        tapToSignButton
            .centerXAnchor
            .constraint(
                equalTo: self.centerXAnchor
            ).isActive = true
        tapToSignButton
            .heightAnchor
            .constraint(
                equalToConstant: 49
            ).isActive = true
    }
    
    private func setupViewWithSignature() {
        tapToSignButton.removeFromSuperview()
        self.addSubview(signatureImageView)
        self.addSubview(changeButton)
        signatureImageView
            .centerYAnchor
            .constraint(
                equalTo: self.centerYAnchor
            ).isActive = true
        signatureImageView
            .widthAnchor
            .constraint(equalTo: self.widthAnchor,
                        multiplier: 1
            ).isActive = true
        signatureImageView
            .centerXAnchor
            .constraint(
                equalTo: self.centerXAnchor
            ).isActive = true
        signatureImageView
            .heightAnchor
            .constraint(
                equalToConstant: 49
            ).isActive = true
        changeButton
            .leadingAnchor
            .constraint(
                equalTo: signatureImageView.leadingAnchor
            ).isActive = true
        changeButton
            .trailingAnchor
            .constraint(
                equalTo: signatureImageView.trailingAnchor
            ).isActive = true
        changeButton
            .topAnchor
            .constraint(
                equalTo: signatureImageView.bottomAnchor
            ).isActive = true
    }
    
    @objc func goToSignatureView() {
        let signatureViewController = EmeraldSignatureViewController(signatureDelegate: self)
        delegate?.present(signatureViewController,
                         animated: true,
                         completion: nil)
    }
}

extension SignatureBoxView: SignatureReturnable {
    public func emeraldSignature(_: EmeraldSignatureViewController,
                          didCancel error : NSError) {}
    
    public func emeraldSignature(_: EmeraldSignatureViewController,
                          didSign signatureImage : UIImage,
                          boundingRect: CGRect) {
        signatureImageView.image = signatureImage
    }
}
