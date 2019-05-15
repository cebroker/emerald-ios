//
//  SignatureBoxView.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/15/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol SignatureBoxViewType {
    
}

public class SignatureBoxView: UIView {
    
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
        self.setupInitialView()
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        prepareForInterfaceBuilder()
    }
    
    private func setupInitialView() {
        self.addSubview(tapToSignButton)
        tapToSignButton
            .centerYAnchor
            .constraint(
                equalTo: self.centerYAnchor).isActive = true
        tapToSignButton
            .widthAnchor
            .constraint(equalTo: self.widthAnchor,
                        multiplier: 1).isActive = true
        tapToSignButton
            .centerXAnchor
            .constraint(
                equalTo: self.centerXAnchor).isActive = true
        tapToSignButton
            .heightAnchor
            .constraint(
                equalToConstant: 49).isActive = true
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
                          didCancel error : NSError) {
        print("User canceled")
    }
    
    public func emeraldSignature(_: EmeraldSignatureViewController,
                          didSign signatureImage : UIImage,
                          boundingRect: CGRect) {
        //signatureImageView.image = signatureImage
    }
}
