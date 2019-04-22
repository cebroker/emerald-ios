//
//  TextFormField.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public protocol TextFormFieldType {
    func set(placeholder: String?)
    func getPlaceholder() -> String?
    func set(text: String?)
    func getText() -> String?
    func set(maxLength: Int)
    func getMaxLength() -> Int
    func set(format: TextFormat)
    func getFormat() -> TextFormat
    func getUnformattedText() -> String?
    func set(font: UIFont?)
    func getFont() -> UIFont?
    func set(textColor: UIColor?)
    func getTextColor() -> UIColor?
    func set(inputType: UIKeyboardType)
    func getInputType() -> UIKeyboardType?
}

@IBDesignable
public class TextFormField: FormFieldType<String>, TextFormFieldType, TextFormatter, UITextFieldDelegate {

    let textField: UITextField = UITextField()
    let placeholderLabel: UILabel = UILabel()

    @IBInspectable
    public var maxLength: Int = 0

    @IBInspectable
    public var title: String? {
        set {
            self.set(text: title)
        }
        get {
            return self.getText()
        }
    }

    @IBInspectable
    public var placeHolder: String? {
        set {
            self.set(placeholder: placeHolder)
        }
        get {
            return self.getPlaceholder()
        }
    }

    @IBInspectable
    public var format: Int {
        set {
            self.set(format: TextFormat.init(rawValue: format) ?? .none)
        }
        get {
            return self.getFormat().hashValue
        }
    }

    @IBInspectable
    public var font: UIFont? {
        didSet {
            self.textField.font = self.font
        }
    }

    private var initialPlaceHolder: String?

    private var innerFormat: TextFormat = .none

    private struct InnerConstants {
        static let middleFontSize: CGFloat = Constants.Design.FontSize.form
        static let maximumFontSize: CGFloat = Constants.Design.FontSize.body
        static let borderWidth: CGFloat = 1
        static let cornerRadiousValue: CGFloat = 2
        static let placeHolderLabelSize: CGFloat = Constants.Design.FontSize.body * 1.5
        static let initialPosition: Int = 0
        static let heightDivider: CGFloat = 2
        static let animationDuration: Double = 0.15
        static var frameOriginFieldOff = CGPoint(x: 10, y: Constants.Design.FontSize.body * 1.3)
        static let frameOriginFieldOn = CGPoint(x: 10, y: 10)
        struct Padding {
            static let top: CGFloat = 10
            static let bottom: CGFloat = 10
            static let left: CGFloat = 10
            static let right: CGFloat = 10
        }
    }

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 58.0)
    }

    override func postInit() {
        self.addSubview(textField)
        self.addSubview(placeholderLabel)
        textField.delegate = self

        self.setupLayout()

        self.setupTextFieldConstraints()
        self.setupPlaceholderLabelConstraints()
    }

    public override func didMoveToWindow() {
        super.didMoveToWindow()
        self.setupPlaceholderTheme(
            font: Constants.Design.font,
            fontSize: InnerConstants.maximumFontSize,
            labelHeight: InnerConstants.placeHolderLabelSize,
            positionX: InnerConstants.initialPosition,
            positionY: (Int(self.bounds.midY - InnerConstants.maximumFontSize / InnerConstants.heightDivider)),
            color: Constants.Design.Color.grayBorder)
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
            let textWithoutFormat = try remove(format: self.innerFormat, to: updatedText)
            textField.text = try apply(format: self.innerFormat, to: textWithoutFormat)
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
        self.textField.keyboardType = inputType
    }

    public func getInputType() -> UIKeyboardType? {
        return self.textField.keyboardType
    }

    public func set(placeholder: String?) {
        self.initialPlaceHolder = placeholder
        self.placeholderLabel.text = placeholder
        self.placeholderLabel.textColor = UIColor.gray
    }

    public func getPlaceholder() -> String? {
        return self.initialPlaceHolder
    }

    public func set(text: String?) {
        self.textField.text = text
    }

    public func getText() -> String? {
        return self.textField.text
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
    }

    public func getFormat() -> TextFormat {
        return self.innerFormat
    }

    public func set(font: UIFont?) {
        self.textField.font = font
    }

    public func getFont() -> UIFont? {
        return self.textField.font
    }

    public func set(textColor: UIColor?) {
        self.textField.textColor = textColor
    }

    public func getTextColor() -> UIColor? {
        return self.textField.textColor
    }

    public func getUnformattedText() -> String? {
        guard let textWithFormat = self.textField.text else {
            return nil
        }

        do {
            return try self.remove(format: self.innerFormat, to: textWithFormat)
        } catch {
            return nil
        }
    }

    public override func show(error: FormFieldErrorType) {
        self.placeholderLabel.text = error.description
        self.placeholderLabel.textColor = UIColor.red
    }

    public override func clearError() {
        self.placeholderLabel.text = self.initialPlaceHolder
        self.placeholderLabel.textColor = UIColor.gray
    }

    override func getValue() -> String? {
        return getText()
    }

    private func setupLayout() {
        self.font = UIFont.init(
            name: Constants.Design.font,
            size: InnerConstants.maximumFontSize)

        self.set(textColor: UIColor.darkGray)

        self.layer.borderWidth = InnerConstants.borderWidth
        self.layer.borderColor = Constants.Design.Color.grayBorder.cgColor
        self.layer.cornerRadius = InnerConstants.cornerRadiousValue
    }

    internal override func validateContent() -> ValidationResult {
        guard let text = self.getText(), !text.isEmpty else {
            return ValidationResult(isValid: false, error: FormFieldError.emptyField)
        }

        return ValidationResult(isValid: true)
    }

    private func activateField() {
        let onActiveColor = Constants.Design.Color.lightGreen

        self.layer.borderColor = onActiveColor.cgColor

        self.placeholderLabel.text = self.initialPlaceHolder ?? Constants.Values.empty

        self.placeholderLabel.textColor = onActiveColor

        if textField.text != nil {
            self.movePlaceholderUp()
        }
    }

    private func deactivateField() {
        let onDeactivateColor = Constants.Design.Color.grayBorder

        self.layer.borderColor = onDeactivateColor.cgColor

        self.placeholderLabel.textColor = onDeactivateColor

        if let text = textField.text, text == Constants.Values.empty {
            self.movePlaceholderDown()
        }
    }

    private func setupTextFieldConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false

        textField
            .topAnchor
            .constraint(
                equalTo: self.topAnchor,
                constant: InnerConstants.Padding.top)
            .isActive = true

        textField
            .bottomAnchor
            .constraint(
                equalTo: self.bottomAnchor,
                constant: InnerConstants.Padding.bottom)
            .isActive = true

        textField
            .leftAnchor
            .constraint(
                equalTo: self.leftAnchor,
                constant: InnerConstants.Padding.left)
            .isActive = true

        textField
            .rightAnchor
            .constraint(
                equalTo: self.rightAnchor,
                constant: InnerConstants.Padding.right)
            .isActive = true
    }

    private func setupPlaceholderLabelConstraints() {
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false

        placeholderLabel
            .topAnchor
            .constraint(
                equalTo: self.topAnchor,
                constant: InnerConstants.Padding.top)
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

        placeholderLabel
            .heightAnchor
            .constraint(equalToConstant: InnerConstants.maximumFontSize)
            .isActive = true

    }

    private func setupPlaceholderTheme(
        font: String,
        fontSize: CGFloat,
        labelHeight: CGFloat,
        positionX: Int,
        positionY: Int,
        color: UIColor) {
        DispatchQueue.main.async {
            self.placeholderLabel.text = self.initialPlaceHolder ?? Constants.Values.empty
            self.placeholderLabel.textColor = Constants.Design.Color.grayBorder
            self.placeholderLabel.font = UIFont.init(name: font, size: fontSize)
            self.placeholderLabel.frame.origin = InnerConstants.frameOriginFieldOff
            self.placeholderLabel.frame.size = CGSize(width: self.frame.width, height: labelHeight)
        }
    }

    private func movePlaceholderUp() {
        let reducerScale: CGFloat = InnerConstants.middleFontSize / InnerConstants.maximumFontSize

        DispatchQueue.main.async {
            UIView.animate(
                withDuration: InnerConstants.animationDuration,
                delay: InnerConstants.animationDuration,
                options: [],
                animations: {
                    self.placeholderLabel.transform =
                        CGAffineTransform(
                            scaleX: reducerScale,
                            y: reducerScale)
                    self.placeholderLabel.frame.origin = InnerConstants.frameOriginFieldOn
                },
                completion: { _ in })
        }
    }

    private func movePlaceholderDown() {
        DispatchQueue.main.async {
            UIView.animate(
                withDuration: InnerConstants.animationDuration,
                delay: InnerConstants.animationDuration,
                options: [],
                animations: {
                    self.placeholderLabel.transform =
                        CGAffineTransform.identity
                    self.placeholderLabel.frame.origin = InnerConstants.frameOriginFieldOff
                },
                completion: { _ in })
        }
    }
}
