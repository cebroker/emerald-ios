//
//  RadioButton.swift
//  EmeraldIOS
//
//  Created by William Ardila on 10/11/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

struct InnerConstant {
    static let empty = ""
    static let checkMarkCircle = "checkmark.circle.fill"
    static let circle = "circle"
}

@available(iOS 13.0.0, *)
public struct EmeraldRadioButtonUI: View {
    
    @Binding public var selected: String?
    @Binding var textRadioButton: String
    public var key: String
    public var isRequired: Bool
    
    public init(selected: Binding<String?>,
                textRadioButton: Binding<String>,
                key: String,
                isRequired: Bool = false) {
        self._selected = selected
        self._textRadioButton = textRadioButton
        self.key = key
        self.isRequired = isRequired
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 20)  {
            Button(action: {
                selected = key
            }) {
                HStack(alignment: .center, spacing: 20) {
                    Image(systemName: selected == key ?
                            InnerConstant.checkMarkCircle :
                            InnerConstant.circle)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(isRequired ?
                                            Constants.EmeraldSwiftUiTextField.errorColor.suColor :
                                            selected == key ?
                                            Constants.EmeraldSwiftUiTextField.focusColor.suColor :
                                            Color.gray.opacity(0.8))
                    EmeraldSwiftUiLabel(
                        text: $textRadioButton,
                        themeStyle: .bodyBold)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color.black)
                    Spacer()
                }.padding(16)
            }.border(isRequired ?
                        Constants.EmeraldSwiftUiTextField.errorColor.suColor :
                        selected == key ?
                        Constants.EmeraldSwiftUiTextField.focusColor.suColor:
                        Color.gray.opacity(0.8), width: 1)
       
        }
    }
}

#if DEBUG
@available(iOS 13.0.0, *)
struct EmeraldRadioButtonUI_Previews: PreviewProvider {
    @State static var longText = InnerConstant.empty
    @State static var textRadioButton = "Text Radio Button"
    @State static var select: String?
    static var previews: some View {
        EmeraldRadioButtonUI(selected: $select,
                             textRadioButton: .constant(textRadioButton),
                             key: InnerConstant.empty )
    }
}
#endif
