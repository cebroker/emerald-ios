//
//  EmeraldSwiftUICompatibleActivityIndicator.swift
//  EmeraldIOS
//
//  Created by Cristopher Escorcia on 18/08/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI

struct EmeraldSwiftUICompatibleActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let size: UIActivityIndicatorView.Style
    var colorIndicator = UIColor.gray
    
    public init(isAnimating: Binding<Bool> = .constant(true), size: UIActivityIndicatorView.Style = .medium) {
        _isAnimating = isAnimating
        self.size = size
    }
    
    public func makeUIView(context: UIViewRepresentableContext<EmeraldSwiftUICompatibleActivityIndicator>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: size)
        indicator.color = colorIndicator
        return indicator
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<EmeraldSwiftUICompatibleActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

#if DEBUG
struct EmeraldSwiftUIActivity_Previews: PreviewProvider {
    static var previews: some View {
        EmeraldSwiftUICompatibleActivityIndicator()
    }
}
#endif
