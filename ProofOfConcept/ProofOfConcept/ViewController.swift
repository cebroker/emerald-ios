//
//  ViewController.swift
//  ProofOfConcept
//
//  Created by Luis David Goyes Garces on 3/20/19.
//  Copyright © 2019 Luis David Goyes Garces. All rights reserved.
//

import UIKit
import EmeraldIOS

class State: Selectable {
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

    @IBOutlet weak var emeraldAvatarXs: EmeraldAvatar!
    @IBOutlet weak var emeraldAvatarMd: EmeraldAvatar!
    @IBOutlet weak var emeraldAvatarLg: EmeraldAvatar!
    @IBOutlet weak var signatureBoxView: EmeraldSignatureBoxView!
    @IBOutlet weak var emeraldLabelByStory: EmeraldLabel!
    @IBOutlet weak var emeraldTextByStory: EmeraldTextField!
    @IBOutlet weak var emeraldButtonByStory: EmeraldButton!
    @IBOutlet weak var emeraldSelectorByStory: EmeraldSelectorField!
    
    @IBOutlet weak var emptyableSelector: EmeraldSelectorField!
    @IBOutlet weak var emeraldTextDependantFieldByStory: EmeraldTextDependantField!
    @IBOutlet weak var emeraldEndDateFieldByStory: EmeraldDateField!
    @IBOutlet weak var emeraldStartDateFieldByStory: EmeraldDateField!
    @IBOutlet weak var emeraldRegexFieldByStory: EmeraldRegexTextField!
    @IBOutlet weak var emeraldMultipleSelectorByStory: EmeraldCheckboxFormField!
    @IBOutlet weak var emeraldTextView: EmeraldTextViewField!

    @IBOutlet weak var textViewStack: EmeraldTextView!

    private var emeraldFields: [EmeraldValidableType] {
        return [signatureBoxView, emeraldLabelByStory, emeraldTextByStory, emeraldButtonByStory, emeraldSelectorByStory, emeraldTextDependantFieldByStory, emeraldEndDateFieldByStory, emeraldStartDateFieldByStory, emeraldRegexFieldByStory, emeraldMultipleSelectorByStory, emeraldTextView]
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
        self.createHideKeyboardGesture()
//        self.createFields()
        self.createStoryBoardFields()
    }

    private func createHideKeyboardGesture() {
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
        viewTapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(viewTapGesture)
    }

    @objc func handleViewTap(recognizer: UIGestureRecognizer) {
        resignFirstResponder()
    }

    private func createStoryBoardFields() {
        emeraldTextByStory.setCustomDelegate(with: self)
        emeraldTextByStory.setText(with: "")
        emeraldTextByStory.setStatus(.valid)
        signatureBoxView.isUserInteractionEnabled = true
        signatureBoxView.delegate = self
        emeraldButtonByStory.addTarget(self, action: #selector(submitFormOnTouchUpInside(_:)), for: .touchUpInside)
        emeraldSelectorByStory.set(data: [
            State(name: "Antioquia", cities: ["Medellin", "Envigado"]),
            State(name: "Cundinamarca", cities: ["Chia", "Bogota"])])
        emeraldSelectorByStory.set(selectedRow: State(name: "Cundinamarca", cities: ["Chia", "Bogota"]))
        emeraldSelectorByStory.set(emptyOptionText: "Select a state")
        emptyableSelector.set(data:  [
            State(name: "Antioquia", cities: ["Medellin", "Envigado"]),
            State(name: "Cundinamarca", cities: ["Chia", "Bogota"])])
        
        emeraldMultipleSelectorByStory.enable(innerBorder: true)
        emeraldMultipleSelectorByStory.prepareForInterfaceBuilder()
        emeraldMultipleSelectorByStory.set(data: [MultipleSelectionGroupItem(title: "Uno"),
            MultipleSelectionGroupItem(title: "Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos Dos "),
            MultipleSelectionGroupItem(title: "Tres"),
            MultipleSelectionGroupItem(title: "Cuatro"),
            MultipleSelectionGroupItem(title: "Cinco")])
        emeraldRegexFieldByStory.set(regex: .custom("^([A-Z0-9]{1}-[A-Z0-9]{5}-[A-Z0-9]{5}-[A-Z0-9]{5}-[A-Z0-9]{5})$"))
        emeraldSelectorByStory.set(notifiable: self)
        emeraldStartDateFieldByStory.setDependantField(with: emeraldEndDateFieldByStory)
        emeraldStartDateFieldByStory.set(notifiable: emeraldStartDateFieldByStory)
        emeraldTextView.set(placeholder: "Description")
        textViewStack.setPlaceholder(with: "Description")
        textViewStack.setTitle(with: "My textview title with an a large extension to probe if the multiples line split work.")
        textViewStack.setIsRequired(with: true)
        emeraldAvatarLg.setTitle(with: "Sergio", lastName: "Giraldo")
        emeraldAvatarMd.setTitle(with: "Gensesis", lastName: "Sanguino")
        emeraldAvatarXs.setTitle(with: "Jorge", lastName: "Menco")
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
        customTitle?.themeColor = Color.primary.rawValue
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
            State(name: "Antioquia", cities: ["Medellin", "Envigado"]),
            State(name: "Cundinamarca", cities: ["Chia", "Bogota"])])
        state?.set(notifiable: self)
        state?.set(hint: "Antioquia")
        state?.set(isRequired: true)

        amountPaid = formStackView.createEmeraldTextField(placeholder: "Amount paid")
        amountPaid?.set(format: .currency)
        amountPaid?.set(isRequired: true)
        amountPaid?.set(hint: "$ 1234")

        //        for i in 0..<1 {
        //            let contactName = formStackView.createTextFormField(placeholder: "Contact name \(i)")
        //            contactName?.set(hint: "John Doe")
        //            contactName?.set(isRequired: false)
        //        }

        formButton = formStackView.createButton(with: "Submit form")
        formButton?.themeStyle = EmeraldButtonStyle.primary.rawValue
        formButton?.addTarget(self, action: #selector(submitFormOnTouchUpInside(_:)), for: .touchUpInside)

        formStackView.reloadFields()
    }

    @IBAction func submitFromStory(_ sender: Any) {
        if areFieldsValid() {
            // all good
        }

        // show alert or something
    }

    private func areFieldsValid() -> Bool {
        return validateEmeraldFields(with: self.emeraldFields)
    }

    @objc private func submitFormOnTouchUpInside(_ sender: UIButton) {
        emeraldTextByStory.clearText()
        self.showToast(message: "Not good. Not good at all. Let's get this fixed.", status: .failure, duration: .short)
        formStackView.areFieldsValid()
        let selectedChildren = emeraldMultipleSelectorByStory.getData().map {
            MultipleSelectionGroupItem(title: $0.getTitle())
        }

        print(selectedChildren)
    }
}

extension ViewController: EmeraldSelectorFieldChangeNotifiable {
    func onSelected(row: Selectable?, from selector: EmeraldSelectorField) {
        //By code
//        guard let stateField = self.state as? EmeraldSelectorField else {
//            return
//        }

        //By Storyboard
        guard let stateField = self.emeraldSelectorByStory else {
            return
        }

        switch selector {
        case stateField:
            guard let state = row as? State else {
                return
            }
            emptyableSelector.clearData()
            emptyableSelector.set(data:  [
                State(name: "Antioquia2", cities: ["Medellin", "Envigado"]),
                State(name: "Cundinamarca2", cities: ["Chia", "Bogota"])])
            emeraldTextDependantFieldByStory.set(availableOptions: state.cities)
            city?.set(availableOptions: state.cities)
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
        default:
            break
        }
    }
}

extension ViewController: CustomEmeraldTextFieldDelegate {
    func valueDidChange(textField: UITextField, text: String?) {
    }
    
    func didBeginEditing(textField: UITextField) {
    }
    
    func didEndEditing(textField: UITextField) {
    }
}
