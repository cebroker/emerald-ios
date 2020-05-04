<p align="center"><img src="/Resources/Images/Header.png" /></p>

# RegexTextField
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldRegexTextField</li>
</ul>

## Examples
<img src="/Resources/Images/EmeraldRegexTextField.png" />
<img src="/Resources/Images/EmeraldRegexTextFieldError.png" />

## Usage

`EmeraldRegexTextField` is a subclass of EmeraldTextField, but with a `EmeraldRegexTextFieldType` protocol so it can be validated with a `EmeraldRegexFormatType`. All the fields have their own validation method, for example:

#### Swift
```swift
let validationResult = emeraldRegexFieldByStory.validateAndHandle()
return validationResult
```
### Typical use

#### Swift
```swift
let regexField = EmeraldRegexTextField()
```

Also can be created inside our custom EmeraldStackView as:

#### Swift
```swift
 let formField = formStackView.createEmeraldRegexFormField(placeholder: "Email")
 formField?.set(isRequired: true)
 formField?.set(hint: "Gsk@gmail.com")
 formField?.set(inputType: .emailAddress)
```

## Regex types
<img src="/Resources/Images/FieldRegex.png" />
