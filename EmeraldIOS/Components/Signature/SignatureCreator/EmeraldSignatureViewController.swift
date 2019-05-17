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
    
    @IBOutlet private weak var signatureIcon: UIImageView!
    @IBOutlet private weak var doneButton: EmeraldButton!
    @IBOutlet private weak var clearButton: EmeraldButton!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var subtitleLabel: EmeraldLabel!
    @IBOutlet private weak var viewMargin: UIView!
    @IBOutlet weak var signatureView: EmeraldCanvasView!
    
    open weak var signatureDelegate: SignatureReturnable?
    open var tintColor = EmeraldTheme.primaryColor
    open var subtitleText = "Sign Here"
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let bundle = Bundle(for: EmeraldSignatureViewController.classForCoder())
        super.init(nibName: "EmeraldSignatureView", bundle: bundle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Setup methods
    private func setupView() {
        signatureIcon.image = #imageLiteral(resourceName: "xIcon.png").withRenderingMode(.alwaysTemplate)
        signatureIcon.tintColor = EmeraldTheme.grayColor
        closeButton.setImage(#imageLiteral(resourceName: "xIcon.png").withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.setImage(#imageLiteral(resourceName: "xIcon.png").withRenderingMode(.alwaysTemplate), for: .highlighted)
        closeButton.setImage(#imageLiteral(resourceName: "xIcon.png").withRenderingMode(.alwaysTemplate), for: .selected)
        closeButton.tintColor = EmeraldTheme.primaryColor
        closeButton.addTarget(self,
                              action: #selector(onTouchCloseButton),
                              for: .touchUpInside)
        
        signatureView.layer.borderColor = EmeraldTheme.borderColor.cgColor
        signatureView.layer.borderWidth = Constants.Values.one
        signatureView.layer.cornerRadius = EmeraldTheme.defaultElevatedViewCornerRadius
        
        clearButton.addTarget(self, action: #selector(onTouchClearButton), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(onTouchDoneButton), for: .touchUpInside)
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
        if let _ = signatureView.getSignatureAsImage() {
            showAlertConfirmation()
        } else {
            signatureDelegate?.emeraldSignature?(
                self,
                didCancel: InnerConstants.didCancelError)
            dismiss(animated: true, completion: nil)
        }
    }

    @objc func onTouchDoneButton() {
        if let signature = signatureView.getSignatureAsImage() {
            signatureDelegate?.emeraldSignature?(
                self,
                didSign: signature,
                boundingRect: signatureView.getSignatureBoundsInCanvas())
            dismiss(animated: true, completion: nil)
        } else {
            showAlert("You did not sign", andTitle: "Please draw your signature")
        }
    }

    @objc func onTouchClearButton() {
        signatureView.clear()
    }
}
