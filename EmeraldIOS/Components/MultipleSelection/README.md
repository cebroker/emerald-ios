<p align="center"><img src="/Resources/Images/Header.png" /></p>

# RadioButtons 
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldRadioGroupFormField</li>
</ul>

## Examples
<img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/RadioGroup.png" />
<img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/RadioGroupError.png" />

## Usage

`EmeraldRadioGroupFormField` is a subclass of UIStackView. Examples:

#### Swift
```swift
let validationResult = emeraldMultipleSelectorByStory.validateAndHandle()
return validationResult
```
### Typical use

#### Swift
```swift
let multiSelectionGroup = EmeraldRadioGroupFormField(arrangedSubviews: [Selectable])
```

### Customizing theme

The theme of a multiple selection fields will always be the `simple` styled EmeraldUI field. But if you want to add border you need to set the theme style to `bordered` and add this line to your code:
```swift
emeraldMultipleSelectorByStory.enable(innerBorder: true)
```
# Checkboxes
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldCheckboxFormField</li>
</ul>

## Examples
<img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/CheckboxGroup.png" />
<img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/CheckboxGroupError.png" />

## Usage

`EmeraldCheckboxFormField` is a subclass of UIStackView. Examples:

#### Swift
```swift
let validationResult = emeraldMultipleSelectorByStory.validateAndHandle()
return validationResult
```
### Typical use

#### Swift
```swift
let multiSelectionGroup = EmeraldCheckboxFormField(arrangedSubviews: [Selectable])
```

### Customizing theme

The theme of a multiple selection fields will always be the `simple` styled EmeraldUI field. But if you want to add border you need to set the theme style to `bordered` and add this line to your code:
```swift
emeraldMultipleSelectorByStory.enable(innerBorder: true)
```
