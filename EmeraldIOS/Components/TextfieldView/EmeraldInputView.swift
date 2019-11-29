//
//  EmeraldInputView.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 29/11/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public class EmeraldInputView: UIView, EmeraldValidableType {

    @IBOutlet weak var textField: EmeraldTextField!
    @IBOutlet weak var errorLabel: EmeraldLabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
        setupLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
        setupLabel()
    }

    private func nibSetup() {
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    public override func layoutIfNeeded() {
        super.layoutIfNeeded()
         errorLabel.textColor = EmeraldTheme.errorColor
    }

    private func setupLabel() {
        errorLabel.isHidden = true
        errorLabel.themeFontSize = FontSize.h6.IBInspectable
    }

    public func setPlaceholder(placeholder text: String) {
        self.textField.set(placeholder: text)
    }
    
    public func setDelegate(_ delegate: CustomEmeraldTextFieldDelegate) {
        self.textField.setCustomDelegate(with: delegate)
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
            self.layoutIfNeeded()
        }
    }
}
