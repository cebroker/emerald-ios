//
//  BaseInputView.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 3/12/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public class BaseInputView: UIView, EmeraldInputViewValidableType {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var emeraldComponentView: UIView!
    @IBOutlet weak var errorLabel: EmeraldLabel!

    var textField: EmeraldTextField = EmeraldTextField()

    public var status: EmeraldTextField.EmeraldTextFieldState {
        return self.textField.status
    }

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
        let nib = UINib(nibName: String(describing: BaseInputView.self), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }

        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    func setupViews() {
        self.setupErrorLabel()
        self.setupTextField()
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

    private func setupTextField() {
        textField.frame = self.emeraldComponentView.frame
        textField.translatesAutoresizingMaskIntoConstraints = false
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

    public func getPlaceholder() -> String? {
        return self.textField.placeholder
    }

    public func set(hint: String?) {
        self.textField.set(hint: hint)
    }

    public func getHint() -> String? {
        return self.textField.getHint()
    }

    public func set(maxLength: Int) {
        self.textField.set(maxLength: maxLength)
    }

    public func getMaxLength() -> Int {
        return self.textField.getMaxLength()
    }

    public func set(format: TextFormat) {
        self.textField.set(format: format)
    }

    public func getFormat() -> TextFormat {
        return self.textField.getFormat()
    }

    public func getUnformattedText() -> String? {
        return self.textField.getUnformattedText()
    }

    public func set(inputType: UIKeyboardType) {
        self.textField.set(inputType: inputType)
    }

    public func getInputType() -> UIKeyboardType? {
        return self.textField.getInputType()
    }

    public func set(id: String?) {
        self.textField.set(id: id)
    }

    public func getId() -> String? {
        return self.textField.getId()
    }

    public func set(isRequired: Bool) {
        self.textField.set(isRequired: isRequired)
    }

    public func getIsRequired() -> Bool {
        return self.textField.getIsRequired()
    }

    public func isValid() -> Result<Bool, Error> {
        return self.textField.isValid()
    }

    public func show(error: FormFieldErrorType) {
        self.textField.show(error: error)
    }

    public func clearError() {
        self.textField.clearError()
    }

    public func setText(with value: String?) {
        self.textField.setText(with: value)
    }

    public func clearText() {
        self.textField.clearText()
    }

    public func isEnable(_ enable: Bool) {
        self.textField.isEnable(enable)
    }

    public func setStatus(_ status: EmeraldTextField.EmeraldTextFieldState) {
        self.textField.setStatus(status)
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
            self.textField.show(error: error)
            self.showErrorBorder()
            return false
        default:
            self.textField.clearError()
            self.clearErrorBorder()
            return true
        }
    }

    private func showErrorBorder() {
        setHiddenError(value: false)
    }

    private func clearErrorBorder() {
        setHiddenError(value: true)
    }

    private func setHiddenError(value: Bool) {
        UIView.animate(withDuration: 0.1) {
            self.errorLabel.isHidden = value
            self.stackView.layoutIfNeeded()
        }
    }
}
