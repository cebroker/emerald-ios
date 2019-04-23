//
//  ViewController.swift
//  ProofOfConcept
//
//  Created by Luis David Goyes Garces on 3/20/19.
//  Copyright © 2019 Luis David Goyes Garces. All rights reserved.
//

import UIKit
import CondorUIComponentsIOS

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

class ViewController: UIViewController {

    @IBOutlet private weak var formStackView: FormStackView!

    private var organizationName: TextFormFieldType?
    private var address: TextFormFieldType?
    private var city: TextSelectionFormFieldType?
    private var state: SelectorFormFieldType?

    private var zip: TextFormFieldType?
    private var contactName: TextFormFieldType?
    private var membershipDuesAmount: TextFormField?
    private var dueDateForDues: DateFormField?
    private var amountPaid: TextFormField?
    private var paymentDate: DateFormField?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createFields()
    }

    private func createFields() {
        organizationName = formStackView.createTextFormField(placeholder: "Organization name")
        organizationName?.set(hint: "Condor Labs")
        
        address = formStackView.createTextFormField(placeholder: "Address")
        address?.set(hint: "Calle NN # NN - NN")
        
        city = formStackView.createTextSelectionField(placeholder: "City")
        city?.set(hint: "Medellín")
        
        state = formStackView.createSelectorFormField(placeholder: "State")
        state?.set(data: [
            State(name: "Antioquia", cities: ["Medellin", "Envigado"]),
            State(name: "Cundinamarca", cities: ["Chia", "Bogota"])])
        state?.set(notifiable: self)
        state?.set(hint: "Antioquia")

        zip = formStackView.createTextFormField(placeholder: "Zip")
        zip?.set(maxLength: 5)
        zip?.set(format: .number)
        zip?.set(inputType: .numberPad)
        zip?.set(hint: "12345")

        contactName = formStackView.createTextFormField(placeholder: "Contact name")
        contactName?.set(hint: "John Doe")

        membershipDuesAmount = formStackView.createTextFormField(placeholder: "Membership dues")
        membershipDuesAmount?.set(format: .currency)
        membershipDuesAmount?.set(hint: "$ 1234")

        dueDateForDues = formStackView.createDateFormField(placeholder: "Due date for dues")
        dueDateForDues?.set(hint: "MM/dd/yyyy")

        amountPaid = formStackView.createTextFormField(placeholder: "Amount paid")
        amountPaid?.set(format: .currency)
        amountPaid?.set(hint: "$ 1234")

        paymentDate = formStackView.createDateFormField(placeholder: "Payment date")
        paymentDate?.set(hint: "MM/dd/yyyy")

        for i in 0..<1 {
            let contactName = formStackView.createTextFormField(placeholder: "Contact name \(i)")
            contactName?.set(hint: "John Doe")
        }

        formStackView.reloadFields()
    }
}

extension ViewController: SelectorFormFieldChangeNotifiable {
    func onSelected(row: Selectable, from selector: SelectorFormField) {
        guard let stateField = self.state as? SelectorFormField else {
            return
        }

        switch selector {
        case stateField:
            guard let state = row as? State else {
                return
            }

            city?.set(availableOptions: state.cities)
        default:
            break
        }
    }
}
