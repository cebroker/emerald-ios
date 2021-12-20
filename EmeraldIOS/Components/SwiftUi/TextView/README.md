<p align="center"><img src="/Resources/Images/Header.png" /></p>

# TextView
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldSwiftUiTextView</li>
</ul>

## Examples
<p align="center"><img src="https://github.com/cebroker/emerald-ios/Resources/Images/EmeraldSwiftUiTextView.png" /></p>

## Usage
### Typical use

`EmeraldSwiftUiTextView` is a subclass of TextView, but with more options to customize the style of the textview and
behaviour. To initialize an EmeraldSwiftUiTextView, you must start an instance directly in your swiftui view, sending it a mandatory parameter of type `@State`, which then becomes a `Binding <String>` which is used to handle the content (text) of said textview.

#### SwiftUI
```swift
@State(initialValue: "") var text: String

    var body: some View {
        EmeraldSwiftUiTextView(text: $text)
    }
```

### Customizing textview types

The type of textview can be changed by sending the `TextViewType` parameter, but unlike the textfield, this type will only indicate the keyboard type that will appear when you tap inside the text box.

For example, to make a textview of type numeric, the value `TextViewType.numeric` must be sent in the parameter` textViewType`:

#### SwiftUI
```swift
@State(initialValue: "") var text: String

    var body: some View {
        EmeraldSwiftUiTextView(text: $text,
                                textViewType: TextViewType.numeric)
    }
```

In addition to the type, currently you can customize it by sending it the `label` (title of the textview), `focused` (indicates if the textview is active or not), `placehoder`, `accessibility` (indicates accessibility Id), `helperText`, `errorText`, `maxLength`, `hideCounter` (hide character counter when maxLength is not nil), `clearable` (show X to clean the text), `disabled`, `useLegacy` (indicates if a new designs).

the types of textviews supported so far are the following:
#### Swift
```swift
    case normal
    case numeric
```
