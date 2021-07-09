//
//  EmeraldChipCollectionViewCell.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 7/24/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

protocol EmeraldChipCollectionCellType {
    func setupChip(with text: String, and type: EmeraldChipStyle)
}

protocol ChipCellDismissable: class {
    func chipDismissTapped(_ cell: EmeraldChipCollectionViewCell)
}

class EmeraldChipCollectionViewCell: UICollectionViewCell, EmeraldChipCollectionCellType {

    weak var delegate: ChipCellDismissable?
    private lazy var chip: EmeraldChipView = {
        let chip = EmeraldChipView()
        return chip
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.chip.setText("")
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("You cann't create a EmeraldChipCell by storyboard.")
    }

    private func setupView() {
        self.contentView.addSubview(self.chip)
        self.chip.delegate = self
        chip.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
    }

    func setupChip(with text: String, and type: EmeraldChipStyle) {
        self.chip.setText(text)
        self.chip.setType(type)
    }
}

extension EmeraldChipCollectionViewCell: EmeraldChipDismissable {
    func didTapButton() {
        self.delegate?.chipDismissTapped(self)
    }
}
