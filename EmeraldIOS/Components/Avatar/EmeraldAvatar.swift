//
//  EmeraldAvatar.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 6/18/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol EmeraldAvatarFieldType {
    func setTitle(with name: String?, lastName: String?)
    func set(size: EmeraldAvatarStyle)
    func setBackgroundColor(_ color: UIColor)
}

@IBDesignable
public class EmeraldAvatar: UIView, EmeraldAvatarFieldType {

    typealias colors = EmeraldTheme.Avatar

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "JD"
        return label
    }()

    private var backgroundColors: [UIColor] = [
        colors.aquamarineColor, colors.reddishBrownColor, colors.cyanColor, colors.chelseaCucumberColor, colors.hillaryColor, colors.bullShotColor, colors.purpleColor, colors.lavenderColor, colors.downyColor]

    private var titleColor: [UIColor] = [EmeraldTheme.whiteColor, EmeraldTheme.blackColor]

    @IBInspectable public var size: String = EmeraldAvatarStyle.md.IBInspectable {
        didSet {
            applyTheme()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        prepareForInterfaceBuilder()
    }

    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyTheme()
        setupLabel()
    }

    open func applyTheme() {
        let style = EmeraldAvatarStyle(IBInspectable: size)
        self.backgroundColor = backgroundColors[Int.random(in: 0 ..< backgroundColors.count)]
        self.titleLabel.font = style.font
        self.widthAnchor.constraint(equalToConstant: style.size).isActive = true
        self.heightAnchor.constraint(equalToConstant: style.size).isActive = true
        self.layer.cornerRadius = style.size / 2.0
        self.clipsToBounds = true
    }

    private func setupLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = titleColor[Int.random(in: 0 ..< titleColor.count)]
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
    }

    public func setTitle(with firstName: String?, lastName: String?) {
        let name = firstName?.first ?? "J"
        let lastname = lastName?.first ?? "D"
        self.titleLabel.text = "\(name)\(lastname)"
    }

    public func set(size: EmeraldAvatarStyle) {
        self.size = size.rawValue
    }
    
    public func setBackgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }
    
    public func setTextColor(_ color: UIColor) {
        self.titleLabel.textColor = color
    }
}
