//
//  Toash.swift
//  EmeraldIOS
//
//  Created by Gustavo Forero on 6/19/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit
public protocol StatusType {
    var backgroundColor: UIColor? { get }
    var image: UIImage? { get }
    var borderColor: UIColor? { get }
}

public enum ToastStatus: StatusType {
    case success
    case failure
}

public enum EmeraldAlertDuration: TimeInterval {
    case short = 3.0
    case long = 4.5
}

public extension ToastStatus {
    var backgroundColor: UIColor? {
        switch self {
        case .success:
            return EmeraldTheme.toastSuccess
        case .failure:
            return EmeraldTheme.toastFailure
        }
    }

    var image: UIImage? {
        switch self {
        case .success:
            return UIImage(named: "success.png",
                in: Bundle(for: ClassBundle.self),
                compatibleWith: nil)
        case .failure:
            return UIImage(named: "failure.png",
                in: Bundle(for: ClassBundle.self),
                compatibleWith: nil)
        }
    }

    var borderColor: UIColor? {
        switch self {
        case .success:
            return EmeraldTheme.greenColor
        case .failure:
            return EmeraldTheme.redColor
        }
    }
}

extension UIViewController {

    struct InnerConstants {
        static let verticalConstraintInitial = CGFloat(-40.0)
        static let verticalConstraintFinal = CGFloat(700.0)
    }

    private func hideKeyboard() {
        view.endEditing(true)
    }

    /**
     It shows a snackbar in bottom screen
     
     - Parameter message: The text to show inside the view.
     - Parameter status: there are 2 status supported, *success* and *failure* each one show different configurations like background color and icon .
     - Parameter duration: it defines the time in screen could be *short* or  *long*
     
     */
    public func showToast(message: String, status: ToastStatus, duration: EmeraldAlertDuration) {
        hideKeyboard()
        let uiview = UIView()
        self.view.addSubview(uiview)
        uiview.layer.borderWidth = EmeraldTheme.defaultBorderWidth
        uiview.layer.borderColor = status.borderColor?.cgColor
        uiview.layer.cornerRadius = EmeraldTheme.defaultCornerRadius
        uiview.layer.backgroundColor = status.backgroundColor?.cgColor
        uiview.translatesAutoresizingMaskIntoConstraints = false
        uiview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uiview.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        uiview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        let bottomConstraint = uiview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 100.0)
        bottomConstraint.isActive = true

        let stack = UIStackView()
        uiview.addSubview(stack)

        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8.0
        stack.distribution = .fill
        stack.alignment = .center
        stack.topAnchor.constraint(equalTo: uiview.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: uiview.bottomAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: uiview.leadingAnchor, constant: 10.0).isActive = true
        stack.trailingAnchor.constraint(equalTo: uiview.trailingAnchor, constant: -10.0).isActive = true

        let image = UIImageView()
        image.image = status.image
        image.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
        image.widthAnchor.constraint(equalToConstant: 18.0).isActive = true

        let toastLabel = EmeraldLabel()
        toastLabel.themeFontSize = FontSize.h6.rawValue
        toastLabel.numberOfLines = 0
        toastLabel.textColor = EmeraldTheme.darkGrayColor
        toastLabel.text = message

        stack.addArrangedSubview(image)
        stack.addArrangedSubview(toastLabel)

        UIView.animate(withDuration: 0.0, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            self.showMessageWith(constraint: bottomConstraint, delay: duration.rawValue, view: uiview)
        }
    }

    private func hideMessageWith(constraint: NSLayoutConstraint, delay: Double, view: UIView) {
        constraint.constant = InnerConstants.verticalConstraintFinal
        UIView.animate(withDuration: 0.8, delay: delay, options: [.curveEaseInOut, .preferredFramesPerSecond60], animations: {
                self.view.layoutIfNeeded()
                view.alpha = 0.0
            }, completion: { (_) in
                view.removeFromSuperview()
            })
    }

    private func showMessageWith(constraint: NSLayoutConstraint, delay: Double, view: UIView) {
        constraint.constant = InnerConstants.verticalConstraintInitial
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [.curveEaseInOut, .preferredFramesPerSecond60], animations: {
                self.view.layoutIfNeeded()
            }, completion: { (_) in
                self.hideMessageWith(constraint: constraint, delay: delay, view: view)
            })
    }

}
