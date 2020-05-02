//
//  Requirable.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 2/05/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import Foundation

public protocol Requirable {
    func set(isRequired: Bool)
    func getIsRequired() -> Bool
}

public protocol Validable {
    func isValid() -> Result<Bool, Error>
}
