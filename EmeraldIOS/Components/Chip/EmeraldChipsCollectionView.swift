//
//  EmeraldChipsUICollectionView.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 7/24/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public protocol EmeraldChipCollectionViewType {
    func addNewChip(with viewModel: ChipViewModel)
}

public struct ChipViewModel {
    var text: String
    var type: EmeraldChipStyle

    public init(text: String, type: EmeraldChipStyle) {
        self.text = text
        self.type = type
    }
}

public class EmeraldChipsCollectionView: UICollectionView, EmeraldChipCollectionViewType {

    struct InnerConstant {
        static let reuseIdentifier = "Cell"
    }

    private var chips: [ChipViewModel] = [] {
        didSet { self.updateView() }
    }

    private func updateView() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.collectionViewLayout = layout
        
        self.delegate = self
        self.dataSource = self
        self.register(EmeraldChipCollectionViewCell.self, forCellWithReuseIdentifier: InnerConstant.reuseIdentifier)
    }

    public func addNewChip(with viewModel: ChipViewModel) {
        chips.append(viewModel)
    }
}

extension EmeraldChipsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.chips.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InnerConstant.reuseIdentifier, for: indexPath) as! EmeraldChipCollectionViewCell

        let chipViewModel = self.chips[indexPath.row]
        cell.setupChip(with: chipViewModel.text, and: chipViewModel.type)
        cell.delegate = self
        return cell
    }
}

extension EmeraldChipsCollectionView: ChipCellDismissable {
    func chipDismissTapped(_ cell: EmeraldChipCollectionViewCell) {
        guard let index = self.indexPath(for: cell)?.row else {
            return
        }

        self.chips.remove(at: index)
    }
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0

        attributes?.forEach({ layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        })

        return attributes
    }
}
