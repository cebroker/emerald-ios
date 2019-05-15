//
//  EmeraldDatePickerAlert.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/15/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

public protocol EmeraldDatePickerAlertType {
    func set(minimumDate: Date)
    func set(maximumDate: Date)
    func set(currentDateValue: Date)
}

public class EmeraldDatePickerAlert: UIView, EmeraldDatePickerAlertType {
    
    public typealias DatePickerCallback = (Date?) -> Void
    
    // MARK: - Constants
    struct InnerConstants {
        static let kDefaultButtonHeight: CGFloat = 50
        static let kDefaultButtonSpacerHeight: CGFloat = 1
        static let kCornerRadius: CGFloat = 7
        static let kDoneButtonTag: Int = 1
    }
    
    // MARK: - Views
    open var datePicker: UIDatePicker!
    private var dialogView: UIView!
    private var titleLabel: UILabel!
    private var cancelButton: UIButton!
    private var doneButton: UIButton!
    
    // MARK: - Variables
    private var datePickerMode: UIDatePicker.Mode?
    private var callback: DatePickerCallback?
    lazy var showCancelButton: Bool = false
    var locale: Locale?

    public init(locale: Locale? = Locale(identifier: "en_US_POSIX"),
                showCancelButton: Bool = true) {
        let size = UIScreen.main.bounds.size
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.showCancelButton = showCancelButton
        self.locale = locale
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func set(minimumDate: Date) {
        self.datePicker.minimumDate = minimumDate
    }
    
    public func set(maximumDate: Date) {
        self.datePicker.maximumDate = maximumDate
    }
    
    public func set(currentDateValue: Date) {
        self.datePicker.date = currentDateValue
    }
    
    private func setupView() {
        self.dialogView = createContainerView()
        guard let dialogView = self.dialogView else {
            return
        }
        
        dialogView.layer.shouldRasterize = true
        dialogView.layer.rasterizationScale = UIScreen.main.scale
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        dialogView.layer.opacity = 0.5
        dialogView.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        self.addSubview(dialogView)
    }
    
    private func createContainerView() -> UIView {
        let screenSize = UIScreen.main.bounds.size
        let dialogSize = CGSize(
            width: 300,
            height: 230 + InnerConstants.kDefaultButtonHeight + InnerConstants.kDefaultButtonSpacerHeight)
        
        self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        
        let container = UIView(frame: CGRect(x: (screenSize.width - dialogSize.width) / 2,
                                             y: (screenSize.height - dialogSize.height) / 2,
                                             width: dialogSize.width,
                                             height: dialogSize.height))
        
        let gradient: CAGradientLayer = CAGradientLayer(layer: self.layer)
        gradient.frame = container.bounds
        gradient.colors = [UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1).cgColor,
                           UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1).cgColor,
                           UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1).cgColor]
        
        let cornerRadius = InnerConstants.kCornerRadius
        gradient.cornerRadius = cornerRadius
        container.layer.insertSublayer(gradient, at: 0)
        
        container.layer.cornerRadius = cornerRadius
        container.layer.borderColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        container.layer.borderWidth = 1
        container.layer.shadowRadius = cornerRadius + 5
        container.layer.shadowOpacity = 0.1
        container.layer.shadowOffset = CGSize(width: 0 - (cornerRadius + 5) / 2, height: 0 - (cornerRadius + 5) / 2)
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowPath = UIBezierPath(roundedRect: container.bounds,
                                                  cornerRadius: container.layer.cornerRadius).cgPath
        
        // There is a line above the button
        let yPosition = container.bounds.size.height - InnerConstants.kDefaultButtonHeight - InnerConstants.kDefaultButtonSpacerHeight
        let lineView = UIView(frame: CGRect(x: 0,
                                            y: yPosition,
                                            width: container.bounds.size.width,
                                            height: InnerConstants.kDefaultButtonSpacerHeight))
        lineView.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        container.addSubview(lineView)
        
        self.titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 280, height: 30))
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = EmeraldTheme.primaryColor
        self.titleLabel.font = Font(size: FontSize.body, weight: FontWeight.regular).uiFont
        container.addSubview(self.titleLabel)
        
        self.datePicker = configuredDatePicker()
        container.addSubview(self.datePicker)
        
        addButtonsToView(container: container)
        return container
    }
    
    fileprivate func configuredDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 30, width: 0, height: 0))
        datePicker.autoresizingMask = .flexibleRightMargin
        datePicker.frame.size.width = 300
        datePicker.frame.size.height = 216
        return datePicker
    }
    
    private func addButtonsToView(container: UIView) {
        var buttonWidth = container.bounds.size.width / 2
        
        var leftButtonFrame = CGRect(
            x: 0,
            y: container.bounds.size.height - InnerConstants.kDefaultButtonHeight,
            width: buttonWidth,
            height: InnerConstants.kDefaultButtonHeight
        )
        var rightButtonFrame = CGRect(
            x: buttonWidth,
            y: container.bounds.size.height - InnerConstants.kDefaultButtonHeight,
            width: buttonWidth,
            height: InnerConstants.kDefaultButtonHeight
        )
        if showCancelButton == false {
            buttonWidth = container.bounds.size.width
            leftButtonFrame = CGRect()
            rightButtonFrame = CGRect(
                x: 0,
                y: container.bounds.size.height - InnerConstants.kDefaultButtonHeight,
                width: buttonWidth,
                height: InnerConstants.kDefaultButtonHeight
            )
        }
        let interfaceLayoutDirection = UIApplication.shared.userInterfaceLayoutDirection
        let isLeftToRightDirection = interfaceLayoutDirection == .leftToRight
        
        if showCancelButton {
            self.cancelButton = UIButton(type: .custom) as UIButton
            self.cancelButton.frame = isLeftToRightDirection ? leftButtonFrame : rightButtonFrame
            self.cancelButton.setTitleColor(EmeraldTheme.primaryColor, for: .normal)
            self.cancelButton.setTitleColor(EmeraldTheme.primaryColor, for: .highlighted)
            self.cancelButton.titleLabel!.font = Font(size: FontSize.body, weight: FontWeight.regular).uiFont
            self.cancelButton.layer.cornerRadius = InnerConstants.kCornerRadius
            self.cancelButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            container.addSubview(self.cancelButton)
        }
        self.doneButton = UIButton(type: .custom) as UIButton
        self.doneButton.frame = isLeftToRightDirection ? rightButtonFrame : leftButtonFrame
        self.doneButton.tag = InnerConstants.kDoneButtonTag
        self.doneButton.setTitleColor(EmeraldTheme.primaryColor, for: .normal)
        self.doneButton.setTitleColor(EmeraldTheme.primaryColor, for: .highlighted)
        self.doneButton.titleLabel!.font = Font(size: FontSize.body, weight: FontWeight.regular).uiFont
        self.doneButton.layer.cornerRadius = InnerConstants.kCornerRadius
        self.doneButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        container.addSubview(self.doneButton)
    }
    
    @objc func buttonTapped(sender: UIButton!) {
        if sender.tag == InnerConstants.kDoneButtonTag {
            self.callback?(self.datePicker.date)
        } else {
            self.callback?(nil)
        }
        close()
    }
    
    open func show(_ title: String,
                   doneButtonTitle: String = "Done",
                   cancelButtonTitle: String = "Cancel",
                   datePickerMode: UIDatePicker.Mode = .date,
                   callback: @escaping DatePickerCallback) {
        self.titleLabel.text = title
        self.doneButton.setTitle(doneButtonTitle, for: .normal)
        if showCancelButton {
            self.cancelButton.setTitle(cancelButtonTitle, for: .normal)
        }
        self.datePickerMode = datePickerMode
        self.callback = callback
        self.datePicker.datePickerMode = self.datePickerMode ?? UIDatePicker.Mode.date
        if let locale = self.locale {
            self.datePicker.locale = locale
        }
        
        guard let appDelegate = UIApplication.shared.delegate else { fatalError() }
        guard let window = appDelegate.window else { fatalError() }
        window?.addSubview(self)
        window?.bringSubviewToFront(self)
        window?.endEditing(true)
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                self.dialogView!.layer.opacity = 1
                self.dialogView!.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    private func close() {
        let currentTransform = self.dialogView.layer.transform
        
        let startRotation = (self.value(forKeyPath: "layer.transform.rotation.z") as? NSNumber) as? Double ?? 0.0
        let rotation = CATransform3DMakeRotation((CGFloat)(-startRotation + .pi * 270 / 180), 0, 0, 0)
        
        self.dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1))
        self.dialogView.layer.opacity = 1
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [],
            animations: {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                let transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
                self.dialogView.layer.transform = transform
                self.dialogView.layer.opacity = 0
        }) { (_) in
            for v in self.subviews {
                v.removeFromSuperview()
            }
            
            self.removeFromSuperview()
            self.setupView()
        }
    }
}

