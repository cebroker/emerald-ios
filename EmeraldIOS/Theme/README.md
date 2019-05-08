<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/Header.PNG" /></p>

# Palettes
The EmeraldTheme component provides EmeraldiOS colors organized into similar palettes.
<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/Palettes.PNG" /></p>

## Usage
### Typical use
Much like UIColor objects, `EmeraldTheme` objects are immutable static objects you can use to obtain `EmeraldUI` colors.

#### Swift
```swift
view.backgroundColor = EmeraldTheme.backgroundColor
```
# Typography (Font)
The `Font` component provides methods for displaying text using the type sizes from the `EmeraldUI` specifications.
<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/Fonts.PNG" /></p>

## Usage
### Font
Select a font most appropriate to its usage and set it as your label's font. All fonts are returned
from class methods beginning with the font's `EmeraldUI` type style.
EmeraldUI Typography should be used consistently throughout the entire UI.

## Type Sizes
`Font` provides a `UIFont` font for each of the standard type
settings in the EmeraldUI specifications.

### EmeraldiOS type styles and their respective `Font` sizes

| EmeraldiOS FontType | FontSize | 
| -------------------- | ------------------ |
| h1 | 30 |
| h2 | 24 |
| h3 | 16 |
| h4 | 14 |
| h5 | 12 |
| h6 | 9 |
| navigationTitleText | 17 |
| body | body1Font | 16 |
| button | captionFont | 18 |
| smallButton | 12 |
| largeButton | 20 | 
| label | UIFont.labelFontSize |
| tableHeader | | 14 |
<!--{: .data-table }-->

| EmeraldiOS Font | FontWeight | 
| -------------------- | ------------------ |
| OpenSansFonts.Light | light |
| OpenSansFonts.Regular | regular |
| OpenSansFonts.SemiBold  | semibold |
| OpenSansFonts.Bold | bold |
<!--{: .data-table }-->


### Text color reference
<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/Text%20Colors.PNG" /></p>

## Examples

### Create a Title Label
```swift
let label = UILabel()
label.text = "This is a title"
label.font = Font(size: .h3, weight: .regular).uiFont
```
### Using EmeraldLabel Component
```swift
let emeraldLabel = EmeraldLabel()
emeraldLabel.text = "This is a title"
emeraldLabel.font = Font(size: .h3, weight: .regular).uiFont
```
Also can make use of the predefined themes:
```swift
let emeraldLabel = EmeraldLabel()
emeraldLabel.themeStyle = EmeraldLabelStyle.mainTitle.rawValue
emeraldLabel.text = "This is a title"
```
