//
//  EmeraldButton.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/3/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

@IBDesignable
public class EmeraldButton: UIButton, EmeraldValidableType {
    @IBInspectable public var themeStyle: String = EmeraldButtonStyle.primary.IBInspectable {
        didSet {
            applyTheme()
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = EmeraldTheme.defaultButtonCornerRadius {
        didSet {
            applyTheme()
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            applyTheme()
        }
    }
    
    override public var isHighlighted: Bool {
        didSet {
            applyTheme()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        applyTheme()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyTheme()
    }
    
    open func applyTheme() {
        let style = EmeraldButtonStyle(IBInspectable: themeStyle)
        
        titleLabel?.font = style.font
        
        setTitleColor(style.titleColor, for: .normal)
        setTitleColor(style.highlightedTitleColor, for: .highlighted)
        
        backgroundColor = isHighlighted ? style.highlightedBackgroundColor : style.backgroundColor
        
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.borderWidth = style.borderWidth
        layer.borderColor = style.borderColor?.cgColor
        alpha = isEnabled ? 1.00 : 0.65
    }
}
