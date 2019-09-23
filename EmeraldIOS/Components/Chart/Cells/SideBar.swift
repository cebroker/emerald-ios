//
//  SideBar.swift
//  EmeraldIOS
//
//  Created by Miguel Roncallo on 9/23/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import Foundation

class SideBarReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 60.0 / 255.0, green: 59.0 / 255.0, blue: 92.0 / 255.0, alpha: 0.9)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
