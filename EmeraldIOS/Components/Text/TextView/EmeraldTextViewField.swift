//
//  EmeraldTextViewField.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol EmeraldTextViewFieldType {
    func set(placeholder: String?)
    func getPlaceholder() -> String?
    func set(maxLength: Int)
    func getMaxLength() -> Int
    func getUnformattedText() -> String?
    func set(inputType: UIKeyboardType)
    func getInputType() -> UIKeyboardType?
    func set(id: String?)
    func getId() -> String?
    func set(isRequired: Bool)
    func getIsRequired() -> Bool
    func isValid() -> Result<Bool, Error>
    func handleResult(with validationResult: Result<Bool, Error>) -> Bool
    func show(error: FormFieldErrorType)
    func clearError()
}

@IBDesignable
public class EmeraldTextViewField: UITextView, EmeraldTextViewFieldType, TextFormatter, EmeraldValidableType {
    @IBInspectable var id: String?
    @IBInspectable var isRequired: Bool = false
    @IBInspectable var maxLength: Int = 0
    
    @IBInspectable var placeHolder: String? {
        set {
            self.set(placeholder: newValue)
        }
        get {
            return self.getPlaceholder()
        }
    }
    
    @IBInspectable var themeStyle: String = EmeraldTextViewFieldStyle.formField.IBInspectable {
        didSet {
            applyTheme()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 50.0)
    }
    
    private struct InnerConstants {
        static let boundsX: CGFloat = 5
        static let boundsY: CGFloat = 10
        static let mailType = "mail"
    }
    
    private var initialPlaceHolder: String?
    private var innerFormat: TextFormat = .none
    public weak var textViewDelegate: EmeraldTextViewFieldDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        prepareForInterfaceBuilder()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.textContainerInset = UIEdgeInsets(
            top: InnerConstants.boundsY,
            left: InnerConstants.boundsX,
            bottom: InnerConstants.boundsY,
            right: InnerConstants.boundsX)
        applyTheme()
        self.delegate = self
    }
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        self.prepareForInterfaceBuilder()
    }
    
    open func applyTheme() {
        self.backgroundColor = EmeraldTheme.whiteColor
        let style = EmeraldTextViewFieldStyle(IBInspectable: themeStyle)
        self.autocapitalizationType = .sentences
        font = style.font
        tintColor = style.tintColor
        layer.borderWidth = style.borderWidth
        layer.borderColor = style.borderColor
        layer.cornerRadius = style.cornerRadius
    }
    
    public func set(inputType: UIKeyboardType) {
        self.keyboardType = inputType
    }
    
    public func getInputType() -> UIKeyboardType? {
        return self.keyboardType
    }
    
    public func set(id: String?) {
        self.id = id
    }
    
    public func getId() -> String? {
        return self.id
    }
    
    public func set(placeholder: String?) {
        self.initialPlaceHolder = placeholder
        self.text = placeholder
        self.textColor = EmeraldTheme.placeholderColor
    }
    
    public func getPlaceholder() -> String? {
        return self.initialPlaceHolder
    }
    
    public func set(isRequired: Bool) {
        self.isRequired = isRequired
    }
    
    public func getIsRequired() -> Bool {
        return isRequired
    }
    
    public func set(maxLength: Int) {
        if maxLength > 0 {
            self.maxLength = maxLength
        }
    }
    
    public func getMaxLength() -> Int {
        return self.maxLength
    }
    
    public func getUnformattedText() -> String? {
        guard let textWithFormat = self.text else {
            return nil
        }
        
        do {
            return try self.remove(format: self.innerFormat, to: textWithFormat)
        } catch {
            return nil
        }
    }
    
    public func isValid() -> Result<Bool, Error> {
        guard getIsRequired() else {
            return .success(true)
        }
        
        return validateContent()
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
        self.layer.borderColor = EmeraldTheme.redColor.cgColor
    }
    
    public func clearError() {
        self.layer.borderColor = EmeraldTheme.borderColor.cgColor
    }
    
    public func getValue() -> String? {
        if self.text.isEmpty {
            return ""
        }
        return self.text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func validateContent() -> Result<Bool, Error> {
        guard let text = self.text,
            !text.isEmpty,
            text != getPlaceholder() else {
            return .failure(FormFieldError.emptyField)
        }
        
        return .success(true)
    }
    
    func activateField() {
        let onActiveColor = EmeraldTheme.primaryColor
        self.layer.borderColor = onActiveColor.cgColor
    }
    
    func deactivateField() {
        self.layer.borderColor = EmeraldTheme.borderColor.cgColor
    }
}

extension EmeraldTextViewField: UITextViewDelegate {
    
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
    
    public func textView(_ textView: UITextView,
                         shouldInteractWith URL: URL,
                         in characterRange: NSRange,
                         interaction: UITextItemInteraction) -> Bool {
        
        if URL.absoluteString == InnerConstants.mailType {
            textViewDelegate?.openEmail()
         }
         return true
     }
}
