//
//  SignatureContract.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/8/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

public protocol SignatureConfigurable {
    func setBottomText(with currentString: String)
}

public protocol SignatureReturnable {
    func getCurrentSignature() -> UIImage?
}

public protocol SignatureType: SignatureConfigurable & SignatureReturnable { }
