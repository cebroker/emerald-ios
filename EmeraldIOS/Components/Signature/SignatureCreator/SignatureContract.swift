//
//  SignatureContract.swift
//  EmeraldIOS
//
//  Created by Genesis Sanguino on 5/8/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit

@objc public protocol SignatureReturnable {
    @objc optional func emeraldSignature(_: EmeraldSignatureViewController, didCancel error : NSError)
    @objc optional func emeraldSignature(_: EmeraldSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect)
}
