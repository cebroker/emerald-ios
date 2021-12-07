<p align="center"><img src="/Resources/Images/Header.png" /></p>

# TextFields
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldSwiftUiTextField</li>
</ul>

## Examples
<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/EmeraldSwiftUiTextField.png" /></p>

## Usage
### Typical use

`EmeraldSwiftUiTextField` is a subclass of TextField, but with more options to customize the style of the textfield and
behaviour. To initialize an EmeraldSwiftUiTextField, you must start an instance directly in your swiftui view, sending it a mandatory parameter of type @State, which then becomes a Binding <String> which is used to handle the content (text) of said textfield.

#### Swift
```swift
@State(initialValue: "") var text: String

    var body: some View {
        EmeraldSwiftUiTextField(text: $text)
    }
```

### Customizing textfield types

The type of textfield can be changed by sending the `TextFieldType` parameter.

For example, to make a textfield of type email, the value `TextFieldType.email` must be sent in the parameter` textFieldType`:

#### Swift
```swift
@State(initialValue: "") var text: String

    var body: some View {
        EmeraldSwiftUiTextField(textFieldType: TextFieldType.email,
                                text: $text)
    }
```

In addition to the type, currently you can customize it by sending it the label (title of the textfield), placehoder, helperText, errorText, maxLength, hideCounter (hide character counter when maxLength is not nil), clearable (show X to clean the text), disabled, useLegacy (indicates if a new designs) and show (bool value to indicate if the text is masked or not when the textfield type is password)

the types of textfields supported so far are the following:
#### Swift
```swift
    case normal
    case email
    case password
    case currency
    case numeric
    case shortDate
    case longDate
```
