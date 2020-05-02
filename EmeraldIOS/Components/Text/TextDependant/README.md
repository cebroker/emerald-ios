<p align="center"><img src="/Resources/Images/Header.png" /></p>

# TextDependantField
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldTextDependantField</li>
</ul>

## Examples
<img src="/Resources/Images/EmeraldTextDependantField.png" />
<img src="/Resources/Images/EmeraldTextDependantFieldError.png" />

## Usage

`EmeraldTextDependantField` is a subclass of EmeraldTextField, but with a `EmeraldTextDependantFieldType` protocol so it can be validated from a `[String]`. All the fields have their own validation method, for example:

#### Swift
```swift
let validationResult = emeraldDependantFieldByStory.validateAndHandle()
return validationResult
```
### Typical use

#### Swift
```swift
let textDependant = EmeraldTextDependantField()

func onSelected(row: Selectable, from selector: EmeraldSelectorField) {
        //By code
        guard let stateField = self.state as? EmeraldSelectorField else {
            return
        }
        
        //By Storyboard
        guard let stateField = self.emeraldSelectorByStory else {
            return
        }

        switch selector {
        case stateField:
            guard let state = row as? State else {
                return
            }
            emeraldTextDependantFieldByStory.set(availableOptions: state.cities)
            city?.set(availableOptions: state.cities)
        default:
            break
        }
    }
```

Also can be created inside our custom EmeraldStackView as:

#### Swift
```swift
 let formField = formStackView.createEmeraldTextDependantField(placeholder: "City")
 formField?.set(isRequired: true)
 formField?.set(hint: "Medellin")
 formField.set(availableOptions: [String]())
```
