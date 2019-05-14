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

class ViewController: UIViewController {
    
    @IBOutlet private weak var formStackView: EmeraldStackView!
    
    @IBOutlet weak var emeraldLabelByStory: EmeraldLabel!
    @IBOutlet weak var emeraldTextByStory: EmeraldTextField!
    @IBOutlet weak var emeraldButtonByStory: EmeraldButton!
    @IBOutlet weak var buttonForSignature: EmeraldButton!
    @IBOutlet weak var signatureImageView: UIImageView!
    @IBOutlet weak var emeraldSelectorByStory: EmeraldSelectorField!
    @IBOutlet weak var emeraldTextDependantFieldByStory: EmeraldTextDependantField!
    
    private var organizationName: EmeraldTextFormFieldType?
    
    private var address: EmeraldTextFormFieldType?
    private var city: EmeraldTextDependantField?
    private var state: EmeraldSelectorFieldType?
    
    private var zip: EmeraldTextFormFieldType?
    private var contactName: EmeraldTextFormFieldType?
    private var membershipDuesAmount: EmeraldTextFormFieldType?
    //    private var dueDateForDues: DateFormField?
    private var amountPaid: EmeraldTextFormFieldType?
    //    private var paymentDate: DateFormField?
    
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
        emeraldButtonByStory.addTarget(self, action: #selector(submitFormOnTouchUpInside(_:)), for: .touchUpInside)
        emeraldSelectorByStory.set(data: [
            State(name: "Antioquia", cities: ["Medellin", "Envigado"]),
            State(name: "Cundinamarca", cities: ["Chia", "Bogota"])])
        emeraldSelectorByStory.set(notifiable: self)
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
        
        //        zip = formStackView.createTextFormField(placeholder: "Zip")
        //        zip?.set(maxLength: 5)
        //        zip?.set(format: .number)
        //        zip?.set(inputType: .numberPad)
        //        zip?.set(hint: "12345")
        //
        //        contactName = formStackView.createTextFormField(placeholder: "Contact name")
        //        contactName?.set(hint: "John Doe")
        //
        //        membershipDuesAmount = formStackView.createTextFormField(placeholder: "Membership dues")
        //        membershipDuesAmount?.set(format: .currency)
        //        membershipDuesAmount?.set(hint: "$ 1234")
        //
        ////        dueDateForDues = formStackView.createDateFormField(placeholder: "Due date for dues")
        ////        dueDateForDues?.set(hint: "MM/dd/yyyy")
        
        amountPaid = formStackView.createEmeraldTextField(placeholder: "Amount paid")
        amountPaid?.set(format: .currency)
        amountPaid?.set(isRequired: true)
        amountPaid?.set(hint: "$ 1234")
        
        ////        paymentDate = formStackView.createDateFormField(placeholder: "Payment date")
        ////        paymentDate?.set(hint: "MM/dd/yyyy")
        //
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
        let textFieldValidation = emeraldTextByStory.validateAndHandle()
        let selectorValidation = emeraldSelectorByStory.validateAndHandle()
        let textDependantValidation = emeraldTextDependantFieldByStory.validateAndHandle()
        return textFieldValidation && selectorValidation && textDependantValidation
    }
    
    @IBAction func goToSignatureView(_ sender: Any) {
        let signatureVC = EmeraldSignatureViewController(signatureDelegate: self)
        signatureVC.subtitleText = "I agree to the terms and conditions"
        signatureVC.title = "Sign up here :v"
        let navigationToBePresented = UINavigationController(rootViewController: signatureVC)
        present(navigationToBePresented, animated: true, completion: nil)
    }
    
    @objc private func submitFormOnTouchUpInside(_ sender: UIButton) {
        formStackView.areFieldsValid()
    }
}

extension ViewController: SignatureReturnable {
    func emeraldSignature(_: EmeraldSignatureViewController,
                          didCancel error : NSError) {
        print("User canceled")
    }
    
    func emeraldSignature(_: EmeraldSignatureViewController,
                          didSign signatureImage : UIImage,
                          boundingRect: CGRect) {
        signatureImageView.image = signatureImage
    }
}

extension ViewController: EmeraldSelectorFieldChangeNotifiable {
    func onSelected(row: Selectable, from selector: EmeraldSelectorField) {
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
            emeraldTextDependantFieldByStory.set(availableOptions: state.cities)
            city?.set(availableOptions: state.cities)
        default:
            break
        }
    }
}
