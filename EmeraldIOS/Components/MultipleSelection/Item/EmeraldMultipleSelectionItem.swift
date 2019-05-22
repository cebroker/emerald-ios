//
//  EmeraldEmeraldMultipleSelectionItem.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//
import BEMCheckBox

public protocol EmeraldMultipleSelectionItemType: class {
    func set(status: Bool)
    func getStatus() -> Bool
    func getTitle() -> String
    func set(notifiable: SingleItemChangeNotifiable)
    func setPadding(top: CGFloat,
                    left: CGFloat,
                    bottom: CGFloat,
                    rigth: CGFloat)
    func setSquareShape(_ status: Bool)
    func setStyle(with currentTheme: EmeraldMultipleSelectionFieldStyle)
    func getAssociatedSelectable() -> Selectable?
    func equals(_ referenceAbstraction: EmeraldMultipleSelectionItemType) -> Bool
}

public class EmeraldMultipleSelectionItem: UIView, EmeraldMultipleSelectionItemType {
    
    private struct InnerConstants {
        struct Button {
            static let frameButtonHeighRatio: CGFloat = 1.0 / 5.0
            static let frameButtonOriginRatio: CGFloat = 1.0 / 5.0
            static let animationDuration: CGFloat = 0.13
        }
        struct Label {
            static let origin: CGFloat = 0
            static let emptyTitle = ""
        }
        struct Colors {
            static let blue: UIColor = EmeraldTheme.primaryColor
        }
        struct StackView {
            static let spacing = 20
            struct Padding {
                static let top = allSides
                static let left = allSides
                static let bottom = allSides
                static let right = allSides
                static let allSides = 15
                static let noPadding = 0.0
            }
        }
        struct Border {
            static let cornerRadius = EmeraldTheme.defaultCornerRadius
            static let borderWidth = EmeraldTheme.defaultBorderWidth
            static let zeroWidth = 0.0
            static let borderColor = EmeraldTheme.primaryColor.cgColor
        }
    }
    
    private var button: BEMCheckBox?
    
    private var label: UILabel?
    
    private weak var notifiable: SingleItemChangeNotifiable?
    
    private var stackView: UIStackView?
    
    private var associatedSelectable: Selectable?
    
    init(frame: CGRect, hasBorder: Bool, associatedSelectable: Selectable) {
        super.init(frame: frame)
        self.postInit(hasBorder: hasBorder, associatedSelectable: associatedSelectable)
    }
    
    public func equals(_ referenceAbstraction: EmeraldMultipleSelectionItemType) -> Bool {
        return self == (referenceAbstraction as? EmeraldMultipleSelectionItem)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func set(status: Bool) {
        self.button?.setOn(status, animated: true)
    }
    
    public func getStatus() -> Bool {
        return self.button?.on ?? false
    }
    
    public func set(notifiable: SingleItemChangeNotifiable) {
        self.notifiable = notifiable
    }
    
    public func getTitle() -> String {
        return self.label?.text ?? InnerConstants.Label.emptyTitle
    }
    
    public func setSquareShape(_ status: Bool) {
        self.button?.boxType = status ? .square : .circle
    }
    
    public func getAssociatedSelectable() -> Selectable? {
        return associatedSelectable
    }
    
    public func setPadding(
        top: CGFloat,
        left: CGFloat,
        bottom: CGFloat,
        rigth: CGFloat) {
        
        self.stackView?.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            bottom: self.bottomAnchor,
            right: self.rightAnchor,
            paddingTop: top,
            paddingLeft: left,
            paddingBottom: bottom,
            paddingRight: rigth,
            width: 0,
            height: 0)
    }
    
    private func postInit(hasBorder: Bool, associatedSelectable: Selectable) {
        
        self.associatedSelectable = associatedSelectable
        
        self.setupStackView()
        self.setupDefaultBorderPadding(hasBorder)
        self.setupBorder(hasBorder)
        self.setupCheckboxButton()
        self.setupLabel(with: associatedSelectable.getSelectableText())
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapTheWholeView)))
    }
    
    @objc private func didTapTheWholeView() {
        guard let associatedSelectable = self.associatedSelectable else {
            return
        }
        
        self.set(status: !self.getStatus())
        self.notifiable?.onItemClicked(associatedSelectable: associatedSelectable, from: self)
    }
    
    private func setupStackView() {
        self.stackView = UIStackView()
        
        self.stackView?.axis = .horizontal
        self.stackView?.distribution = .fill
        self.stackView?.alignment = .fill
        
        self.stackView?.spacing = CGFloat(InnerConstants.StackView.spacing)
        
        if let stackView = self.stackView {
            self.addSubview(stackView)
        }
    }
    
    private func setupDefaultBorderPadding(_ hasBorder: Bool) {
        self.setPadding(
            top: hasBorder ? CGFloat(InnerConstants.StackView.Padding.top) : CGFloat(InnerConstants.StackView.Padding.noPadding),
            left: hasBorder ? CGFloat(InnerConstants.StackView.Padding.left) : CGFloat(InnerConstants.StackView.Padding.noPadding),
            bottom: hasBorder ? CGFloat(InnerConstants.StackView.Padding.bottom) : CGFloat(InnerConstants.StackView.Padding.noPadding),
            rigth: hasBorder ? CGFloat(InnerConstants.StackView.Padding.right) : CGFloat(InnerConstants.StackView.Padding.noPadding))
    }
    
    private func setupBorder(_ hasBorder: Bool) {
        self.layer.borderWidth = hasBorder ? CGFloat(InnerConstants.Border.borderWidth) : CGFloat(InnerConstants.Border.zeroWidth)
        self.layer.borderColor = InnerConstants.Border.borderColor
        self.layer.cornerRadius = CGFloat(InnerConstants.Border.cornerRadius)
    }
    
    private func setupCheckboxButton() {
        self.button = BEMCheckBox(frame:
            CGRect(
                x: 0,
                y: 0,
                width: frame.height * InnerConstants.Button.frameButtonHeighRatio,
                height: 0))
        
        self.button?.animationDuration = InnerConstants.Button.animationDuration
        self.button?.delegate = self
        self.button?.onAnimationType = .bounce
        self.button?.offAnimationType = .fade
        self.button?.onCheckColor = .white
        self.button?.onTintColor = EmeraldTheme.primaryColor
        self.button?.onFillColor = EmeraldTheme.primaryColor
        
        self.button?.setContentHuggingPriority(UILayoutPriority(2), for: NSLayoutConstraint.Axis.horizontal)
        
        if let button = self.button {
            self.stackView?.addArrangedSubview(button)
        }
    }
    
    private func setupLabel(with text: String) {
        self.label = UILabel(frame:
            CGRect(
                x: 0,
                y: 0,
                width: frame.width,
                height: 0))
        
        self.label?.text = text
        
        self.label?.setContentHuggingPriority(UILayoutPriority(1), for: NSLayoutConstraint.Axis.horizontal)
        
        if let label = self.label {
            self.stackView?.addArrangedSubview(label)
        }
    }
    
    public func setStyle(with currentTheme: EmeraldMultipleSelectionFieldStyle) {
        label?.textColor = currentTheme.textColor
        label?.font = currentTheme.font
        button?.tintColor = currentTheme.tintColor
        tintColor = currentTheme.tintColor
    }
}

extension EmeraldMultipleSelectionItem: BEMCheckBoxDelegate {
    public func didTap(_ checkBox: BEMCheckBox) {
        guard let associatedSelectable = self.associatedSelectable else {
            return
        }
        
        self.notifiable?.onItemClicked(
            associatedSelectable: associatedSelectable,
            from: self)
    }
}

