//
//  TestViewController.swift
//  ProofOfConcept
//
//  Created by Carlos Pava on 26/11/19.
//  Copyright © 2019 Luis David Goyes Garces. All rights reserved.
//

import UIKit
import EmeraldIOS

class TestViewController: UIViewController, EmeraldValidableType {

 
    @IBOutlet weak var textView: EmeraldInputView!
    @IBOutlet weak var textfieldView2: EmeraldInputView!

    var textFields: [EmeraldValidableType] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        textFields = [textView, textfieldView2]
        textView.setPlaceholder(placeholder:"example placeholder")
    }

    @IBAction func onToogle(_ sender: UIButton) {
        textFields.forEach { (textField) in
            textField.validateAndHandle()
        }
    }
}
