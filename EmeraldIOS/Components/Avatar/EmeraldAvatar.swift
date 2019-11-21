//
//  EmeraldAvatar.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 6/18/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol EmeraldAvatarFieldType {
    func set(size: EmeraldAvatarStyle)
    func setTitle(with name: String?, lastName: String?)
    func setBackgroundColor(_ avatarColor: AvatarBackgroundColor)
    func setTextColor(_ avatarColor: AvatarTextColor)
    func getBackgroundColor() -> AvatarBackgroundColor
    func getTextColor() -> AvatarTextColor
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

    private var avatarColors: [AvatarBackgroundColor] = AvatarBackgroundColor.allCases
    private var titleColor: [AvatarTextColor] = AvatarTextColor.allCases

    private var avatarBackgroundColor: AvatarBackgroundColor! {
        willSet {
            self.backgroundColor = newValue.color
        }
    }

    private var avatarTitleColor: AvatarTextColor! {
        willSet {
            self.titleLabel.textColor = newValue.color
        }
    }

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
        self.avatarBackgroundColor = avatarColors[Int.random(in: 0 ..< avatarColors.count)]
        self.titleLabel.font = style.font
        self.widthAnchor.constraint(equalToConstant: style.size).isActive = true
        self.heightAnchor.constraint(equalToConstant: style.size).isActive = true
        self.layer.cornerRadius = style.size / 2.0
        self.clipsToBounds = true
    }

    private func setupLabel() {
        addSubview(titleLabel)
        self.avatarTitleColor = titleColor[Int.random(in: 0 ..< titleColor.count)]
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

    public func setBackgroundColor(_ avatarColor: AvatarBackgroundColor) {
        self.avatarBackgroundColor = avatarColor
    }

    public func setTextColor(_ avatarColor: AvatarTextColor) {
        self.avatarTitleColor = avatarColor
    }

    public func getBackgroundColor() -> AvatarBackgroundColor {
        return self.avatarBackgroundColor
    }

    public func getTextColor() -> AvatarTextColor {
        return self.avatarTitleColor
    }
}
