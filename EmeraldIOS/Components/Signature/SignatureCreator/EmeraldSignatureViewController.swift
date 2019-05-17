//
//  EmeraldSignatureViewController.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/8/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//
import UIKit

@IBDesignable
public class EmeraldSignatureViewController: UIViewController {
    
    private struct InnerConstants {
        static let didCancelError = NSError(
            domain: "EmeraldSignatureDomain",
            code: 1,
            userInfo: [
                NSLocalizedDescriptionKey: "User not signed"
            ])
    }
    
    private lazy var signatureXib = EmeraldSignatureView()
    open weak var signatureDelegate: SignatureReturnable?
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupView()
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Setup methods
    private func setupView() {
        self.view.backgroundColor = EmeraldTheme.backgroundColor
        self.view.addSubview(signatureXib)
        
        signatureXib.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                            left: self.view.safeAreaLayoutGuide.leftAnchor,
                            bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                            right: self.view.safeAreaLayoutGuide.rightAnchor)
        
        signatureXib.closeButton.addTarget(self,
                              action: #selector(onTouchCloseButton),
                              for: .touchUpInside)
        
        signatureXib.clearButton.addTarget(self, action: #selector(onTouchClearButton), for: .touchUpInside)
        signatureXib.doneButton.addTarget(self, action: #selector(onTouchDoneButton), for: .touchUpInside)
    }
    
    private func showAlertConfirmation() {
        let alert = UIAlertController(title: nil,
                                      message: "Are you sure you want to cancel?",
                                      preferredStyle: .alert)
        
        
        
        let okAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { _ -> Void in
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "No", style: .cancel) { _ -> Void in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

    
    // MARK: - Button Actions
    @objc func onTouchCloseButton() {
        if let _ = signatureXib.signatureView.getSignatureAsImage() {
            showAlertConfirmation()
        } else {
            signatureDelegate?.emeraldSignature?(
                self,
                didCancel: InnerConstants.didCancelError)
            dismiss(animated: true, completion: nil)
        }
    }

    @objc func onTouchDoneButton() {
        if let signature = signatureXib.signatureView.getSignatureAsImage() {
            signatureDelegate?.emeraldSignature?(
                self,
                didSign: signature,
                boundingRect: signatureXib.signatureView.getSignatureBoundsInCanvas())
            dismiss(animated: true, completion: nil)
        } else {
            showAlert("You did not sign", andTitle: "Please draw your signature")
        }
    }

    @objc func onTouchClearButton() {
        signatureXib.signatureView.clear()
    }
}
