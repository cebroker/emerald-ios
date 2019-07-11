<p align="center"><img src="/Resources/Images/Header.png" /></p>

# TextField
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldTextField</li>
</ul>

## Examples
<img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/EmeraldTextField.png" />
<img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/EmeraldTextFieldErrorExample.png" />

## Usage

`EmeraldTextField` is a subclass of UITextField, but with more options for customizing the textfield's style and
behavior. If you are creating the view without storyboard your textfield element should be a instance of type: `EmeraldTextFormFieldType`.
To initialize an EmeraldTextField, you must alloc/init an instance directly. All the textfields have their own validation method, for example:

#### Swift
```swift
let validationResult = emeraldTextByStory.validateAndHandle()
return validationResult
```
### Typical use

#### Swift
```swift
let textfield = EmeraldTextField()
```

Also can be created inside our custom EmeraldStackView as:

#### Swift
```swift
 let formTextField = formStackView.createEmeraldTextField(placeholder: "Organization name")
 formTextField?.set(isRequired: true)
 formTextField?.set(hint: "Condor Labs")
```
Show custom error

```swift
  let formTextField = formStackView.createEmeraldTextField(placeholder: "Some text")
  formTextField?.show(error: FormFieldError.custom("Your error"))
```
if you want to set a responder to focus the next textfield, you can do it in this way
by Code
```swift
let formTextFieldName = formStackView.createEmeraldTextField(placeholder: "Name")
let formT
extFieldLastname = formStackView.createEmeraldTextField(placeholder: "Lastname")
formTextFieldName.nextResponderField = formTextFieldLastname
```
by Storyboard there is an outlet to reference the view with name nextResponderField
<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/EmeraldTextFieldFromStoryboard.png" /></p>

### Customizing theme

The theme of a textfield will always be the primary styled EmeraldUI field.

## Usage from storyboard
<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/NextResponder.png" /></p>

You only need to set the `Theme Style` for the emerald textfield you want. All the `EmeraldTextFieldStyle` are:
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
