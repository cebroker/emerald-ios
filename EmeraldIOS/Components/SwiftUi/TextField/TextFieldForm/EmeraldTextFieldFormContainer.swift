//
//  EmeraldTextFieldFormContainer.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra Jimenez on 3/01/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct EmeraldTextFieldFormContainer<Content>: View where Content: View {
    private let text: Binding<String>
    private let hint: String?
    private let placeholder: String?
    private let errorText: String?

    @State private var isEditing: Bool
    private var hasError: Bool = false

    private var isActive: Bool {
        self.isEditing || !self.text.wrappedValue.isEmpty
    }

    private var content: () -> Content

    init(text: Binding<String>,
         hint: String? = nil,
         placeholder: String? = nil,
         errorText: String? = nil,
         isEditing: State<Bool>,
         content: @escaping () -> Content) {
        self.text = text
        self.hint = hint
        self.placeholder = placeholder
        self.errorText = errorText
        self._isEditing = isEditing
        self.content = content
    }

    private func getPlaceholderText() -> String {
        if self.placeholder == nil && hint == nil {
            return Constants.Values.empty
        } else if hint != nil && self.placeholder != nil {
            return self.isActive ? self.hint! : placeholder!
        } else if let hint = hint {
            return hint
        } else {
            return self.placeholder!
        }
    }
    
    @ViewBuilder
    var errorTextContent: some View {
        HStack(alignment: .top) {
            if hasError {
                Text(errorText ?? Constants.Values.empty)
                    .bodyBold(color: Color.fieldColor(hasError: hasError,
                                                      isActive: isActive),
                              decoration: .bold)
            }
        }
        .padding(.horizontal)
        .animation(.default)
    }
    
    @ViewBuilder
    var labelTextContent: some View {
        Text(getPlaceholderText())
            .bodyBold(color: Color.fieldColor(hasError: hasError,
                                              isActive: isActive), decoration: .bold)
            .offset(y: isActive ? -20 : 0)
            .scaleEffect(isActive ? 0.8 : 1,
                         anchor: .leading)
    }

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                labelTextContent
                self.content()
                    .offset(y: isActive ? 10 : 0)
            }
            .padding(.horizontal)
            .animation(.default)
            .padding(.vertical)
            .overlay(RoundedRectangle(cornerRadius: Constants.EmeraldSwiftUiTextField.cornerRadius)
                .stroke(Color.fieldColor(hasError: hasError,
                                         isActive: isActive),
                        lineWidth: 1))
            .padding(.horizontal, 1)
            errorTextContent
        }
    }

    func hasError(_ hasError: Bool) -> Self {
        var view = self
        view.hasError = hasError
        return view
    }
}
