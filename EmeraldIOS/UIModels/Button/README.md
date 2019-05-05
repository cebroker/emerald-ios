# Buttons
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldButton</li>
</ul>

## Examples
<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/Buttons.PNG" /></p>

## Usage
### Typical use

`EmeraldButton` is a subclass of UIButton, but with more options for customizing the button's style and
behavior. To initialize an EmeraldButton, you must alloc/init an instance directly instead of using
`buttonWithType:`, which has been marked unavailable.

#### Swift
```swift
let button = EmeraldButton()
```

Also can be created inside our custom EmeraldStackView as:

#### Swift
```swift
 let formButton = formStackView.createButton(with: "Submit form")
 formButton?.themeStyle = EmeraldButtonStyle.primary.rawValue
 formButton?.addTarget(self, action: #selector(submitFormOnTouchUpInside(_:)), for: .touchUpInside)
```

### Customizing theme

The theme of a button can be changed for a given control state using `.themeStyle`.

For example, to make a button looks as a secondary style button:

#### Swift
```swift
button.themeStyle = EmeraldButtonStyle.secondary.rawValue
```