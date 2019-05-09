////
////  EmeraldSignatureViewController.swift
////  EmeraldIOS
////
////  Created by Genesis Sanguino on 5/8/19.
////  Copyright © 2019 Condor Labs. All rights reserved.
////
//
//import Foundation
//
//public protocol SignatureImageObtenable {
//    func setSignature(with image: UIImage)
//}
//
//public class EmeraldSignatureViewController: UIViewController, SignatureType {
//    
//    lazy var signatureView = SignatureView()
//    public var delegate: SignatureImageObtenable? = nil
//
//    public override func loadView() {
//        self.view = signatureView
//    }
//
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//        signatureView.backgroundColor = EmeraldTheme.whiteColor
//        setupNavigation()
//    }
//
//    public override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//
//    @objc func closeView() {
//        self.showAlertConfirmation()
//    }
//
//    @objc func handleDone() {
//        if let currentImageOnCanvas = self.getCurrentSignature() {
//            self.delegate?.setSignature(with: currentImageOnCanvas)
//            self.dismiss(animated: true, completion: nil)
//        } else {
//            showAlertMessage()
//        }
//    }
//
//    @objc func handleClear() {
//        signatureView.clear()
//    }
//
//    public func setBottomText(with currentString: String) {
//        signatureView.bottomTextLabel.text = currentString
//    }
//
//    public func getCurrentSignature() -> UIImage? {
//        return signatureView.getCurrentSignature()
//    }
//
//    fileprivate func setupNavigation() {
//        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closeView))
//
//        self.navigationController?.navigationBar.topItem?.rightBarButtonItems = [
//            UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(handleClear)),
//            UIBarButtonItem(title: "", style: .plain, target: nil, action: nil),
//            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDone))
//        ]
//    }
//
//    private func showAlertConfirmation() {
//        let alert = UIAlertController(title: nil,
//                                      message: "Are you sure you want to cancel?",
//                                      preferredStyle: .alert)
//
//
//
//        let okAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { _ -> Void in
//            self.dismiss(animated: true, completion: nil)
//        }
//
//        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { _ -> Void in
//            alert.dismiss(animated: true, completion: nil)
//        }
//
//        alert.addAction(okAction)
//        alert.addAction(cancelAction)
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    private func showAlertMessage() {
//        let alert = UIAlertController(title: nil,
//                                      message: "You have to insert your signature",
//                                      preferredStyle: .alert)
//
//
//
//        let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default) { _ -> Void in
//            alert.dismiss(animated: true, completion: nil)
//        }
//
//        alert.addAction(okAction)
//        self.present(alert, animated: true, completion: nil)
//    }
//}
