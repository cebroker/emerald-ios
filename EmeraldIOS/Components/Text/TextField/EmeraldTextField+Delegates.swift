//
//  EmeraldTextField+Delegates.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 2/05/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import UIKit

extension EmeraldTextField {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        activateField()
        customTextFieldDelegate?.didBeginEditing?(textField: textField)
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        deactivateField()
        customTextFieldDelegate?.didEndEditing?(textField: textField)
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let beginning: UITextPosition = textField.beginningOfDocument
        let cursorLocation: UITextPosition? = textField.position(from: beginning, offset: range.location + string.count)

        guard let oldText = textField.text, let textRange = Range(range, in: oldText) else {
            return true
        }

        if maxLength > 0 {
            let newLength = (oldText.count - range.length) + string.count

            guard newLength <= maxLength else {
                return false
            }
        }

        let updatedText = oldText.replacingCharacters(in: textRange, with: string)
        customTextFieldDelegate?.valueDidChange?(textField: self, text: updatedText)

        DispatchQueue.global(qos: .background).async {
            do {
                let textWithoutFormat = try self.remove(format: self.innerFormat, to: updatedText)
                let newText = try self.apply(format: self.innerFormat, to: textWithoutFormat)

                DispatchQueue.main.async {
                    textField.text = newText

                    if let cursorLocation = cursorLocation {
                        textField.selectedTextRange = textField.textRange(
                            from: cursorLocation,
                            to: cursorLocation)
                    }
                }

            } catch (let error) {
                print(error)
            }
        }

        return false
    }
}
