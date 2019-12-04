//
//  BaseInputView.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 3/12/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

public class BaseInputView <T: EmeraldTextField>: UIView, BaseDelegate {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var emeraldComponentView: UIView!
    @IBOutlet weak var errorLabel: EmeraldLabel!

    lazy var textField: T = {
        var componentView = T()
        componentView.frame = self.emeraldComponentView.frame
        componentView.translatesAutoresizingMaskIntoConstraints = false
        return componentView
    }()

    weak var delegate: BaseEmeraldTextFieldType?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.nibSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.nibSetup()
    }

    private func nibSetup() {
        loadViewFromNib()
        self.setupViews()
    }

    private func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "BaseInputView", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }

        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    internal func setupViews() {
        self.setupErrorLabel()
        self.emeraldComponentView.addSubview(textField)
        self.setConstraints()
    }

    private func setConstraints() {
        textField.anchor(
            top: textField.superview?.topAnchor,
            left: textField.superview?.leftAnchor,
            bottom: textField.superview?.bottomAnchor,
            right: textField.superview?.rightAnchor)
    }

    private func setupErrorLabel() {
        errorLabel.themeFontSize = FontSize.h6.IBInspectable
        errorLabel.textColor = EmeraldTheme.errorColor
        errorLabel.isHidden = true
    }

    public func setDelegate(_ delegate: CustomEmeraldTextFieldDelegate) {
        self.textField.setCustomDelegate(with: delegate)
    }

    public func set(placeholder: String) {
        self.textField.prepareForInterfaceBuilder()
        textField.set(placeholder: placeholder)
    }

    public func validateAndHandle() -> Bool {
        return self.handleResult(with: self.validateContent())
    }

    private func validateContent() -> Result<Bool, Error> {
        guard let text = self.textField.text, !text.isEmpty else {
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
            self.errorLabel.text = error.description
            self.showErrorBorder()
            return false
        default:
            self.clearErrorBorder()
            return true
        }
    }

    private func showErrorBorder() {
        setHiddenError(value: false)
        self.textField.layer.borderColor = EmeraldTheme.redColor.cgColor
    }

    private func clearErrorBorder() {
        setHiddenError(value: true)
        self.textField.layer.borderColor = EmeraldTheme.borderColor.cgColor
    }

    private func setHiddenError(value: Bool) {
        UIView.animate(withDuration: 0.1) {
            self.errorLabel.isHidden = value
            self.stackView.layoutIfNeeded()
        }
    }

}

public class RegexTextFieldView: BaseInputView<EmeraldRegexTextField> {

    @IBInspectable
    public var regex: String {
        set {
            self.set(regex: EmeraldRegexFormatType(rawValue: newValue))
        }
        get {
            return self.getRegex().regex!
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self as ContracEmeraldRegexTextFieldType
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setupViews() {
        super.setupViews()
        self.set(placeholder: "example placeholder")
        self.setDelegate(self)
    }

    public func set(regex: EmeraldRegexFormatType) {
        self.textField.set(regex: regex)
    }

    public func getRegex() -> EmeraldRegexFormatType {
        return self.textField.getRegex()
    }
}

extension RegexTextFieldView: CustomEmeraldTextFieldDelegate {
    public func didEndEditing(textField: UITextField) {
        self.handleResult(with: self.textField.validateContent())
    }
}

extension RegexTextFieldView: ContracEmeraldRegexTextFieldType {

}

protocol BaseDelegate: class {
    var delegate: BaseEmeraldTextFieldType? { get set }
}

protocol BaseEmeraldTextFieldType: class {

}


protocol ContracEmeraldRegexTextFieldType: BaseEmeraldTextFieldType {

}
