//
//  ViewController.swift
//  ProofOfConcept
//
//  Created by Luis David Goyes Garces on 3/20/19.
//  Copyright © 2019 Luis David Goyes Garces. All rights reserved.
//

import EmeraldIOS

class Department: Selectable {
    let name: String
    let cities: [String]

    init(name: String, cities: [String]) {
        self.name = name
        self.cities = cities
    }

    func getSelectableText() -> String {
        return name
    }
}

class ViewController: UIViewController, EmeraldValidableType {
    @IBOutlet private weak var formStackView: EmeraldStackView!

    @IBOutlet weak var chipCollectionView: EmeraldChipsCollectionView!
    @IBOutlet weak var chipsDefault: EmeraldChipView!
    @IBOutlet weak var chipWarning: EmeraldChipView!
    @IBOutlet weak var chipSuccess: EmeraldChipView!
    @IBOutlet weak var chipDismissable: EmeraldChipView!
    @IBOutlet weak var emeraldAvatarXs: EmeraldAvatar!
    @IBOutlet weak var emeraldAvatarMd: EmeraldAvatar!
    @IBOutlet weak var emeraldAvatarLg: EmeraldAvatar!
    @IBOutlet weak var signatureBoxView: EmeraldSignatureBoxView!
    @IBOutlet weak var emeraldLabelByStory: EmeraldLabel!
    @IBOutlet weak var emeraldTextByStory: EmeraldTextField!
    @IBOutlet weak var emeraldButtonByStory: EmeraldButton!
    @IBOutlet weak var emeraldSelectorByStory: EmeraldSelectorField!

    @IBOutlet weak var regexView: EmeraldSelectorFieldView!
    @IBOutlet weak var emptyableSelector: EmeraldSelectorField!
    @IBOutlet weak var emeraldTextDependantFieldByStory: EmeraldTextDependantField!
    @IBOutlet weak var emeraldEndDateFieldByStory: EmeraldDateField!
    @IBOutlet weak var emeraldStartDateFieldByStory: EmeraldDateField!
    @IBOutlet weak var emeraldRegexFieldByStory: EmeraldRegexTextField!
    @IBOutlet weak var emeraldMultipleSelectorByStory: EmeraldCheckboxFormField!
    @IBOutlet weak var emeraldTextView: EmeraldTextViewField!

    @IBOutlet weak var textViewStack: EmeraldTextView!
    @IBOutlet weak var loadingIndicator: EmeraldLoadingIndicator!
    @IBOutlet weak var disabletextField: EmeraldTextField!
    @IBOutlet weak var disableEmeralCheckboxField: EmeraldCheckboxFormField!

    @IBOutlet weak var currencyTextField: EmeraldRegexTextField!
    private var emeraldFields: [EmeraldValidableType] {
        return [signatureBoxView,
                emeraldLabelByStory,
                emeraldTextByStory,
                emeraldButtonByStory,
                emeraldSelectorByStory,
                emeraldTextDependantFieldByStory,
                emeraldEndDateFieldByStory,
                emeraldStartDateFieldByStory,
                emeraldRegexFieldByStory,
                emeraldMultipleSelectorByStory,
                emeraldTextView,
                currencyTextField,
                emptyableSelector]
    }

    private var organizationName: EmeraldTextFieldType?
    private var address: EmeraldTextFieldType?
    private var city: EmeraldTextDependantField?
    private var state: EmeraldSelectorFieldType?
    private var zip: EmeraldTextFieldType?
    private var contactName: EmeraldTextFieldType?
    private var membershipDuesAmount: EmeraldTextFieldType?
    private var amountPaid: EmeraldTextFieldType?

    private var formButton: EmeraldButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = EmeraldTheme.backgroundColor
        createHideKeyboardGesture()
//        self.createFields()
        createStoryBoardFields()
        loadingIndicator.startAnimating()
    }

    private func createHideKeyboardGesture() {
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
        viewTapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(viewTapGesture)
    }

    @objc func handleViewTap(recognizer: UIGestureRecognizer) {
        resignFirstResponder()
    }

    private func createStoryBoardFields() {
        chipsDefault.setText("Hola ")
        chipWarning.setText("Hola ")
        chipSuccess.setText("Hola ")
        chipDismissable.setText("Hola ")
        emeraldTextByStory.setCustomDelegate(with: self)
        emeraldTextByStory.setText(with: "")
        emeraldTextByStory.setPasswordRightView()
        signatureBoxView.isUserInteractionEnabled = true
        signatureBoxView.delegate = self
        emeraldButtonByStory.addTarget(self, action: #selector(submitFormOnTouchUpInside(_:)), for: .touchUpInside)
        emeraldSelectorByStory.set(data: [
            Department(name: "Antioquia", cities: ["Medellin", "Envigado"]),
            Department(name: "Cundinamarca", cities: ["Chia", "Bogota"]),
        ])
        emeraldSelectorByStory.set(selectedRow: Department(name: "Cundinamarca", cities: ["Chia", "Bogota"]))
        emeraldSelectorByStory.set(emptyOptionText: "Select a state")
        emptyableSelector.set(data: [
            Department(name: "Antioquia", cities: ["Medellin", "Envigado"]),
            Department(name: "Cundinamarca", cities: ["Chia", "Bogota"]),
        ])

        emeraldMultipleSelectorByStory.enable(innerBorder: true)
        emeraldMultipleSelectorByStory.prepareForInterfaceBuilder()
        emeraldMultipleSelectorByStory.set(data: [
            MultipleSelectionGroupItem(title: "Uno"),
            MultipleSelectionGroupItem(title: "Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos "),
            MultipleSelectionGroupItem(id: "TresId", title: "tres"),
            MultipleSelectionGroupItem(title: "Cuatro"),
            MultipleSelectionGroupItem(title: "Cinco"),
        ])
        emeraldMultipleSelectorByStory.set(notifiable: self)
        emeraldMultipleSelectorByStory.getChildren()?.forEach { item in
            item.isEnable(false)
        }

        disableEmeralCheckboxField.enable(innerBorder: true)
        disableEmeralCheckboxField.prepareForInterfaceBuilder()
        disableEmeralCheckboxField.set(data: [
            MultipleSelectionGroupItem(title: "Uno disable"),
            MultipleSelectionGroupItem(title: "dos disable"),
        ])

        disableEmeralCheckboxField.getChildren()?.forEach { item in
            item.isEnable(false)
        }

        emeraldRegexFieldByStory.set(regex: .custom("^([A-Z0-9]{1}-[A-Z0-9]{5}-[A-Z0-9]{5}-[A-Z0-9]{5}-[A-Z0-9]{5})$"))
        emeraldSelectorByStory.set(notifiable: self)
        emeraldStartDateFieldByStory.setDependantField(with: emeraldEndDateFieldByStory)
        emeraldStartDateFieldByStory.set(notifiable: emeraldStartDateFieldByStory)
        emeraldStartDateFieldByStory.errorMessages.minimumDate = "This is a custom error"
        emeraldStartDateFieldByStory.set(format: .shortDate)
        emeraldStartDateFieldByStory.set(minimumDate: Date())

        emeraldTextView.set(placeholder: "Description")
        textViewStack.setPlaceholder(with: "Description")
        textViewStack.setTitle(with: "My textview title with an a large extension to probe if the multiples line split work.")
        textViewStack.setIsRequired(with: true)
        emeraldAvatarLg.setTitle(with: "Sergio", lastName: "Giraldo")
        emeraldAvatarMd.setTitle(with: "Gensesis", lastName: "Sanguino")
        emeraldAvatarXs.setTitle(with: "Jorge", lastName: "Menco")
        emeraldAvatarLg.setBackgroundColor(emeraldAvatarXs.getBackgroundColor())
        emeraldAvatarLg.setTextColor(emeraldAvatarXs.getTextColor())
        regexView.set(placeholder: "example emerald selector field view")
        regexView.setDelegate(self)
        regexView.set(isRequired: true)

        currencyTextField.set(placeholder: "Currency")
        currencyTextField.set(isRequired: true)
        currencyTextField.set(regex: .currency)
    }

    private func createFields() {
        let mainTitle = formStackView.createLabel()
        mainTitle?.themeStyle = EmeraldLabelStyle.mainTitle.rawValue
        mainTitle?.text = "Main title"

        let subtitle = formStackView.createLabel()
        subtitle?.themeStyle = EmeraldLabelStyle.subtitle.rawValue
        subtitle?.text = "Subtitle text"

        let body = formStackView.createLabel()
        body?.themeStyle = EmeraldLabelStyle.body.rawValue
        body?.text = "Body text"

        let tableHeader = formStackView.createLabel()
        tableHeader?.themeStyle = EmeraldLabelStyle.tableHeader.rawValue
        tableHeader?.text = "Table header text"

        let customTitle = formStackView.createLabel()
        customTitle?.themeColor = ColorPallete.primary.rawValue
        customTitle?.themeFontSize = FontSize.h1.rawValue
        customTitle?.themeFontWeight = FontWeight.bold.rawValue
        customTitle?.text = "H1 Custom title"

        organizationName = formStackView.createEmeraldTextField(placeholder: "Organization name")
        organizationName?.set(isRequired: true)
        organizationName?.set(hint: "Condor Labs")

        address = formStackView.createEmeraldTextField(placeholder: "Address")
        address?.set(hint: "Calle NN # NN - NN")

        city = formStackView.createEmeraldTextDependantField(placeholder: "City")
        city?.set(isRequired: true)
        city?.set(hint: "Medellín")

        state = formStackView.createEmeraldSelectorFormField(placeholder: "State")
        state?.set(data: [
            Department(name: "Antioquia", cities: ["Medellin", "Envigado"]),
            Department(name: "Cundinamarca", cities: ["Chia", "Bogota"]),
        ])
        state?.set(notifiable: self)
        state?.set(hint: "Antioquia")
        state?.set(isRequired: true)

        amountPaid = formStackView.createEmeraldTextField(placeholder: "Amount paid")
        amountPaid?.set(format: .currency)
        amountPaid?.set(isRequired: true)
        amountPaid?.set(hint: "$ 1234")

        formButton = formStackView.createButton(with: "Submit form")
        formButton?.themeStyle = EmeraldButtonStyle.primary.rawValue
        formButton?.addTarget(self, action: #selector(submitFormOnTouchUpInside(_:)), for: .touchUpInside)

        formStackView.reloadFields()
    }

    @IBAction func submitFromStory(_: Any) {
        if areFieldsValid() {}
    }

    @IBAction func addLanguage(_: Any) {
        let text = ["1", "abc", "Sergio Giraldo", "Medellin"]
        let vm2 = ChipViewModel(text: text.randomElement()!, type: .dismissable)
        chipCollectionView.addNewChip(with: vm2)
    }

    @IBAction func showBarChart(_: Any) {
        let barChartVC = BarChartViewController()
        navigationController?.pushViewController(barChartVC, animated: true)
    }

    @IBAction func popupAction(_: Any) {
        let barChartVC = BarChartViewController()
        let popup = EmeraldPopupViewController(contentController: barChartVC, popupWidth: 320, popupHeight: 400)
        popup.shadowEnabled = false
        present(popup, animated: true, completion: nil)
    }

    private func areFieldsValid() -> Bool {
        return validateEmeraldFields(with: emeraldFields)
    }

    @objc private func submitFormOnTouchUpInside(_: UIButton) {
        emeraldTextByStory.clearText()
        showToast(message: "Not good. Not good at all. Let's get this fixed.", status: .failure, duration: .short)
        formStackView.areFieldsValid()
        let selectedChildren = emeraldMultipleSelectorByStory.getData().map {
            MultipleSelectionGroupItem(title: $0.getTitle())
        }

        print(selectedChildren)
    }
}

extension ViewController: EmeraldSelectorFieldChangeNotifiable {
    func onSelected(row: Selectable?, from selector: EmeraldSelectorField) {
        guard let stateField = emeraldSelectorByStory else {
            return
        }

        switch selector {
        case stateField:
            guard let department = row as? Department else {
                return
            }
            emptyableSelector.clearData()
            emptyableSelector.set(data: [
                Department(name: "Antioquia2", cities: ["Medellin", "Envigado"]),
                Department(name: "Cundinamarca2", cities: ["Chia", "Bogota"]),
            ])
            emeraldTextDependantFieldByStory.set(availableOptions: department.cities)
            city?.set(availableOptions: department.cities)
        default:
            break
        }
    }
}

extension ViewController: SingleItemChangeNotifiable {
    func onItemClicked(associatedSelectable: Selectable, from item: EmeraldMultipleSelectionItemType) {
        guard let id = associatedSelectable.getSelectableId?() else {
            return
        }

        switch id {
        case "MI_ID_1":
            // do something with
            break
        case "TresId":
            let textTextField = "test comon"
            disabletextField.setText(with: textTextField)
            disabletextField.isEnable(false)
        default:
            break
        }
    }
}

extension ViewController: CustomEmeraldTextFieldDelegate {
    func valueDidChange(textField: UITextField, text: String?) {}

    func didBeginEditing(textField: UITextField) {}

    func didEndEditing(textField: UITextField) {
        _ = regexView.validateAndHandle()
    }
}
