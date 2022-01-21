//
//  EmeraldTextFieldFormPicker.swift
//  EmeraldIOS
//
//  Created by Ronal Fabra on 18/01/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct EmeraldTextFieldFormPicker: View {
    private let hint: String?
    private let placeholder: String?
    private var errorText: String?
    private var hasError = false
    @Binding private var data: [Selectable]
    @Binding private var lastSelectedIndex: Int?
    @State private var isEditing: Bool = false
    
    public init(
        hint: String? = nil,
        placeholder: String? = nil,
        data: Binding<[Selectable]>,
        lastSelectedIndex: Binding<Int?>
    ) {
        self.hint = hint
        self.placeholder = placeholder
        self._data = data
        self._lastSelectedIndex = lastSelectedIndex
    }
    
    private func getPlaceholderText() -> String {
        if let hint = hint {
            return hint
        }
        return Constants.Values.empty
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
    
    @ViewBuilder
    var errorTextContent: some View {
        HStack(alignment: .top) {
            if let message = errorText, hasError {
                Text(message)
                    .bodyBold(color: Color.fieldColor(hasError: hasError,
                                                      isActive: isActive),
                              decoration: .bold)
            }
        }
        .padding(.horizontal)
        .animation(.default)
    }
    
    @ViewBuilder
    var arrowDownImage: some View {
        Image(uiImage: UIImage(named: Constants.Icons.arrowDown,
                               in: Bundle(for: ClassBundle.self),
                               compatibleWith: nil) ??
              UIImage(systemName: Constants.Icons.systemArrowDown)!)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(Constants.EmeraldSwiftUiTextField.primaryColor.suColor)
            .frame(
                width: Constants.EmeraldSwiftUiTextField.widthIcon,
                height: Constants.EmeraldSwiftUiTextField.widthIcon)
    }
    
    public var body: some View {
        EmeraldTextFieldFormContainer(text: .constant(getSelectedText()),
                                      hint: hint,
                                      placeholder: placeholder,
                                      errorText: errorText,
                                      isEditing: _isEditing) {
            HStack {
                EmeraldTextFieldPicker(data: $data,
                                       placeholder: placeholder,
                                       lastSelectedIndex: $lastSelectedIndex,
                                       isEditing: $isEditing)
                    .multilineTextAlignment(.leading)
                Spacer()
                arrowDownImage
                    .yes(isActive) { view in
                        view.offset(y: -10)
                    }
            }
        }
                                      .hasError(hasError)
    }
    
    private var isActive: Bool {
        self.isEditing || self.lastSelectedIndex != nil
    }
    
    private func getSelectedText() -> String {
        if let lastSelectedIndex = lastSelectedIndex {
            return data[lastSelectedIndex].getSelectableText()
        }
        return Constants.Values.empty
    }
    
    public func hasError(_ hasError: Bool, errorText: String? = nil) -> Self {
        var view = self
        view.hasError = hasError
        view.errorText = errorText
        return view
    }
}

#if DEBUG || TEST
@available(iOS 13.0, *)
struct EmeraldTextFieldFormPicker_Previews: PreviewProvider {
    static var previews: some View {
        EmeraldTextFieldFormPicker(data: .constant([]),
                                   lastSelectedIndex: .constant(nil))
    }
}
#endif

