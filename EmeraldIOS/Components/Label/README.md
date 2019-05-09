<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/Header.PNG" /></p>

# Label
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldLabel</li>
</ul>

## Usage
### Typical use

`EmeraldLabel` is a subclass of UILabel, but with more options for customizing the button's style and
behavior.

#### Swift
```swift
let label = EmeraldLabel()
```

Also can be created inside our custom EmeraldStackView as:

#### Swift
```swift
  let mainTitle = formStackView.createLabel()
  mainTitle?.text = "Main title"
```

### Customizing theme

The theme of a label can be changed for a given control state using `.themeStyle`.

For example, to make a label looks as a main title style label:

#### Swift
```swift
mainTitle?.themeStyle = EmeraldLabelStyle.mainTitle.rawValue
```
