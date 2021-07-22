//
//  SwiftUiViewController.swift
//  ProofOfConcept
//
//  Created by Daniel Crespo Duarte on 7/22/21.
//  Copyright © 2021 Luis David Goyes Garces. All rights reserved.
//

import UIKit
import SwiftUI

class SwiftUiViewController: UIViewController {
    @IBOutlet weak var container: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 14.0.0, *) {
            let childView = UIHostingController(rootView: SwiftUiView())
            addChild(childView)
            childView.view.frame = container.bounds
            container.addSubview(childView.view)
        } else {
            // Fallback on earlier versions
        }
        
    }
}
