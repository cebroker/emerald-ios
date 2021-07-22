//
//  SwiftUiView.swift
//  ProofOfConcept
//
//  Created by Daniel Crespo Duarte on 7/22/21.
//  Copyright © 2021 Luis David Goyes Garces. All rights reserved.
//
import EmeraldIOS
import SwiftUI

@available(iOS 13.0.0, *)
struct SwiftUiView: View {
    @State static var text = "Main title"
    @ViewBuilder

    var emeraldLabelByStory: some View {
        EmeraldSwiftUiLabel(
            text: SwiftUiView.$text,
            themeStyle: .mainTitle)
    }

    var body: some View {
        ScrollView {
            VStack {
                emeraldLabelByStory
            }
        }
    }
}

@available(iOS 13.0.0, *)
struct SwiftUiView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUiView()
    }
}
