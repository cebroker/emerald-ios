//
//  TextViewSwiftUi.swift
//  Components
//
//  Created by Ronal Fabra on 22/07/21.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct TextViewSwiftUi: UIViewRepresentable {
    
    @Binding var text: String
    var placeHolder:String = ""
    var onEditingChanged: (Bool) -> Void
    var placeholderLabel : UILabel = UILabel()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor.white
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset =  UIEdgeInsets(
            top: 0,
            left: -padding,
            bottom: 0,
            right: -padding)
        setPlaceHolderLabel(for: textView)
        return textView
    }
    
    func setPlaceHolderLabel(for textView:UITextView) {
        placeholderLabel.text = placeHolder
        placeholderLabel.sizeToFit()
        placeholderLabel.font = Typography(
            size: .h3,
            weight: .semibold).uiFont
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(
            x: .zero,
            y: -4)
        placeholderLabel.textColor = UIColor.lightGray
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
