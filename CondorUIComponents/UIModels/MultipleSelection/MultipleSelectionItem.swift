//
//  MultipleSelectionItem.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit
import BEMCheckBox

public protocol MultipleSelectionItemProtocol {
    func set(status: Bool)
    func getStatus() -> Bool
    func set(title: String)
    func getTitle() -> String
    func set(listener: MultipleSelectionItemListener)
    func enableBorder(_ status: Bool)
    func setPadding(top: CGFloat, left: CGFloat, bottom: CGFloat, rigth: CGFloat)
    func setSquareShape(_ status: Bool)
}

public protocol MultipleSelectionItemListener: class {
    func onItemClicked(title: String?, from item: MultipleSelectionItem)
}

public class MultipleSelectionItem: UIView, MultipleSelectionItemProtocol {
    
    private struct InnerConstants {
        struct Button {
            static let frameButtonHeighRatio: CGFloat = 1.0 / 5.0
            static let frameButtonOriginRatio: CGFloat = 1.0 / 5.0
            static let animationDuration = 0
        }
        struct Label {
            static let origin: CGFloat = 0
            static let emptyTitle = ""
        }
        struct Colors {
            static let blue: UIColor = UIColor(displayP3Red: 0, green: 122.0 / 255.0, blue: 1, alpha: 1)
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
            static let cornerRadius = 6.0
            static let borderWidth = 1.5
            static let zeroWidth = 0.0
            static let borderColor = UIColor.lightGray.cgColor
        }
    }
    
    private var button: BEMCheckBox?
    private var label: UILabel?
    private weak var listener: MultipleSelectionItemListener?
    private var stackView: UIStackView?
    
    init(frame: CGRect, title: String?, hasBorder: Bool) {
        super.init(frame: frame)
        self.ownInit(title: title, hasBorder: hasBorder)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.ownInit()
    }
    
    public func set(status: Bool) {
        self.button?.setOn(status, animated: false)
    }
    
    public func getStatus() -> Bool {
        return self.button?.on ?? false
    }
    
    public func set(listener: MultipleSelectionItemListener) {
        self.listener = listener
    }
    
    public func set(title: String) {
        self.label?.text = title
    }
    
    public func getTitle() -> String {
        return self.label?.text ?? InnerConstants.Label.emptyTitle
    }
    
    public func setSquareShape(_ status: Bool) {
        self.button?.boxType = status ? .square : .circle
    }
    
    public func enableBorder(_ status: Bool) {
        self.layer.borderWidth = status ? CGFloat(InnerConstants.Border.borderWidth) : CGFloat(InnerConstants.Border.zeroWidth)
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
    
    private func ownInit(title: String? = nil, hasBorder: Bool = false) {
        self.stackView = UIStackView()
        if let stackView = self.stackView {
            self.addSubview(stackView)
        }
        
        self.stackView?.axis = .horizontal
        self.stackView?.distribution = .fill
        self.stackView?.alignment = .fill
        
        self.setPadding(
            top: hasBorder ? CGFloat(InnerConstants.StackView.Padding.top) : CGFloat(InnerConstants.StackView.Padding.noPadding),
            left: hasBorder ? CGFloat(InnerConstants.StackView.Padding.left) : CGFloat(InnerConstants.StackView.Padding.noPadding),
            bottom: hasBorder ? CGFloat(InnerConstants.StackView.Padding.bottom) : CGFloat(InnerConstants.StackView.Padding.noPadding),
            rigth: hasBorder ? CGFloat(InnerConstants.StackView.Padding.right) : CGFloat(InnerConstants.StackView.Padding.noPadding))
        
        self.enableBorder(hasBorder)
        
        self.button = BEMCheckBox(frame:
            CGRect(
                x: 0,
                y: 0,
                width: frame.height * InnerConstants.Button.frameButtonHeighRatio,
                height: 0))
        
        self.button?.animationDuration = CGFloat(InnerConstants.Button.animationDuration)
        self.button?.delegate = self
        self.button?.onAnimationType = .fade
        self.button?.offAnimationType = .fade
        self.button?.onCheckColor = .white
        self.button?.onTintColor = .white
        self.button?.onFillColor = InnerConstants.Colors.blue
        
        self.button?.setContentHuggingPriority(UILayoutPriority(2), for: NSLayoutConstraint.Axis.horizontal)
        
        guard let button = self.button else {
            return
        }
        self.stackView?.addArrangedSubview(button)
        
        self.label = UILabel(frame:
            CGRect(
                x: 0,
                y: 0,
                width: frame.width,
                height: 0))
        
        self.label?.text = title
        
        self.label?.setContentHuggingPriority(UILayoutPriority(1), for: NSLayoutConstraint.Axis.horizontal)
        
        guard let label = self.label else {
            return
        }
        self.stackView?.addArrangedSubview(label)
        
        self.stackView?.spacing = CGFloat(InnerConstants.StackView.spacing)
        
        self.layer.borderColor = InnerConstants.Border.borderColor
        self.layer.cornerRadius = CGFloat(InnerConstants.Border.cornerRadius)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapTheWholeView)))
    }
    
    @objc private func didTapTheWholeView() {
        self.set(status: !self.getStatus())
        self.listener?.onItemClicked(title: self.label?.text, from: self)
    }
}

extension MultipleSelectionItem: BEMCheckBoxDelegate {
    public func didTap(_ checkBox: BEMCheckBox) {
        self.listener?.onItemClicked(title: self.label?.text, from: self)
    }
}


