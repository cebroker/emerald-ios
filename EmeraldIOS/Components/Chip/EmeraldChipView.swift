//
//  EmeraldChipView.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 7/17/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

protocol EmeraldChipDelegate {
    func didTapButton()
}

protocol EmeraldChipViewType {
    func setText(_ text: String)
    func setAvatar(_ avatar: EmeraldAvatar)
    func setID(_ id: String)
}

public class EmeraldChipView: UIView {

    private struct InnerConstant {
        static let viewHeight: CGFloat = CGFloat(integerLiteral: 50)
        static let margin: CGFloat = CGFloat(integerLiteral: 10)
        static let dismissPadding: CGFloat = CGFloat(integerLiteral: 7)
    }

    @IBInspectable public var type: String = EmeraldChipStyle.simpleDefault.rawValue {
        didSet { applyTheme() }
    }

    private var id: String!
    private var text: String! {
        didSet {
            self.textLabel.text = self.text
            self.updateView()
        }
    }

    var delegate: EmeraldChipDelegate?

    private lazy var containerStack: UIStackView = {
        let stackView = UIStackView()

        stackView.clipsToBounds = true
        stackView.distribution = .fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.contentMode = .scaleToFill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var avatarImage: EmeraldAvatar = {
        return EmeraldAvatar()
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

    public override func didMoveToWindow() {
        super.didMoveToWindow()

        self.setupComponent()
        self.setupConstraint()
        self.applyTheme()
    }

    private func setupComponent() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.containerView)
        self.containerView.addSubview(self.containerStack)
        self.containerStack.addArrangedSubview(self.textLabel)
        self.containerStack.addArrangedSubview(self.dismissContainer)
        self.dismissContainer.addSubview(self.dismissButton)
    }

    private func setupConstraint() {

        self.containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.containerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.containerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true

        self.containerStack.anchor(
            top: self.containerView.topAnchor,
            left: self.containerView.leftAnchor,
            bottom: self.containerView.bottomAnchor,
            right: self.containerView.rightAnchor,
            paddingTop: 0,
            paddingLeft: InnerConstant.margin,
            paddingBottom: 0,
            paddingRight: 0,
            width: 0,
            height: 0)

        self.textLabel.anchor(
            top: self.containerStack.topAnchor,
            left: self.containerStack.leftAnchor,
            bottom: self.containerStack.bottomAnchor,
            right: nil)


        self.dismissContainer.anchor(
            top: self.containerStack.topAnchor,
            left: nil,
            bottom: self.containerStack.bottomAnchor,
            right: self.containerStack.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0,
            width: 30,
            height: 0)

        self.dismissButton.anchor(
            top: self.dismissContainer.topAnchor,
            left: self.dismissContainer.leftAnchor,
            bottom: self.dismissContainer.bottomAnchor,
            right: self.dismissContainer.rightAnchor,
            paddingTop: InnerConstant.dismissPadding,
            paddingLeft: InnerConstant.dismissPadding,
            paddingBottom: InnerConstant.dismissPadding,
            paddingRight: InnerConstant.dismissPadding,
            width: 0,
            height: 0)
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

    private func updateView() {
        guard let labelWidth = self.textLabel.text?.width(with: self.textLabel.font) else {
            return
        }

        let fixedWidth = labelWidth + (InnerConstant.margin * 3) + InnerConstant.viewHeight
        self.containerView.widthAnchor.constraint(equalToConstant: fixedWidth).isActive = true
    }

    @objc private func dismissButonTapped(_ sender: UIButton) {
        print("Dismiss")
        self.delegate?.didTapButton()
    }

}

extension EmeraldChipView: EmeraldChipViewType {
    public func setText(_ text: String) {
        self.text = text
    }

    public func setAvatar(_ avatar: EmeraldAvatar) {
        self.avatarImage = avatar
    }

    public func setID(_ id: String) {
        self.id = id
    }
}
