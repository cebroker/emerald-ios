//
//  EmeraldTextFieldForm.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra Jimenez on 3/01/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct EmeraldTextFieldForm: View {
    private let placeholder: String?
    private let hint: String?
    private let errorText: String?
    private let text: Binding<String>
    private let keyboardType: UIKeyboardType
    private let onEditingFinished: (() -> Void)?
    private var hasError: Bool =  false
    
    @State private var isEditing: Bool = false
    
    public init(text: Binding<String>,
                placeholder: String? = nil,
                hint: String? = nil,
                errorText: String? = nil,
                keyboardType: UIKeyboardType = .default,
                onEditingFinished: (() -> Void)? = nil)
    {
        self.placeholder = placeholder
        self.text = text
        self.hint = hint
        self.errorText = errorText
        self.keyboardType = keyboardType
        self.onEditingFinished = onEditingFinished
    }
    
    public var body: some View {
        EmeraldTextFieldFormContainer(text: text,
                                      placeholder: placeholder,
                                      hint: hint,
                                      errorText: errorText) {
            TextField(Constants.Values.empty,
                      text: text,
                      onEditingChanged: { value in
                if !value {
                    self.onEditingFinished?()
                }
                isEditing.toggle()
            })
                .multilineTextAlignment(.leading)
                .keyboardType(keyboardType)
        }
                                      .hasError(hasError)
    }
    
    public func hasError(_ hasError: Bool) -> Self {
        var view = self
        view.hasError = hasError
        return view
    }
}
