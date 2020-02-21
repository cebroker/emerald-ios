
<p align="center"><img src="/Resources/Images/Header.png" /></p>

# Pop Alert
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldPopupViewController</li>
</ul>

## Examples
<img src="/Resources/Images/EmeraldPopupViewController.png"/>

## Usage

`EmeraldPopupViewController`will help you to show popup in the simplest way. Just create and instance of `EmeraldPopupViewController` sending a view controller or a single view to be shown as a popup view. `EmeraldPopupViewController` contains useful property methods to configurate it as you need.

### Typical use

#### Swift
```swift
let customVC = CustomViewController()
let popupVC = EmeraldPopupViewController(contentController: customVC, popupWidth: 320, popupHeight: 400)
popupVC.shadowEnabled = false
self.present(popupVC, animated: true, completion: nil)
```

You can custom some properties of  `EmeraldPopupViewController`  if you'd like. For example:

#### Swift
```swift
popupVC.backgroundAlpha = 0.3
popupVC.backgroundColor = .black
popupVC.canTapOutsideToDismiss = true
popupVC.cornerRadius = 10
popupVC.shadowEnabled = true
```

## Usage from storyboard
This component can not be used in storyboards
