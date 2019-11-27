//
//  EmeraldTextFieldView.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 26/11/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public class EmeraldTextFieldView: UIView, EmeraldValidableType {

    private lazy var stackView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var textField: EmeraldTextField = {
        var textField = EmeraldTextField(frame: .zero)
        textField.setCustomDelegate(with: self)
        return textField
    }()

    private lazy var errorLabel: EmeraldLabel = {
        var label = EmeraldLabel(frame: .zero)
        label.themeFontSize = FontSize.h6.IBInspectable
        label.textColor = EmeraldTheme.redColor
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupInitial()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupInitial()
    }

    private func setupInitial() {
        self.setupViews()
        self.setupConstraints()
    }

    private func setupViews() {
        self.errorLabel.isHidden = true
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.textField)
        self.stackView.addArrangedSubview(self.errorLabel)
    }

    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
        self.layoutIfNeeded()
    }

    public func setPlaceholder(with text: String) {
        self.textField.set(placeholder: text)
    }

    private func setHiddenError(value: Bool) {
        self.errorLabel.isHidden = value
        self.stackView.layoutIfNeeded()
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
}

extension EmeraldTextFieldView: CustomEmeraldTextFieldDelegate {
    public func didEndEditing(textField: UITextField) {
        switch self.validateContent() {
        case .failure(let error):
            guard let error = error as? FormFieldErrorType else {
                return
            }
            self.errorLabel.text = error.description
            self.showErrorBorder()
        default:
            self.clearErrorBorder()
            return
        }
    }
}
