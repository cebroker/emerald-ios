<p align="center"><img src="/Resources/Images/Header.png" /></p>

# Date
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldDateField</li>
</ul>

## Examples
<img src="/Resources/Images/EmeraldDateField.png" />
<img src="/Resources/Images/EmeraldDateFieldError.png" />

## Usage

`EmeraldDateField` is a subclass of EmeraldTextField, but with a `EmeraldDateFieldType` protocol so it can be either editable and selected with a picker. All the date fields have their own validation method, for example:

#### Swift
```swift
let validationResult = emeraldDateFieldByStory.validateAndHandle()
return validationResult
```
### Typical use

#### Swift
```swift
let date = EmeraldDateField()
date.set(notifiable: self)
```

Also can be created inside our custom EmeraldStackView as:

#### Swift
```swift
 let formDateField = formStackView.createDateFormField(placeholder: "Start date")
 formDateField?.set(isRequired: true)
 formDateField?.set(hint: "MM/dd/yyyy")
  formDateField?.set(notifiable: self)
```

## Usage from storyboard
<p align="center"><img src="/Resources/Images/EmeraldDateFieldFromStoryBoard.png" /></p>

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
