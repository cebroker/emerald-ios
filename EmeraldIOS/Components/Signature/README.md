<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/Header.PNG" /></p>

# EmeraldSignature component
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldSignatureViewController</li>
</ul>
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldSignatureBox</li>
</ul>

# EmeraldSignatureViewController
This is a component for a full screen signature view controller that can return a UIImage from the signature.

# Example
<img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/EmeraldSignatureViewController.png" />

## Usage
### Typical use

`EmeraldSignatureViewController` is a subclass of UIViewController

#### Swift
```swift
let signatureVC = EmeraldSignatureViewController(signatureDelegate: self)
signatureVC.subtitleText = "I agree to the terms and conditions"
signatureVC.title = "Navigation title"

let navigationToBePresented = UINavigationController(rootViewController: signatureVC)
present(navigationToBePresented, animated: true, completion: nil)
```
