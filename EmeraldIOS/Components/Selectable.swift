//
//  Selectable.swift
//  EmeraldIOS
//
//  Created by Luis David Goyes Garces on 3/6/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

@objc public protocol Selectable {
    func getSelectableText() -> String
    @objc optional func getSelectableId() -> String
    @objc optional func setSelectableText(with value: String)
    @objc optional func setSelectableId(with value: String)
}

public class MultipleSelectionGroupItem: Selectable {
    private(set) public var id: String
    private(set) public var title: String
    
    public init(id: String = "", title: String) {
        self.id = id
        self.title = title
    }
}

extension MultipleSelectionGroupItem {
    public func setSelectableText(with value: String) {
        self.title = value
    }
    
    public func setSelectableId(with value: String) {
        self.id = value
    }
    
    public func getSelectableText() -> String {
        return title
    }
    
    public func getSelectableId() -> String {
        return id
    }
}
