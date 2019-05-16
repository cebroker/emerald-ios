//
//  EmeraldSignatureBoxView.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/15/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol EmeraldSignatureBoxViewType {
    func setSignature(with currentSignature: UIImage)
    func getSignature() -> UIImage?
    func set(isRequired: Bool)
    func getIsRequired() -> Bool
    func isValid() -> Result<Bool, Error>
    func handleResult(with validationResult: Result<Bool, Error>) -> Bool
    func validateAndHandle() -> Bool
    func show(error: FormFieldErrorType)
    func clearError()
}

@IBDesignable
public class EmeraldSignatureBoxView: UIView, EmeraldSignatureBoxViewType {
    
    @IBInspectable var isRequired: Bool = false
    
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
    
    let errorLabel: EmeraldLabel = {
        let label = EmeraldLabel()
        label.themeStyle = EmeraldLabelStyle.subtitle.rawValue
        label.text = FormFieldError.emptyField.description
        label.textColor = EmeraldTheme.redColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
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
    
    public func getSignature() -> UIImage? {
        return self.signatureImageView.image
    }
    
    public func set(isRequired: Bool) {
        self.isRequired = isRequired
    }
    
    public func getIsRequired() -> Bool {
        return isRequired
    }
    
    public func isValid() -> Result<Bool, Error> {
        guard getIsRequired() else {
            return .success(true)
        }
        
        return validateContent()
    }
    
    func validateContent() -> Result<Bool, Error> {
        guard let _ = getSignature() else {
            return .failure(FormFieldError.emptyField)
        }
        
        return .success(true)
    }
    
    public func handleResult(with validationResult: Result<Bool, Error>) -> Bool {
        switch validationResult {
        case .failure(let error):
            guard let error = error as? FormFieldErrorType else {
                return false
            }
            self.show(error: error)
            return false
        default:
            self.clearError()
            return true
        }
    }
    
    public func validateAndHandle() -> Bool {
        return handleResult(with: self.isValid())
    }
    
    public func show(error: FormFieldErrorType) {
        self.errorLabel.text = error.description
        self.errorLabel.isHidden = false
    }
    
    public func clearError() {
        self.errorLabel.isHidden = true
    }
    
    private func setupInitialView() {
        self.addSubview(tapToSignButton)
        self.addSubview(errorLabel)
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
        errorLabel
            .leadingAnchor
            .constraint(
                equalTo: tapToSignButton.leadingAnchor
            ).isActive = true
        errorLabel
            .trailingAnchor
            .constraint(
                equalTo: tapToSignButton.trailingAnchor
            ).isActive = true
        errorLabel
            .topAnchor
            .constraint(
                equalTo: tapToSignButton.bottomAnchor
            ).isActive = true
    }
    
    private func setupViewWithSignature() {
        tapToSignButton.removeFromSuperview()
        errorLabel.removeFromSuperview()
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

extension EmeraldSignatureBoxView: SignatureReturnable {
    public func emeraldSignature(_: EmeraldSignatureViewController,
                          didCancel error : NSError) {}
    
    public func emeraldSignature(_: EmeraldSignatureViewController,
                          didSign signatureImage : UIImage,
                          boundingRect: CGRect) {
        self.clearError()
        signatureImageView.image = signatureImage
    }
}
