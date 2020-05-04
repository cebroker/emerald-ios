//
//  ErroHandable.swift
//  EmeraldIOS
//
//  Created by Sergio Giraldo on 2/05/20.
//  Copyright © 2020 Condor Labs. All rights reserved.
//

import Foundation

public protocol ErroHandable {
    func handleResult(with validationResult: Result<Bool, Error>) -> Bool
    func show(error: FormFieldErrorType)
    func clearError()
}
