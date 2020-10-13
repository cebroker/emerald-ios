//
//  EmeraldTextViewFieldDelegate.swift
//  EmeraldIOS
//
//  Created by Carlos Pava on 13/10/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import Foundation

public protocol EmeraldTextViewFieldDelegate: AnyObject {
    func openEmail(_ url: URL)
}
