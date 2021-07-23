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
    // MARK: States
    @State private var mainTitle = "Main Title"
    @State private var subTitle = "Sub Title"
    @State private var tableHeader = "Table Header"
    @State private var link = "link"
    @State private var hello = "hello"
    @State private var bodyText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    
    // MARK: ViewBuilder
    @ViewBuilder
    var emeraldLabelByStory: some View {
        VStack(alignment: .center, spacing: 5) {
            EmeraldSwiftUiLabel(
                text: $mainTitle,
                themeStyle: .mainTitle)
            Spacer()
            EmeraldSwiftUiLabel(
                text: $subTitle,
                themeStyle: .subtitle)
            Spacer()
            EmeraldSwiftUiLabel(
                text: $tableHeader,
                themeStyle: .tableHeader)
            Spacer()
            EmeraldSwiftUiLabel(
                text: $link,
                themeStyle: .link)
            Spacer()
            
        }
        VStack(alignment: .center, spacing: 5) {
            EmeraldSwiftUiLabel(
                text: $bodyText,
                themeStyle: .body)
            Divider()
            EmeraldSwiftUiLabel(
                text: $bodyText,
                themeStyle: .bodyBold)
        }
    }

    @ViewBuilder
    var emeraldChipViewByStory: some View {
        HStack(alignment: .center, spacing: 5) {
            EmeraldSwiftUiChipView(text: $hello, themeStyle: .simple)
            EmeraldSwiftUiChipView(text: $hello, themeStyle: .error)
            EmeraldSwiftUiChipView(text: $hello, themeStyle: .success)
            EmeraldSwiftUiChipView(text: $hello, themeStyle: .warning)
            EmeraldSwiftUiChipView(text: $hello, themeStyle: .dismissable)
        }
    }

    // MARK: Body
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                emeraldLabelByStory
                    .padding()
                emeraldChipViewByStory
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity)
        }
    }
}

@available(iOS 13.0.0, *)
struct SwiftUiView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUiView()
    }
}
