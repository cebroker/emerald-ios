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
    private let hint: String?
    private let placeholder: String?
    private let errorText: String?
    private let text: Binding<String>
    private let keyboardType: UIKeyboardType
    private let onEditingFinished: (() -> Void)?
    private var hasError: Bool =  false
    
    @State private var isEditing: Bool = false
    
    public init(text: Binding<String>,
                hint: String? = nil,
                placeholder: String? = nil,
                errorText: String? = nil,
                keyboardType: UIKeyboardType = .default,
                onEditingFinished: (() -> Void)? = nil)
    {
        self.text = text
        self.hint = hint
        self.placeholder = placeholder
        self.errorText = errorText
        self.keyboardType = keyboardType
        self.onEditingFinished = onEditingFinished
    }
    
    public var body: some View {
        EmeraldTextFieldFormContainer(text: text,
                                      hint: hint,
                                      placeholder: placeholder,
                                      errorText: errorText,
                                      isEditing: _isEditing) {
            TextField(Constants.Values.empty,
                      text: text,
                      onEditingChanged: {
                          isEditing = $0
                      }, onCommit: {
                          isEditing = false
                          onEditingFinished?()
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
