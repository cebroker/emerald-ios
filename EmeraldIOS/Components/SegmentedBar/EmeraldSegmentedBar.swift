//
//  EmeraldSegmentedBar.swift
//  EmeraldIOS
//
//  Created by Felipe Correa on 5/23/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public protocol EmeraldSegmentedBarActionable: class {
    func segmentedBar(_ bar: EmeraldSegmentedBar, didTapItemAt index: Int, with title: String)
}

@IBDesignable
public class EmeraldSegmentedBar: UIView {
    
    @IBInspectable public var segments: String = "" {
        didSet {
            titles = segments.split(separator: "\n").map { String($0) }
        }
    }
    
    @IBInspectable public var isSelectionBarHidden: Bool = false {
        didSet {
            horizontalBarView.isHidden = isSelectionBarHidden
        }
    }
    
    @IBInspectable public var themeStyle: String = EmeralSegmentedBarStyle.primary.IBInspectable {
        didSet {
            applyTheme()
        }
    }
    
    public func setTheme(_ theme: EmeralSegmentedBarStyle) {
        themeStyle = theme.IBInspectable
    }
    
    public func setTitles(_ titles: [String]) {
        self.titles = titles
    }
    
    public var selectedItemIndex: Int {
        return _selectedItemIndex
    }
    
    public weak var delegate: EmeraldSegmentedBarActionable?
    
    private lazy var collectionView: UICollectionView = {
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
    
    private let cellTitleId = "cellTitleId"
    private var titles: [String] = [""]
    private var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    private var _selectedItemIndex = 0
    
    private var desiredHorizontalBarLeftPosition: CGFloat {
        return (self.frame.width / CGFloat(self.titles.count)) * CGFloat(_selectedItemIndex)
    }
    
    public init(titles: [String]) {
        if titles.isEmpty {
            fatalError("There must be at least one element")
        }
        self.titles = titles
        super.init(frame: .zero)
        initialize()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        initialize()
        applyTheme()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyTheme()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func initialize() {
        setupCollectionView()
        setupSelectionBar()
        applyTheme()
        if titles.isEmpty { return }
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
    }
    
    open func applyTheme() {
        let style = EmeralSegmentedBarStyle(IBInspectable: themeStyle)
        collectionView.backgroundColor = style.backgroundColor
        horizontalBarView.backgroundColor = style.selectionBarColor
        EmeraldSegmentedBarItemCell.defaultTheme = style.titlesStyle
    }
    
    public func moveSelectionBar(to itemIndex: Int) {
        self.collectionView.selectItem(at: IndexPath(row: itemIndex, section: 0), animated: true, scrollPosition: .left)
        self._selectedItemIndex = itemIndex
        self.horizontalBarLeftAnchorConstraint?.constant = desiredHorizontalBarLeftPosition
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setupSelectionBar() {
        addSubview(horizontalBarView)
        selectionBarConstraints()
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.register(EmeraldSegmentedBarItemCell.self, forCellWithReuseIdentifier: cellTitleId)
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
}

extension EmeraldSegmentedBar: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellTitleId, for: indexPath) as? EmeraldSegmentedBarItemCell else {
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
        self.delegate?.segmentedBar(self, didTapItemAt: indexPath.row, with: titles[indexPath.row])
    }
}
