//
//  EmeraldSwiftUIActivityIndicator.swift
//  EmeraldIOS
//
//  Created by Cristopher Escorcia on 18/08/22.
//  Copyright © 2022 Condor Labs. All rights reserved.
//

import SwiftUI

public struct EmeraldSwiftUIActivityIndicator: View {
    let size: ActivityIndicatorType
    
    public init(
        size: ActivityIndicatorType = .medium
    ) {
        self.size = size
    }
    
    public var body: some View {
        if #available(iOS 14.0, *) {
            ProgressView()
                .progressViewStyle(
                    CircularProgressViewStyle()
                )
                .scaleEffect(size.getSize())
        } else {
            EmeraldSwiftUICompatibleActivityIndicator(size: size.getCompatibleSize())
        }
    }
}

#if DEBUG
struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        EmeraldSwiftUIActivityIndicator()
    }
}
#endif
