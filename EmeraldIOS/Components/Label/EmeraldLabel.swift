//
//  EmeraldLabel.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/3/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

@IBDesignable
public class EmeraldLabel: UILabel, EmeraldValidableType {
    
    @IBInspectable public var themeStyle: String = EmeraldLabelStyle.custom.IBInspectable {
        didSet {
            applyTheme()
        }
    }
    
    @IBInspectable public var themeColor: String = ColorPallete.text.IBInspectable {
        didSet {
            applyTheme()
        }
    }
    
    @IBInspectable public var themeFontSize: String = FontSize.body.rawValue {
        didSet {
            applyTheme()
        }
    }
    
    @IBInspectable public var themeFontWeight: String = FontWeight.regular.rawValue {
        didSet {
            applyTheme()
        }
    }
    
    private var themeFont: Typography? {
        guard let fontSize = FontSize(rawValue: themeFontSize) else {
            return nil
        }
        
        guard let fontWeight = FontWeight(rawValue: themeFontWeight) else {
            return nil
        }
        
        return Typography(size: fontSize, weight: fontWeight)
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
        let style = EmeraldLabelStyle(IBInspectable: themeStyle)
        if case .custom = style {
            textColor = ColorPallete.uiColor(themeColor)
            font = themeFont?.uiFont
        } else {
            textColor = style.textColor
            font = style.font
        }
    }
}
