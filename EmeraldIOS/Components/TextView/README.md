<p align="center"><img src="/Resources/Images/Header.png" /></p>

# TextView
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldTextViewField</li>
</ul>

## Usage

`EmeraldTextViewField` is a subclass of UITextView, but with more options for customizing the textview's style and
behavior. 

#### Swift
```swift
let validationResult = emeraldTextViewByStory.validateAndHandle()
return validationResult
```
### Typical use

#### Swift
```swift
let textView = EmeraldTextViewField()
```

### Customizing theme

The theme of a textfview will always be the primary (formField) styled EmeraldUI field.

## Usage from storyboard
<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/EmeraldTextFieldFromStoryboard.png" /></p>

You only need to set the `Theme Style` for the emerald textview you want. All the `EmeraldTextViewFieldStyle` are:
#### Swift
```swift
    case formField
```

You can also set a `Format` with a Int value from this enum cases:
#### Swift
```swift
 enum TextFormat: Int {
    case none = 0
    case currency
    case phone
    case number
    case shortDate
    case longDate
}
```
