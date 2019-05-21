////
////  MultipleSelectionFormField.swift
////  EmeraldIOS
////
////  Created by Luis David Goyes Garces on 2/28/19.
////  Copyright © 2019 Condor Labs. All rights reserved.
////
//
//import UIKit
//
//public protocol MultipleSelectionFormFieldType {
//    func set(data: [Selectable])
//    func set(spacing: CGFloat)
//    func enable(innerBorder: Bool)
//    func set(notifiable: SingleItemChangeNotifiable)
//}
//
//public class MultipleSelectionFormField: FormFieldType<[Selectable]>, MultipleSelectionFormFieldType, SingleItemChangeNotifiable {
//
//    var stackView: UIStackView?
//
//    private struct InnerConstants {
//        struct StackView {
//            struct Dimens {
//                static let spacing = 15
//            }
//            struct Padding {
//                static let top = 10
//                static let left = 20
//                static let bottom = 10
//                static let right = 20
//            }
//        }
//    }
//
//    private var individualItemFrame: CGRect?
//
//    var notifiable: SingleItemChangeNotifiable?
//
//    private var errorLabel: UILabel?
//
//    private var childrenHaveBorder: Bool = false
//
//    public func set(spacing: CGFloat) {
//        self.stackView?.spacing = spacing
//    }
//
//    public func enable(innerBorder childrenHaveBorder: Bool) {
//        self.childrenHaveBorder = childrenHaveBorder
//    }
//
//    public func set(notifiable: SingleItemChangeNotifiable) {
//        self.notifiable = notifiable
//    }
//
//    override func postInit() {
//        stackView = UIStackView(arrangedSubviews: [])
//
//        stackView?.axis = .vertical
//        stackView?.distribution = .equalSpacing
//        stackView?.alignment = .fill
//        stackView?.spacing = CGFloat(InnerConstants.StackView.Dimens.spacing)
//
//        if let stackView = self.stackView {
//            self.addSubview(stackView)
//        }
//
//        stackView?.anchor(
//            top: self.topAnchor,
//            left: self.leftAnchor,
//            bottom: self.bottomAnchor,
//            right: self.rightAnchor,
//            paddingTop: CGFloat(InnerConstants.StackView.Padding.top),
//            paddingLeft: CGFloat(InnerConstants.StackView.Padding.left),
//            paddingBottom: CGFloat(InnerConstants.StackView.Padding.bottom),
//            paddingRight: CGFloat(InnerConstants.StackView.Padding.right),
//            width: 0,
//            height: 0)
//
//        individualItemFrame = CGRect(
//            x: CGFloat(Constants.Dimens.origin),
//            y: CGFloat(Constants.Dimens.origin),
//            width: self.frame.width,
//            height: CGFloat(Constants.Dimens.SingleRadioButton.height))
//    }
//
//    func getChildren() -> [MultipleSelectionItemType]? {
//        return self.stackView?.arrangedSubviews as? [MultipleSelectionItemType]
//    }
//
//    public func onItemClicked(associatedSelectable: Selectable, from item: MultipleSelectionItemType) {
//        self.clearError()
//        self.notifiable?.onItemClicked(associatedSelectable: associatedSelectable, from: item)
//    }
//
//    public override func clearError() {
//        guard let errorLabel = self.errorLabel else {
//            return
//        }
//
//        self.stackView?.removeArrangedSubview(errorLabel)
//        errorLabel.removeFromSuperview()
//        self.stackView?.reloadInputViews()
//
//        self.errorLabel = nil
//    }
//
//    override public func getValue() -> [Selectable]? {
//        return nil
//    }
//    
//    override func validateContent() -> ValidationResult {
//        if let _ = getChildren()?.first(where: {
//            $0.getStatus() == true
//        }) {
//            return ValidationResult(isValid: true)
//        }
//        
//        return ValidationResult(isValid: false, error: FormFieldError.emptyField)
//    }
//
//    public func set(data: [Selectable]) {
//        self.stackView?.removeAllArrangedSubviews()
//
//        data.forEach {
//            self.addSelectableToStackView($0)
//        }
//    }
//
//    func addSelectableToStackView(_ item: Selectable) {
//        guard let radioButtonFrame = self.individualItemFrame else {
//            return
//        }
//
//        let subview = MultipleSelectionItem(
//            frame: radioButtonFrame,
//            hasBorder: childrenHaveBorder,
//            associatedSelectable: item)
//        subview.set(notifiable: self)
//
//        self.stackView?.addArrangedSubview(subview)
//    }
//
//    override public func show(error: FormFieldErrorType) {
//        guard self.errorLabel == nil else {
//            return
//        }
//
//        self.errorLabel = UILabel()
//
//        guard let errorLabel = self.errorLabel else {
//            return
//        }
//
//        errorLabel.text = error.description
//        errorLabel.textColor = UIColor.red
//        self.stackView?.addArrangedSubview(errorLabel)
//    }
//}
