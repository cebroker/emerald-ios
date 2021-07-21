//
//  EmeraldSwiftUiLabel.swift
//  EmeraldIOS
//
//  Created by Daniel Crespo Duarte on 7/21/21.
//  Copyright © 2021 Condor Labs. All rights reserved.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct EmeraldSwiftUiLabel: View {
    var text: String

    var body: some View {
        Text(text)
            .font(Font.custom("OpenSans-Bold", size: 12.3))
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
}
