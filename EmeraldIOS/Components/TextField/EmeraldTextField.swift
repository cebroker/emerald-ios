//
//  EmeraldTextField.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/6/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public protocol EmeraldTextFieldType {
    func set(placeholder: String?)
    func getPlaceholder() -> String?
    func set(hint: String?)
    func getHint() -> String?
    func set(maxLength: Int)
    func getMaxLength() -> Int
    func set(format: TextFormat)
    func getFormat() -> TextFormat
    func getUnformattedText() -> String?
    func set(inputType: UIKeyboardType)
    func getInputType() -> UIKeyboardType?
    func set(id: String?)
    func getId() -> String?
    func set(isRequired: Bool)
    func getIsRequired() -> Bool
    func isValid() -> Result<Bool, Error>
    func handleResult(with validationResult: Result<Bool, Error>) -> Bool
    func validateAndHandle() -> Bool
    func show(error: FormFieldErrorType)
    func clearError()
}

@IBDesignable
public class EmeraldTextField: UITextField, EmeraldTextFieldType, TextFormatter, UITextFieldDelegate {
    
    @IBInspectable var id: String?
    @IBInspectable var isRequired: Bool = false
    @IBInspectable var maxLength: Int = 0
    @IBInspectable var hint: String?
    
    @IBInspectable var placeHolder: String? {
        set {
            self.set(placeholder: newValue)
        }
        get {
            return self.getPlaceholder()
        }
    }
    
    @IBInspectable var format: Int {
        set {
            self.set(format: TextFormat.init(rawValue: newValue) ?? .none)
        }
        get {
            return self.getFormat().hashValue
        }
    }
    
    @IBInspectable var themeStyle: String = EmeraldTextFieldStyle.formField.IBInspectable {
        didSet {
            applyTheme()
        }
    }
    
    let placeholderLabel: UILabel = UILabel()
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 50.0)
    }
    
    private struct InnerConstants {
        static let middleFontSize: CGFloat = FontSize.h5.cgFontSize
        static let maximumFontSize: CGFloat = FontSize.body.cgFontSize
        static let placeHolderLabelSize: CGFloat = FontSize.h3.cgFontSize * 1.3
        static let animationDuration: Double = 0.15
        static let delay: Double = 0.0
        static var frameOriginFieldOff = CGPoint(x: 10, y: FontSize.h5.cgFontSize * 1.3)
        static let frameOriginFieldOn = CGPoint(x: 10, y: 7)
        static let maximumDoubleLength = 10
        static let maximumDateLength = 10
        static let maximumShortDateLength = 7
        static let yUpConstant: CGFloat = -15
        static let leadingUpConstant: CGFloat = -43
        static let bounds: CGFloat = 10
        struct Padding {
            static let left: CGFloat = 10
            static let right: CGFloat = 10
            static let top: CGFloat = 10
        }
    }
    
    private var isErrored: Bool = false
    private var initialPlaceHolder: String?
    private var innerFormat: TextFormat = .none
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareForInterfaceBuilder()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        prepareForInterfaceBuilder()
    }
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        prepareForInterfaceBuilder()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyTheme()
        self.delegate = self
        self.addSubview(placeholderLabel)
        self.setupPlaceholderLabelConstraints()
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: InnerConstants.bounds,
                              dy: InnerConstants.bounds)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    open func applyTheme() {
        let style = EmeraldTextFieldStyle(IBInspectable: themeStyle)
        self.autocapitalizationType = .sentences
        textColor = style.textColor
        font = style.font
        tintColor = style.tintColor
        layer.borderWidth = style.borderWidth
        layer.cornerRadius = style.cornerRadius
        
        if isErrored {
            layer.borderColor = EmeraldTheme.errorColor.cgColor
        } else {
            layer.borderColor = style.borderColor
        }
        
        self.setupPlaceholderTheme(
            labelHeight: InnerConstants.placeHolderLabelSize,
            color: EmeraldTheme.borderColor)
    }
    
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
        
        guard let oldText = textField.text, let textRange = Range(range, in: oldText) else {
            return true
        }
        
        if maxLength > 0 {
            let newLength = (oldText.count - range.length) + string.count
            
            guard newLength <= maxLength else {
                return false
            }
        }
        
        let updatedText = oldText.replacingCharacters(in: textRange, with: string)
        
        do {
            let textWithoutFormat = try remove(
                format: self.innerFormat,
                to: updatedText)
            
            textField.text = try apply(
                format: self.innerFormat,
                to: textWithoutFormat)
            
            return false
        } catch {
            return false
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        activateField()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        deactivateField()
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
        self.placeholderLabel.text = placeholder
        self.placeholderLabel.textColor = EmeraldTheme.placeholderColor
    }
    
    public func getPlaceholder() -> String? {
        return self.initialPlaceHolder
    }
    
    public func set(hint: String?) {
        self.hint = hint
    }
    
    public func getHint() -> String? {
        return self.hint
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
    
    public func set(format: TextFormat) {
        self.innerFormat = format
        switch format {
        case .currency:
            self.set(maxLength: InnerConstants.maximumDoubleLength)
            self.set(inputType: .decimalPad)
        case .number:
            self.set(inputType: .numberPad)
        case .longDate:
            self.set(maxLength: InnerConstants.maximumDateLength)
            self.set(inputType: .numberPad)
        case .shortDate:
            self.set(maxLength: InnerConstants.maximumShortDateLength)
            self.set(inputType: .numberPad)
        default:
            self.set(inputType: .asciiCapable)
        }
    }
    
    public func getFormat() -> TextFormat {
        return self.innerFormat
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
        self.isErrored = true
        self.placeholderLabel.text = error.description
        self.placeholderLabel.textColor = EmeraldTheme.redColor
        self.layer.borderColor = EmeraldTheme.redColor.cgColor
    }
    
    public func clearError() {
        self.isErrored = false
        self.placeholderLabel.text = self.initialPlaceHolder
        self.placeholderLabel.textColor = EmeraldTheme.placeholderColor
        self.layer.borderColor = EmeraldTheme.borderColor.cgColor
    }
    
    public func getValue() -> String? {
        return self.text
    }
    
    func validateContent() -> Result<Bool, Error> {
        guard let text = self.text, !text.isEmpty else {
            return .failure(FormFieldError.emptyField)
        }
        
        return .success(true)
    }
    
    private func activateField() {
        let onActiveColor = EmeraldTheme.primaryColor
        self.layer.borderColor = onActiveColor.cgColor
        
        self.placeholderLabel.text = self.initialPlaceHolder ?? Constants.Values.empty
        
        self.placeholderLabel.textColor = onActiveColor
        
        if self.text == nil || self.text == Constants.Values.empty {
            self.movePlaceholderUp()
        }
    }
    
    private func deactivateField() {
        self.layer.borderColor = EmeraldTheme.borderColor.cgColor
        self.placeholderLabel.textColor = EmeraldTheme.placeholderColor
        
        if self.text == nil || self.text == Constants.Values.empty {
            self.movePlaceholderDown()
        }
    }
    
    private func setupPlaceholderLabelConstraints() {
        self.contentVerticalAlignment = .bottom
        placeholderLabel
            .centerYAnchor
            .constraint(
                equalTo: self.centerYAnchor)
            .isActive = true
        
        placeholderLabel
            .leftAnchor
            .constraint(
                equalTo: self.leftAnchor,
                constant: InnerConstants.Padding.left)
            .isActive = true
        
        placeholderLabel
            .rightAnchor
            .constraint(
                equalTo: self.rightAnchor,
                constant: InnerConstants.Padding.right)
            .isActive = true
    }
    
    private func setupPlaceholderTheme(
        labelHeight: CGFloat,
        color: UIColor) {
        let style = EmeraldTextFieldStyle(IBInspectable: themeStyle)
        
        if isErrored {
            self.placeholderLabel.textColor = EmeraldTheme.errorColor
        } else {
            self.placeholderLabel.textColor = EmeraldTheme.placeholderColor
        }
        
        self.placeholderLabel.text = self.initialPlaceHolder ?? Constants.Values.empty
        self.placeholderLabel.font = style.font
        self.placeholderLabel.frame.origin = InnerConstants.frameOriginFieldOff
        self.placeholderLabel.frame.size = CGSize(width: self.frame.width, height: labelHeight)
    }
    
    private func movePlaceholderUp() {
        let reducerScale: CGFloat = InnerConstants.middleFontSize / InnerConstants.maximumFontSize
        UIView.animate(
            withDuration: InnerConstants.animationDuration,
            delay: InnerConstants.delay,
            options: [],
            animations: {
                self.placeholderLabel.transform = CGAffineTransform(
                    scaleX: reducerScale,
                    y: reducerScale)
                self.placeholderLabel.frame.origin = InnerConstants.frameOriginFieldOn
                self.layoutIfNeeded()
        },
            completion: { _ in
                self.placeholder = self.hint
        })
    }
    
    private func movePlaceholderDown() {
        self.placeholder = nil
        UIView.animate(
            withDuration: InnerConstants.animationDuration,
            delay: InnerConstants.delay,
            options: [],
            animations: {
                
                self.placeholderLabel.transform =
                    CGAffineTransform.identity
                self.placeholderLabel.frame.origin = InnerConstants.frameOriginFieldOff
        },
            completion: { _ in })
    }
}
