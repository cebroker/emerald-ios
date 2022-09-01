//
//  EmeraldSwiftUIPopup.swift
//  EmeraldIOS
//
//  Created by Cristopher Escorcia on 30/08/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI

public struct EmeraldSwiftUIPopup<Content: View>: View {
    private var content: Content
    private var onCloseTapped: (() -> Void)?
    
    public init(
        @ViewBuilder content: () -> Content,
        onCloseTapped: @escaping (() -> Void)
    ) {
        self.content = content()
        self.onCloseTapped = onCloseTapped
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        onCloseTapped?()
                    }
                }
            
            content
        }
    }
}

#if DEBUG
struct EmeraldSwiftUIPopup_Previews: PreviewProvider {
    static var previews: some View {
        EmeraldSwiftUIPopup {
            Text("Hello")
        } onCloseTapped: {  }

    }
}
#endif
