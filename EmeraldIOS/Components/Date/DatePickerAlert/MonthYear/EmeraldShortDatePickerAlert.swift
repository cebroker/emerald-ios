//
//  EmeraldShortDatePickerAlert.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/21/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//
import UIKit

struct SelectedValue {
    var value: String
    var id: Int
}

public class EmeraldShortDatePickerAlert: UIView, EmeraldDatePickerAlertType {

    public typealias DatePickerCallback = (Date?) -> Void

    // MARK: - Constants
    struct InnerConstants {
        static let numberOfColumns = 2
        static let defaultButtonHeight: CGFloat = 50
        static let defaultButtonSpacerHeight: CGFloat = 1
        static let cornerRadius: CGFloat = 7
        static let doneButtonTag: Int = 1
    }

    enum Component: Int {
        case month
        case year
    }

    // MARK: - Views
    open var datePicker: UIPickerView!
    private var dialogView: UIView!
    private var titleLabel: UILabel!
    private var cancelButton: UIButton!
    private var doneButton: UIButton!

    // MARK: - Variables
    private var callback: DatePickerCallback?
    lazy var showCancelButton: Bool = false
    private var minimumDate: Date?
    private var maximumDate: Date?
    private var selectedDate: SelectedValue?

    var date: Date = Date() {
        didSet {
            let newDate = calendar.startOfDay(for: date)
            setDate(newDate, animated: true)
        }
    }

    var monthDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate(Constants.DateFormat.monthLocalizedDateFormat)
        return formatter
    }()

    var yearDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate(Constants.DateFormat.yeardLocalizedDateFormat)
        return formatter
    }()

    let calendar: Calendar = Calendar.autoupdatingCurrent

    public init(showCancelButton: Bool = true) {
        let size = UIScreen.main.bounds.size
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.showCancelButton = showCancelButton
        setupView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func set(minimumDate: Date) {
        self.minimumDate = minimumDate
    }

    public func set(maximumDate: Date) {
        self.maximumDate = maximumDate
    }

    public func set(currentDateValue: Date) {
        self.setDate(currentDateValue, animated: true)
    }

    private func setDate(_ date: Date, animated: Bool) {
        guard let yearRange = calendar.maximumRange(of: .year), let monthRange = calendar.maximumRange(of: .month) else {
            return
        }
        let month = calendar.component(.month, from: date) - monthRange.lowerBound
        datePicker.selectRow(month,
            inComponent: Component.month.rawValue,
            animated: animated)

        let year = calendar.component(.year, from: date) - yearRange.lowerBound
        datePicker.selectRow(year,
            inComponent: Component.year.rawValue,
            animated: animated)

        let currenDate = "\(month + 1)/\(year + 1)".toDate().toStringFormatted(with: Constants.DateFormat.shortFormat)
     
        self.selectedDate = SelectedValue(
            value: currenDate,
            id: Constants.Values.zero)
    }

    private func getDate(_ date: SelectedValue?) -> Date? {
        return date?.value.toDate()
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
            height: 230 + InnerConstants.defaultButtonHeight + InnerConstants.defaultButtonSpacerHeight)

        self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)

        let container = UIView(frame: CGRect(x: (screenSize.width - dialogSize.width) / 2,
            y: (screenSize.height - dialogSize.height) / 2,
            width: dialogSize.width,
            height: dialogSize.height))
        container.backgroundColor = EmeraldTheme.whiteColor

        let gradient: CAGradientLayer = CAGradientLayer(layer: self.layer)
        gradient.frame = container.bounds
        gradient.colors = [EmeraldTheme.whiteColor.cgColor]

        let cornerRadius = InnerConstants.cornerRadius
        gradient.cornerRadius = cornerRadius
        container.layer.insertSublayer(gradient, at: 0)

        container.layer.cornerRadius = cornerRadius
        container.layer.borderColor = UIColor(red: 198 / 255, green: 198 / 255, blue: 198 / 255, alpha: 1).cgColor
        container.layer.borderWidth = 1
        container.layer.shadowRadius = cornerRadius + 5
        container.layer.shadowOpacity = 0.1
        container.layer.shadowOffset = CGSize(width: 0 - (cornerRadius + 5) / 2, height: 0 - (cornerRadius + 5) / 2)
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowPath = UIBezierPath(roundedRect: container.bounds,
            cornerRadius: container.layer.cornerRadius).cgPath

        let yPosition = container.bounds.size.height - InnerConstants.defaultButtonHeight - InnerConstants.defaultButtonSpacerHeight
        let lineView = UIView(frame: CGRect(x: 0,
            y: yPosition,
            width: container.bounds.size.width,
            height: InnerConstants.defaultButtonSpacerHeight))
        lineView.backgroundColor = UIColor(red: 198 / 255, green: 198 / 255, blue: 198 / 255, alpha: 1)
        container.addSubview(lineView)

        self.titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 280, height: 30))
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = EmeraldTheme.primaryColor
        self.titleLabel.font = Typography(size: FontSize.body, weight: FontWeight.regular).uiFont
        container.addSubview(self.titleLabel)

        self.datePicker = configuredDatePicker()
        self.datePicker.delegate = self
        self.datePicker.dataSource = self
        setDate(date, animated: false)
        container.addSubview(self.datePicker)

        addButtonsToView(container: container)
        return container
    }

    fileprivate func configuredDatePicker() -> UIPickerView {
        let datePicker = UIPickerView(frame: CGRect(x: 0, y: 30, width: 0, height: 0))
        datePicker.autoresizingMask = .flexibleRightMargin
        datePicker.frame.size.width = 300
        datePicker.frame.size.height = 216
        return datePicker
    }

    private func addButtonsToView(container: UIView) {
        var buttonWidth = container.bounds.size.width / 2

        var leftButtonFrame = CGRect(
            x: 0,
            y: container.bounds.size.height - InnerConstants.defaultButtonHeight,
            width: buttonWidth,
            height: InnerConstants.defaultButtonHeight
        )
        var rightButtonFrame = CGRect(
            x: buttonWidth,
            y: container.bounds.size.height - InnerConstants.defaultButtonHeight,
            width: buttonWidth,
            height: InnerConstants.defaultButtonHeight
        )
        if showCancelButton == false {
            buttonWidth = container.bounds.size.width
            leftButtonFrame = CGRect()
            rightButtonFrame = CGRect(
                x: 0,
                y: container.bounds.size.height - InnerConstants.defaultButtonHeight,
                width: buttonWidth,
                height: InnerConstants.defaultButtonHeight
            )
        }
        let interfaceLayoutDirection = UIApplication.shared.userInterfaceLayoutDirection
        let isLeftToRightDirection = interfaceLayoutDirection == .leftToRight

        if showCancelButton {
            self.cancelButton = UIButton(type: .custom) as UIButton
            self.cancelButton.frame = isLeftToRightDirection ? leftButtonFrame : rightButtonFrame
            self.cancelButton.setTitleColor(EmeraldTheme.primaryColor, for: .normal)
            self.cancelButton.setTitleColor(EmeraldTheme.primaryColor, for: .highlighted)
            self.cancelButton.titleLabel!.font = Typography(size: FontSize.body, weight: FontWeight.regular).uiFont
            self.cancelButton.layer.cornerRadius = InnerConstants.cornerRadius
            self.cancelButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            container.addSubview(self.cancelButton)
        }
        self.doneButton = UIButton(type: .custom) as UIButton
        self.doneButton.frame = isLeftToRightDirection ? rightButtonFrame : leftButtonFrame
        self.doneButton.tag = InnerConstants.doneButtonTag
        self.doneButton.setTitleColor(EmeraldTheme.primaryColor, for: .normal)
        self.doneButton.setTitleColor(EmeraldTheme.primaryColor, for: .highlighted)
        self.doneButton.titleLabel!.font = Typography(size: FontSize.body, weight: FontWeight.regular).uiFont
        self.doneButton.layer.cornerRadius = InnerConstants.cornerRadius
        self.doneButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        container.addSubview(self.doneButton)
    }

    @objc func buttonTapped(sender: UIButton!) {
        if sender.tag == InnerConstants.doneButtonTag {
            self.callback?(getDate(self.selectedDate))
        } else {
            self.callback?(nil)
        }
        close()
    }

    open func show(title: String,
        doneButtonTitle: String,
        cancelButtonTitle: String,
        datePickerMode: UIDatePicker.Mode,
        callback: @escaping DatePickerCallback) {
        self.titleLabel.text = title
        self.doneButton.setTitle(doneButtonTitle, for: .normal)
        if showCancelButton {
            self.cancelButton.setTitle(cancelButtonTitle, for: .normal)
        }
        self.callback = callback

        if self.selectedDate == nil {
            print("IS EMPTY")
            //self.datePicker
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
                self.backgroundColor = EmeraldTheme.whiteColor.withAlphaComponent(0.4)
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

    private func checkDateSelected(dateSelected: String) {
        if let minimunDate = minimumDate {
            if calendar.compare(minimunDate, to: dateSelected.toDate(), toGranularity: .month) == .orderedDescending {
                setDate(Date(), animated: true)
                setupDefaultDate()
            }
        }

        if let maximiumDate = maximumDate {
            if calendar.compare(maximiumDate, to: dateSelected.toDate(), toGranularity: .month) == .orderedAscending {
                setDate(Date(), animated: true)
                setupDefaultDate()
            }
        }
    }

    private func setupDefaultDate() {
        let currenDate = Date().toStringFormatted(with: Constants.DateFormat.shortFormat)
        selectedDate = SelectedValue(value: currenDate, id: Constants.Values.zero)
    }
}

extension EmeraldShortDatePickerAlert: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let yearRange = calendar.maximumRange(of: .year),
            let monthRange = calendar.maximumRange(of: .month) else {
                return
        }

        let yeardSelected = String(yearRange.lowerBound + pickerView.selectedRow(inComponent: Component.year.rawValue))

        let monthselected = String(monthRange.lowerBound + pickerView.selectedRow(inComponent: Component.month.rawValue))

        let dateSelected = "\(monthselected)/\(yeardSelected)"
            .toDate()
            .toStringFormatted(with: Constants.DateFormat.shortFormat)

        selectedDate = SelectedValue(value: dateSelected, id: row)
        checkDateSelected(dateSelected: dateSelected)
    }
}

extension EmeraldShortDatePickerAlert: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return InnerConstants.numberOfColumns
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let component = Component(rawValue: component) else { return 0 }
        switch component {
        case .month:
            guard let range = calendar.maximumRange(of: .month) else {
                return Constants.Values.zero
            }
            return range.count
        case .year:
            guard let range = calendar.maximumRange(of: .year) else {
                return Constants.Values.zero
            }
            return range.count
        }
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let component = Component(rawValue: component) else { return nil }

        switch component {
        case .month:
            guard let range = calendar.maximumRange(of: .month) else {
                return nil
            }
            let month = range.lowerBound + row
            var dateComponents = DateComponents()
            dateComponents.month = month
            guard let date = calendar.date(from: dateComponents) else {
                return nil
            }
            return monthDateFormatter.string(from: date)
        case .year:
            guard let range = calendar.maximumRange(of: .year) else {
                return nil
            }
            let year = range.lowerBound + row
            var dateComponents = DateComponents()
            dateComponents.year = year
            guard let date = calendar.date(from: dateComponents) else {
                return nil
            }
            return yearDateFormatter.string(from: date)
        }
    }
}
