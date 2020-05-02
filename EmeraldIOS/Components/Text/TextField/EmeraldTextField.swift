//
//  EmeraldTextField.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/6/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public enum EmeraldTextFieldState {
    case valid
    case normal
    case error
    case loading
}

@IBDesignable
public class EmeraldTextField: UITextFieldType, TextFormatter {
    // MARK: - Constants
    struct InnerConstants {
        static let middleFontSize: CGFloat = FontSize.h6.cgFontSize
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

    // MARK: - Properties
    // MARK: - IBOutlet
    @IBOutlet open weak var nextResponderField: UIResponder? {
        didSet {
            if nextResponderField != nil {
                returnKeyType = .next
            } else {
                returnKeyType = .default
            }
        }
    }

    // MARK: - IBInspectables.
    @IBInspectable var id: String?
    @IBInspectable var isRequired: Bool = false
    @IBInspectable var maxLength: Int = 0
    @IBInspectable var hint: String?

    @IBInspectable var placeHolder: String? {
        set {
            set(placeholder: newValue)
        }
        get {
            return getPlaceholder()
        }
    }

    @IBInspectable var format: Int {
        set {
            set(format: TextFormat(rawValue: newValue) ?? .none)
        }
        get {
            return getFormat().hashValue
        }
    }

    @IBInspectable var themeStyle: String = EmeraldTextFieldStyle.formField.IBInspectable {
        didSet {
            applyTheme()
        }
    }

    // MARK: - Internals & Privates
    let placeholderLabel: UILabel = UILabel()
    var rightButton: EmeraldButton?
    var fieldState: EmeraldTextFieldState = .normal
    var customTextFieldDelegate: CustomEmeraldTextFieldDelegate?
    var innerFormat: TextFormat = .none
    var isErrored: Bool = false
    var initialPlaceHolder: String?

    private var originCenter: CGPoint {
        return CGPoint(x: 10, y: self.frame.height / 2 - InnerConstants.placeHolderLabelSize / 2)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareForInterfaceBuilder()
        setUp()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareForInterfaceBuilder()
        setUp()
    }

    // MARK: - Override methods.
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        prepareForInterfaceBuilder()
    }

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: InnerConstants.bounds, dy: InnerConstants.bounds)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        if isErrored { _ = validateAndHandle() }

        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 58.0).isActive = true
        backgroundColor = EmeraldTheme.whiteColor
        delegate = self
        addSubview(placeholderLabel)

        applyTheme()
        setupPlaceholderLabelConstraints()
    }

    // MARK: - Public & Open functions
    open func applyTheme() {
        let style = EmeraldTextFieldStyle(IBInspectable: themeStyle)
        autocapitalizationType = .sentences
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

        setupPlaceholderTheme(
            labelHeight: InnerConstants.placeHolderLabelSize,
            color: EmeraldTheme.borderColor)
    }

    public func getValue() -> String? {
        if text?.isEmpty ?? true {
            return ""
        }
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // MARK: - Internal methods.
    public func isValid() -> Result<Bool, Error> {
        guard getIsRequired() else {
            return .success(true)
        }

        return validateContent()
    }
    
    func validateContent() -> Result<Bool, Error> {
        guard let text = self.text, !text.isEmpty else {
            return .failure(FormFieldError.emptyField)
        }

        return .success(true)
    }

    func activateField() {
        let onActiveColor = EmeraldTheme.primaryColor
        layer.borderColor = onActiveColor.cgColor

        placeholderLabel.text = initialPlaceHolder ?? Constants.Values.empty
        placeholderLabel.textColor = onActiveColor

        if text == nil || text == Constants.Values.empty {
            movePlaceholderUp()
        }

        if let text = self.text, self.innerFormat == TextFormat.currency {
            self.text = removeCurrencyFormat(from: text)
        }
    }

    func deactivateField() {
        layer.borderColor = EmeraldTheme.borderColor.cgColor
        placeholderLabel.textColor = EmeraldTheme.placeholderColor

        if text == nil || text == Constants.Values.empty {
            movePlaceholderDown()
        }

        if let text = self.text, self.innerFormat == TextFormat.currency && !text.isEmpty {
            self.text = formatCurrency(resource: text)
        }
    }

    // MARK: - Private methods.
    @objc private func actionKeyboardButtonTapped(sender: UITextField) {
        switch nextResponderField {
        case .some(let responder):
            responder.becomeFirstResponder()
        default:
            resignFirstResponder()
        }
    }

    private func setUp() {
        addTarget(self, action: #selector(actionKeyboardButtonTapped(sender:)), for: .editingDidEnd)
    }

    private func setupPlaceholderLabelConstraints() {
        contentVerticalAlignment = .bottom
    }

    private func setupPlaceholderTheme(
        labelHeight: CGFloat,
        color: UIColor) {
        let style = EmeraldTextFieldStyle(IBInspectable: themeStyle)

        if initialPlaceHolder == nil {
            let centerPoint = InnerConstants.frameOriginFieldOff
            placeholderLabel.frame = CGRect(
                x: centerPoint.x,
                y: centerPoint.y,
                width: frame.width,
                height: labelHeight)
        }
        placeholderLabel.font = style.font
    }

    private func movePlaceholderUp() {
        let reducerScale: CGFloat = InnerConstants.middleFontSize / InnerConstants.maximumFontSize
        UIView.animate(
            withDuration: InnerConstants.animationDuration,
            delay: InnerConstants.delay,
            options: [],
            animations: {
                self.placeholderLabel.transform = CGAffineTransform(scaleX: reducerScale, y: reducerScale)
                self.placeholderLabel.frame.origin = InnerConstants.frameOriginFieldOn
                self.layoutIfNeeded()
            },
            completion: { _ in
                self.placeholder = self.hint
            })
    }

    private func movePlaceholderDown() {
        placeholder = nil
        UIView.animate(
            withDuration: InnerConstants.animationDuration,
            delay: InnerConstants.delay,
            options: [],
            animations: {
                self.placeholderLabel.transform = CGAffineTransform.identity
                self.placeholderLabel.frame.origin = self.originCenter
            },
            completion: { _ in })
    }
}
