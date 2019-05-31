//
//  EmeraldTextView.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/31/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//
public protocol EmeraldTextViewType {
    func setPlaceholder(with value: String)
    func setTitle(with value: String)
    func setMaxLength(with value: Int)
    func setIsRequired(with value: Bool)
    func setThemeStyle(with theme: String)
    func showError(with error: FormFieldErrorType)
    func clearError()
    func isValid() -> Result<Bool, Error>
    func validateAndHandle() -> Bool
}

@IBDesignable
public class EmeraldTextView: UIStackView {
    
    public let titleLabel: EmeraldLabel = {
        let label = EmeraldLabel()
        label.themeStyle = EmeraldLabelStyle.subtitle.IBInspectable
        return label
    }()
    
    public let textViewField: EmeraldTextViewField = {
        let field = EmeraldTextViewField()
        return field
    }()
    
    public let errorLabel: EmeraldLabel = {
        let label = EmeraldLabel()
        label.themeStyle = EmeraldLabelStyle.custom.IBInspectable
        label.themeFontSize = FontSize.h5.rawValue
        label.themeColor = Color.red.rawValue
        label.themeFontWeight = FontWeight.regular.rawValue
        label.isHidden = true
        return label
    }()
    
    private var isErrored: Bool = false
    @IBInspectable var id: String?
    @IBInspectable var isRequired: Bool {
        set {
            textViewField.set(isRequired: newValue)
        }
        get {
            return textViewField.isRequired
        }
    }
    @IBInspectable var maxLength: Int {
        set {
            textViewField.set(maxLength: newValue)
        }
        get {
            return textViewField.getMaxLength()
        }
    }
    
    @IBInspectable var titleValue: String? {
        didSet {
            titleLabel.text = titleValue
        }
    }
    
    @IBInspectable var placeHolder: String? {
        set {
            textViewField.set(placeholder: newValue)
        }
        get {
            return textViewField.getPlaceholder()
        }
    }
    
    @IBInspectable var themeStyle: String = EmeraldTextViewFieldStyle.formField.IBInspectable {
        didSet {
            textViewField.themeStyle = themeStyle
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareForInterfaceBuilder()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .equalSpacing
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(textViewField)
        self.addArrangedSubview(errorLabel)
        textViewField.delegate = self
        
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textViewField.heightAnchor.constraint(equalToConstant: 100).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        if isErrored {
            let _ = self.validateAndHandle()
        }
    }
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        self.prepareForInterfaceBuilder()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension EmeraldTextView: EmeraldTextViewType {
    public func showError(with error: FormFieldErrorType) {
        self.isErrored = true
        textViewField.show(error: error)
        errorLabel.isHidden = false
        errorLabel.text = error.description
    }
    
    public func clearError() {
        self.isErrored = false
        errorLabel.isHidden = true
        textViewField.clearError()
    }
    
    public func validateAndHandle() -> Bool {
        switch isValid() {
        case .success(_):
            self.clearError()
            break
        case .failure(let error):
            guard let error = error as? FormFieldErrorType else {
                return false
            }
            self.showError(with: error)
            break
        }
        return textViewField.validateAndHandle()
    }
    
    public func isValid() -> Result<Bool, Error> {
        return textViewField.isValid()
    }
    
    public func setPlaceholder(with value: String) {
        self.placeHolder = value
    }
    
    public func setTitle(with value: String) {
        self.titleValue = value
    }
    
    public func setMaxLength(with value: Int) {
        self.maxLength = value
    }
    
    public func setIsRequired(with value: Bool) {
        self.isRequired = value
    }
    
    public func setThemeStyle(with theme: String) {
        self.themeStyle = theme
    }
    
    func getPlaceholder() -> String? {
        return textViewField.getPlaceholder()
    }
    
    func deactivateField() {
        textViewField.deactivateField()
    }
    
    func activateField() {
        textViewField.activateField()
    }
}

extension EmeraldTextView: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == self.getPlaceholder() {
            textView.text = nil
        }
        
        textView.textColor = EmeraldTheme.textColor
        activateField()
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == nil || textView.text.isEmpty {
            textView.text = self.getPlaceholder()
            textView.textColor = EmeraldTheme.placeholderColor
        }
        deactivateField()
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if !textView.text.isEmpty {
            clearError()
        }
    }
}
