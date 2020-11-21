//
//  EmeraldMultipleSelectionField.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//
import BEMCheckBox

public protocol EmeraldMultipleSelectionFieldType {
    func set(data: [Selectable])
    func getData() -> [EmeraldMultipleSelectionItemType]
    func getChildren() -> [EmeraldMultipleSelectionItemType]?
    func updateTitle(from index: Int, with newTitle: String)
    func set(spacing: CGFloat)
    func set(notifiable: SingleItemChangeNotifiable)
    func set(id: String?)
    func getId() -> String?
    func set(isRequired: Bool)
    func getIsRequired() -> Bool
    func isValid() -> Result<Bool, Error>
    func handleResult(with validationResult: Result<Bool, Error>) -> Bool
    func show(error: FormFieldErrorType)
    func clearError()
}

public class EmeraldMultipleSelectionField: UIStackView, EmeraldMultipleSelectionFieldType, SingleItemChangeNotifiable, EmeraldValidableType {
    
    private struct InnerConstants {
        struct StackView {
            struct Dimens {
                static let spacing = 15
            }
            struct Padding {
                static let top = 10
                static let left = 20
                static let bottom = 10
                static let right = 20
            }
        }
    }
    
    @IBInspectable var id: String? {
        set {
            self.set(id: newValue)
        }
        get {
            return self.getId()
        }
    }
    
    @IBInspectable var isRequired: Bool = false
    
    @IBInspectable var themeStyle: String = EmeraldMultipleSelectionFieldStyle.simple.IBInspectable {
        didSet {
            applyTheme()
        }
    }
    
    private var individualItemFrame: CGRect?
    var notifiable: SingleItemChangeNotifiable?
    private var errorLabel: EmeraldLabel?
    private var childrenHaveBorder: Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareForInterfaceBuilder()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyTheme()
        self.setupView()
    }
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        self.prepareForInterfaceBuilder()
    }
    
    private func setupView() {
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.alignment = .fill
        self.spacing = CGFloat(InnerConstants.StackView.Dimens.spacing)
        individualItemFrame = CGRect(
            x: CGFloat(Constants.Dimens.origin),
            y: CGFloat(Constants.Dimens.origin),
            width: self.frame.width,
            height: CGFloat(Constants.Dimens.SingleRadioButton.height))
    }
    
    public func getChildren() -> [EmeraldMultipleSelectionItemType]? {
        return self.arrangedSubviews as? [EmeraldMultipleSelectionItemType]
    }
    
    public func set(data: [Selectable]) {
        self.removeAllArrangedSubviews()
        
        data.forEach {
            self.addSelectableToStackView($0)
        }
    }
    
    public func getData() -> [EmeraldMultipleSelectionItemType] {
        var finalItemsSelected: [EmeraldMultipleSelectionItemType] = []
        self.getChildren()?.forEach {
            if $0.getStatus() == true {
                finalItemsSelected.append($0)
            }
        }
        return finalItemsSelected
    }
    
    public func updateTitle(from index: Int, with newTitle: String) {
        guard let childrens = self.getChildren() else {
            return
        }
        childrens[index].setTitle(with: newTitle)
    }
    
    public func set(id: String?) {
        self.id = id
    }
    
    public func getId() -> String? {
        return id
    }
    
    public func set(isRequired: Bool) {
        self.isRequired = isRequired
    }
    
    public func getIsRequired() -> Bool {
        return isRequired
    }
    
    public func set(spacing: CGFloat) {
        self.spacing = spacing
    }
    
    public func enable(innerBorder childrenHaveBorder: Bool) {
        self.childrenHaveBorder = childrenHaveBorder
    }
    
    public func set(notifiable: SingleItemChangeNotifiable) {
        self.notifiable = notifiable
    }
    
    public func onItemClicked(associatedSelectable: Selectable, from item: EmeraldMultipleSelectionItemType) {
        self.clearError()
        self.notifiable?.onItemClicked(
            associatedSelectable: associatedSelectable,
            from: item)
    }
    
    func addSelectableToStackView(_ item: Selectable) {
        guard let radioButtonFrame = self.individualItemFrame else {
            return
        }
        
        let subview = EmeraldMultipleSelectionItem(
            frame: radioButtonFrame,
            hasBorder: childrenHaveBorder,
            associatedSelectable: item)
        subview.set(notifiable: self)
        
        self.addArrangedSubview(subview)
    }
    
    public func isValid() -> Result<Bool, Error> {
        guard getIsRequired() else {
            return .success(true)
        }
        
        return validateContent()
    }
    
    public func handleResult(with
        validationResult: Result<Bool, Error>) -> Bool {
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
        guard self.errorLabel == nil else {
            return
        }
        
        self.errorLabel = EmeraldLabel()
        
        guard let errorLabel = self.errorLabel else {
            return
        }
        
        errorLabel.themeStyle = EmeraldLabelStyle.subtitle.rawValue
        errorLabel.text = error.description
        errorLabel.textColor = EmeraldTheme.redColor
        self.addArrangedSubview(errorLabel)
    }
    
    public func clearError() {
        guard let errorLabel = self.errorLabel else {
            return
        }
        
        self.removeArrangedSubview(errorLabel)
        errorLabel.removeFromSuperview()
        self.reloadInputViews()
        
        self.errorLabel = nil
    }
    
    func validateContent() -> Result<Bool, Error> {
        if let _ = getChildren()?.first(
            where: { $0.getStatus() == true }) {
            return .success(true)
        }
        
        return .failure(FormFieldError.emptyField)
    }
    
    open func applyTheme() {
        let style = EmeraldMultipleSelectionFieldStyle(IBInspectable: themeStyle)
        tintColor = style.tintColor
        layer.borderWidth = style.borderWidth
        layer.borderColor = style.borderColor
        layer.cornerRadius = style.cornerRadius
        layer.backgroundColor = EmeraldTheme.clearColor.cgColor
        
        getChildren()?.forEach {
            $0.setStyle(with: style)
        }
    }
}
