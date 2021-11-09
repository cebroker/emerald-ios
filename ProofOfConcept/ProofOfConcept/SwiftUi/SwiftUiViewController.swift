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
        if #available(iOS 13.0.0, *) {
            let childView = UIHostingController(rootView: SwiftUiView())
            addChild(childView)
            container.addSubview(childView.view)
            childView.view.translatesAutoresizingMaskIntoConstraints = false
            childView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            childView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            childView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            childView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        
    }
}
