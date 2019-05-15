<p align="center"><img src="/Resources/Images/Header.png" /></p>

# Selector
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldSelectorField</li>
</ul>

## Examples
<img src="/Resources/Images/EmeraldSelectorField.png" />
<img src="/Resources/Images/EmeraldSelectorFieldError.png" />

## Usage

`EmeraldSelectorField` is a subclass of EmeraldTextField, but with a `EmeraldSelectorFieldType` protocol that allow to fill the picker with an `Array` of `Selectable`. All the selectors have their own validation method, for example:

#### Swift
```swift
let validationResult = emeraldSelectorByStory.validateAndHandle()
return validationResult
```
### Typical use

#### Swift
```swift
let selector = EmeraldSelectorField()
selector.set(data: [
            State(name: "Antioquia", cities: ["Medellin", "Envigado"]),
            State(name: "Cundinamarca", cities: ["Chia", "Bogota"])])
selector.set(notifiable: self)
```

Also can be created inside our custom EmeraldStackView as:

#### Swift
```swift
 let formSelectorField = formStackView.createEmeraldSelectorFormField(placeholder: "State")
 formSelectorField?.set(isRequired: true)
 formSelectorField?.set(hint: "Antioquia")
 formSelectorField?.set(data: [
            State(name: "Antioquia", cities: ["Medellin", "Envigado"]),
            State(name: "Cundinamarca", cities: ["Chia", "Bogota"])])
  formSelectorField?.set(notifiable: self)
```

## Usage from storyboard
<p align="center"><img src="/Resources/Images/EmeraldSelectorFieldFromStoryboard.png" /></p>
