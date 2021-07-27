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
    
    struct InnerConstant {
        static let buttonTitle = "Buttons"
    }
    // MARK: States
    @State private var mainTitle = "Main Title"
    @State private var subTitle = "Sub Title"
    @State private var tableHeader = "Table Header"
    @State private var link = "link"
    @State private var hello = "hello"
    @State private var bodyText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    @State var buttonName = "Info"
    @State var isEnabled = true
    @State var isHighlighted = false
    
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
    
    var emeraldButtonByStory: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(InnerConstant.buttonTitle)
            Spacer()
            
            EmeraldSwiftUIButton(buttonName: $buttonName,
                                     isEnabled: $isEnabled,
                                     isHighlighted: $isHighlighted,
                                     themeStyle: .secondary)
            EmeraldSwiftUIButton(buttonName: $buttonName,
                                     isEnabled: $isEnabled,
                                     isHighlighted: $isHighlighted,
                                     themeStyle: .plain)
            EmeraldSwiftUIButton(buttonName: $buttonName,
                                     isEnabled: $isEnabled,
                                     isHighlighted: $isHighlighted,
                                     themeStyle: .primarySuccess)
            EmeraldSwiftUIButton(buttonName: $buttonName,
                                     isEnabled: $isEnabled,
                                     isHighlighted: $isHighlighted,
                                     themeStyle: .primaryWarning)
            EmeraldSwiftUIButton(buttonName: $buttonName,
                                     isEnabled: $isEnabled,
                                     isHighlighted: $isHighlighted,
                                     themeStyle: .primaryError)
            EmeraldSwiftUIButton(buttonName: $buttonName,
                                     isEnabled: $isEnabled,
                                     isHighlighted: $isHighlighted,
                                     themeStyle: .plainPrimary)
        }
    }

    // MARK: Body
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                emeraldLabelByStory
                    .padding()
                emeraldChipViewByStory
                emeraldButtonByStory
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
