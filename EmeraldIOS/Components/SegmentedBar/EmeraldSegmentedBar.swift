//
//  EmeraldSegmentedBar.swift
//  EmeraldIOS
//
//  Created by Felipe Correa on 5/23/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

protocol EmeraldSegmentedBarActionable: class {
    func segmentedBar(_ bar: EmeraldSegmentedBar, didTappedItemAt index: Int, with title: String)
}

@IBDesignable
public class EmeraldSegmentedBar: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    private lazy var horizontalBarView: UIView = {
        let view = UIView()
        return view
    }()
    
    let cellId = "cellId"
    
    public var titles: [String]!
    
    public var isSelectionBarHidden = false {
        didSet {
            horizontalBarView.isHidden = isSelectionBarHidden
        }
    }
    
    public var selectedItemIndex: Int {
        return _selectedItemIndex
    }
    
    public var titlesAppearence: (() -> SegmentedTitleAppearance)? = nil {
        didSet {
            guard let app = titlesAppearence else { return }
            EmeraldSegmentedBarItemCell.defaultTheme = app()
        }
    }
    
    public var appearance: (() -> EmeraldSegmentedBarAppearance)? {
        didSet {
            guard let app = appearance else {
                return
            }
            _theme = app()
            collectionView.backgroundColor = _theme.backgroundColor
            horizontalBarView.backgroundColor = _theme.selectionBarColor
        }
    }
    
    private var _theme: EmeraldSegmentedBarAppearance!
    private var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    weak var delegate: EmeraldSegmentedBarActionable?
    private var _selectedItemIndex = 0
    
    private var desiredHorizontalBarLeftPosition: CGFloat {
        return (self.frame.width / CGFloat(self.titles.count)) * CGFloat(_selectedItemIndex)
    }
    
    public init(titles: [String]) {
        if titles.count < 1 {
            fatalError("There must be at least one element")
        }
        self.titles = titles
        _theme = EmeraldSegmentedBarAppearance(backgroundColor: .green,
                                               selectionBarColor: .brown)
        super.init(frame: .zero)
        initialize()
    }
    
    private func initialize() {
        setupCollectionView()
        setupSelectionBar()
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setupSelectionBar() {
        addSubview(horizontalBarView)
        selectionBarConstraints()
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.register(EmeraldSegmentedBarItemCell.self, forCellWithReuseIdentifier: cellId)
        collectionConstraints()
    }
    
    private func collectionConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func selectionBarConstraints() {
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/CGFloat(titles.count)).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    func moveSelectionBar(to itemIndex: Int) {
        self._selectedItemIndex = itemIndex
        self.horizontalBarLeftAnchorConstraint?.constant = desiredHorizontalBarLeftPosition
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmeraldSegmentedBar: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? EmeraldSegmentedBarItemCell else {
            fatalError()
        }
        cell.setTitle(titles[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / CGFloat(titles.count), height: frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension EmeraldSegmentedBar: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.moveSelectionBar(to: indexPath.row)
        self.delegate?.segmentedBar(self, didTappedItemAt: indexPath.row, with: titles[indexPath.row])
    }
}
