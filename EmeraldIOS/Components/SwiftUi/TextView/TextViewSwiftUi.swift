//
//  TextViewSwiftUi.swift
//  Components
//
//  Created by Ronal Fabra on 22/07/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct TextViewSwiftUi: UIViewRepresentable {
    
    @Binding var text: String
    var disabled: Bool = false
    var placeHolder: String = ""
    var onEditingChanged: (Bool) -> Void
    var placeholderLabel: UILabel = UILabel()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.isEditable = !disabled
        textView.isUserInteractionEnabled = !disabled
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset =  UIEdgeInsets(
            top: .zero,
            left: -padding,
            bottom: .zero,
            right: -padding)
        setPlaceHolderLabel(for: textView)
        return textView
    }
    
    func setPlaceHolderLabel(for textView:UITextView) {
        placeholderLabel.text = placeHolder
        placeholderLabel.sizeToFit()
        placeholderLabel.font = Typography(
            size: .h5,
            weight: .semibold).uiFont
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(
            x: .zero,
            y: -4)
        placeholderLabel.textColor = EmeraldTheme.placeholderColor
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        if text.isEmpty {
            uiView.delegate?.textViewDidChange?(uiView)
        }
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        
        var parent: TextViewSwiftUi
        
        init(_ uiTextView: TextViewSwiftUi) {
            parent = uiTextView
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.placeholderLabel.isHidden = !textView.text.isEmpty
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            parent.onEditingChanged(true)
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            parent.onEditingChanged(false)
        }
    }
}

@available(iOS 13.0.0, *)
struct TextViewSwiftUi_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: "") var name: String
        
        var body: some View {
            TextViewSwiftUi(
                text: $name,
                placeHolder: "") { _ in }
        }
    }
}
