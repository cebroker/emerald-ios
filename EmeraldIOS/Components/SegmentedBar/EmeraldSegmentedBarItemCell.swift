//
//  EmeraldSegmentedBarItemCell.swift
//  EmeraldIOS
//
//  Created by Felipe Correa on 5/23/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

class EmeraldSegmentedBarItemCell: EmeraldSegmentedBarBaseCell {

    static var defaultTheme = SegmentedTitleStyle.primary

    override var isHighlighted: Bool {
        didSet {
            titleLabel.textColor = self.desiredColor(isHighlighted)
            titleLabel.font = self.desiredFont(isHighlighted)
        }
    }

    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = self.desiredColor(isSelected)
            titleLabel.font = self.desiredFont(isSelected)
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = self.desiredColor(false)
        label.font = self.desiredFont(false)
        label.textAlignment = .center
        return label
    }()

    override func setupViews() {
        super.setupViews()
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }

    func setTitle(_ title: String) {
        titleLabel.attributedText = self.addStringSpacing(to: title)
    }

    func addStringSpacing(to title: String) -> NSAttributedString {
        return NSAttributedString(
            string: title,
            attributes: [
                NSAttributedString.Key.kern: EmeraldSegmentedBarItemCell.defaultTheme.titleSpacing
            ])
    }

    private func desiredColor(_ isSelected: Bool) -> UIColor {
        let theme = EmeraldSegmentedBarItemCell.defaultTheme
        return isSelected ? theme.colorWhenSelected : theme.colorWhenHighlighted
    }

    private func desiredFont(_ isSelected: Bool) -> UIFont {
        let theme = EmeraldSegmentedBarItemCell.defaultTheme
        return isSelected ? theme.fontWhenSelected : theme.fontWhenHighlighted
    }
}
