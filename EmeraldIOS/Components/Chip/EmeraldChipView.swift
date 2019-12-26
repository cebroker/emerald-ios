//
//  EmeraldChipView.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 7/17/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

protocol EmeraldChipDismissable {
    func didTapButton()
}

protocol EmeraldChipViewType {
    func setText(_ text: String)
    func setType(_ type: EmeraldChipStyle)
}

public class EmeraldChipView: UIView {

    private struct InnerConstant {
        static let margin: CGFloat = CGFloat(integerLiteral: 10)
        static let dismissPadding: CGFloat = CGFloat(integerLiteral: 7)
        static let containerWidth: CGFloat = CGFloat(integerLiteral: 30)
    }

    @IBInspectable public var type: String = EmeraldChipStyle.simple.rawValue {
        didSet { applyTheme() }
    }

    private var text: String! {
        didSet { self.textLabel.text = self.text }
    }

    var delegate: EmeraldChipDismissable?

    private lazy var containerView: UIView = {
        let view = UIView()

        view.clipsToBounds = true
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var textLabel: EmeraldLabel = {
        let label = EmeraldLabel()

        label.themeStyle = EmeraldLabelStyle.custom.IBInspectable
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dismissContainer: UIView = {
        let view = UIView()

        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var dismissButton: UIButton = {
        let button = UIButton()

        button.imageView?.contentMode = .scaleAspectFit
        button.layer.cornerRadius = button.bounds.height * 0.5
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(self.dismissButonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(text: String, type: EmeraldChipStyle) {
        self.init(frame: .zero)
        self.text = text
        self.type = type.rawValue
    }

    public override func didMoveToWindow() {
        super.didMoveToWindow()

        self.setupComponent()
        self.setupConstraint()
        self.applyTheme()
    }

    private func setupComponent() {
        let style = EmeraldChipStyle(IBInspectable: self.type)
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.containerView)
        self.containerView.addSubview(self.textLabel)
        if style == .dismissable {
            self.containerView.addSubview(self.dismissContainer)
            self.dismissContainer.addSubview(self.dismissButton)
        }
    }

    private func setupConstraint() {
        self.containerView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)

        self.textLabel.anchor(
            top: self.containerView.topAnchor,
            left: self.containerView.leftAnchor,
            bottom: self.containerView.bottomAnchor,
            right: nil,
            paddingTop: InnerConstant.dismissPadding,
            paddingLeft: InnerConstant.dismissPadding,
            paddingBottom: InnerConstant.dismissPadding,
            paddingRight: 0,
            width: 0,
            height: 0)

        if EmeraldChipStyle(IBInspectable: self.type) == .dismissable {
            setupDismissButtonConstraint()
        } else {
            self.textLabel.numberOfLines = 1
            self.textLabel.rightAnchor.constraint(
                equalTo: self.rightAnchor,
                constant: -InnerConstant.dismissPadding).isActive = true
        }
    }

    private func setupDismissButtonConstraint() {

        NSLayoutConstraint.activate([
            self.dismissContainer.widthAnchor.constraint(equalToConstant: InnerConstant.containerWidth),
            self.dismissContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -InnerConstant.dismissPadding),
            self.dismissContainer.topAnchor.constraint(equalTo: self.topAnchor),
            self.dismissContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.textLabel.rightAnchor.constraint(equalTo: self.dismissContainer.leftAnchor, constant: -InnerConstant.dismissPadding),
            self.dismissButton.centerXAnchor.constraint(equalTo: self.dismissContainer.centerXAnchor),
            self.dismissButton.centerYAnchor.constraint(equalTo: self.dismissContainer.centerYAnchor),
            self.dismissButton.heightAnchor.constraint(equalToConstant: 20),
            self.dismissButton.widthAnchor.constraint(equalToConstant: 20)
            ])
    }

    private func applyTheme() {
        let style = EmeraldChipStyle(IBInspectable: self.type)

        self.containerView.layer.cornerRadius = style.cornerRadious
        self.containerView.backgroundColor = style.backgroundColor
        self.textLabel.textColor = style.textColor
        self.textLabel.font = style.font
        if let icon = style.buttonIcon {
            self.dismissButton.setImage(icon, for: .normal)
        }
    }

    @objc private func dismissButonTapped(_ sender: UIButton) {
        self.delegate?.didTapButton()
    }
}

extension EmeraldChipView: EmeraldChipViewType {
    public func setType(_ type: EmeraldChipStyle) {
        self.type = type.rawValue
    }

    public func setText(_ text: String) {
        self.text = text
    }
}
