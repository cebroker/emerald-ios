//
//  Extensions+UIViewController.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/9/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

extension UIViewController {
    func showAlert(_ message: String) {
        showAlert(message, andTitle: "")
    }
    
    func showAlert(_ message: String, andTitle title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
