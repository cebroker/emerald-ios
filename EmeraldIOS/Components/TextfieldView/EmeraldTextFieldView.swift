//
//  EmeraldTextFieldView.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 26/11/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public class EmeraldTextFieldView: UIView {

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
        label.textColor = UIColor.red
        label.text = "Some Error"
        label.font = UIFont.italicSystemFont(ofSize: 10)
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

    public func appearError() {
        setHiddenError(value: false)
    }

    public func disapperarError() {
        setHiddenError(value: true)
    }

    private func setHiddenError(value: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.errorLabel.isHidden = value
            self.stackView.layoutIfNeeded()
        }
    }
}

extension EmeraldTextFieldView: CustomEmeraldTextFieldDelegate {
    public func valueDidChange(textField: UITextField, text: String?) {
        print(text)
    }
}
