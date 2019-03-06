//
//  MultipleSelectionFormField.swift
//  CondorUIComponents
//
//  Created by Luis David Goyes Garces on 2/28/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public protocol MultipleSelectionFormFieldProtocol {
    func set(data: [Selectable])
    func set(spacing: CGFloat)
    func enable(innerBorder: Bool)
    func set(notifiable: MultipleSelectionChangeNotifiable)
}

public class MultipleSelectionFormField: FormFieldType<[Selectable]>, MultipleSelectionFormFieldProtocol, MultipleSelectionItemListener {

    var stackView: UIStackView?

    private struct InnerConstants {
        struct StackView {
            struct Dimens {
                static let spacing = 15
            }
            struct Padding {
                static let top = 10
                static let left = 20
                static let bottom = 10
                static let right = 20
            }
        }
    }

    private var individualItemFrame: CGRect?

    private var notifiable: MultipleSelectionChangeNotifiable?

    private var errorLabel: UILabel?

    private var data: [Selectable]?

    private var innerBorder: Bool = false

    public func set(data: [Selectable]) {
        self.data = data
    }

    public func set(spacing: CGFloat) {
        self.stackView?.spacing = spacing
    }

    public func enable(innerBorder: Bool) {
        self.innerBorder = innerBorder
    }

    public func set(notifiable: MultipleSelectionChangeNotifiable) {
        self.notifiable = notifiable
    }

    override func postInit() {
        stackView = UIStackView(arrangedSubviews: [])

        stackView?.axis = .vertical
        stackView?.distribution = .equalSpacing
        stackView?.alignment = .fill
        stackView?.spacing = CGFloat(InnerConstants.StackView.Dimens.spacing)

        if let stackView = self.stackView {
            self.addSubview(stackView)
        }

        stackView?.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            bottom: self.bottomAnchor,
            right: self.rightAnchor,
            paddingTop: CGFloat(InnerConstants.StackView.Padding.top),
            paddingLeft: CGFloat(InnerConstants.StackView.Padding.left),
            paddingBottom: CGFloat(InnerConstants.StackView.Padding.bottom),
            paddingRight: CGFloat(InnerConstants.StackView.Padding.right),
            width: 0,
            height: 0)

        individualItemFrame = CGRect(
            x: CGFloat(Constants.Dimens.origin),
            y: CGFloat(Constants.Dimens.origin),
            width: self.frame.width,
            height: CGFloat(Constants.Dimens.SingleRadioButton.height))
    }

    public func onItemClicked(title: String?, from item: MultipleSelectionItem) {
        self.clearError()
        self.notifiable?.onItemClicked(title: title, from: item)
    }

    public override func clearError() {
        guard let errorLabel = self.errorLabel else {
            return
        }

        self.stackView?.removeArrangedSubview(errorLabel)
        errorLabel.removeFromSuperview()
        self.stackView?.reloadInputViews()

        self.errorLabel = nil
    }



//
//
//
//
//    func setInnerPadding(top: CGFloat, left: CGFloat, bottom: CGFloat, rigth: CGFloat) {
//        self.stackView?.arrangedSubviews.forEach({
//            guard let multipleSelectionItem = $0 as? MultipleSelectionItemProtocol else {
//                return
//            }
//
//            multipleSelectionItem.setPadding(top: top, left: left, bottom: bottom, rigth: rigth)
//        })
//    }
//
//    public func set(data: [Selectable]) {
//        self.data = data
//        self.stackView?.removeAllArrangedSubviews()
//
//        data.forEach {
//            addSelectableToStackView($0)
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
//            title: item.getSelectableText(),
//            hasBorder: innerBorder)
//        subview.set(listener: self)
//
//        self.stackView?.addArrangedSubview(subview)
//    }
//
//    public override func getValue() -> [Selectable]? {
//        return nil
//    }
//
//    override func validateContent() -> ValidationResult {
//        return ValidationResult(isValid: true)
//    }
//
//    public override func show(error: FormFieldErrorType) {
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
//
}
