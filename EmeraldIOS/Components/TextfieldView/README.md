<p align="center"><img src="/Resources/Images/Header.png" /></p>


# EmeraldTextFieldView
## Examples
<img src="/Resources/Images/textfieldview.png" />

## Usage

EmeraldTextFieldView is a subclass of UIView, that contains an EmeraldTextField and an EmeraldLabel. Now, the textField has an animation which displays the error below the field. EmeraldTextFieldView has the same public methods as the EmeraldTextField.

Emerald TextField View inherits from BaseInputView, where it shares common animation methods for the textfield and error label. For example:

#### Swift
```swift
let emeraldTextFieldView = EmeraldTextFieldView()

//This is how you set a placeholder
 emeraldTextFieldView.set(placeholder: placeholder)

//This is how you set a hint
 emeraldTextFieldView.set(hint: hint)
  

//This is how you can get the text form textfield.
emeraldTextFieldView.text
```



# EmeraldDateFieldView

## Examples

<img src="/Resources/Images/EmeraldDateFieldView.png" />

## Usage

EmeraldDateFieldView is a subclass of EmeraldTextFieldView, this emerald component has the same public methods as the EmeraldDateField.

 For example:

#### Swift
```swift
let emeraldDateFieldView = EmeraldDateFieldView()
//This is how you set a minimum date value for the picker
if let minimumDate = self.minimumDate {
    emeraldDateFieldView.set(minimumDate: minimumDate)
}

//This is how you set a maximum date value for the picker
if let maximumDate = self.maximumDate {
   emeraldDateFieldView.set(maximumDate: maximumDate)
}

//This is how you can open the picker with a previously selected date
if let currentDate = self.getDate(from: "04/24/1992") {
   emeraldDateFieldView.set(currentDateValue: currentDate)
}
```

## 

# EmeraldRegexTextFieldView

## Examples

<img src="/Resources/Images/emeraldregextextfieldview.png" />

## Usage

EmeraldRegexTextFieldView is a subclass of EmeraldTextFieldView, this emerald component has the same public methods as the EmeraldRegexTextField.

#### Swift
```swift
let emeraldRegexTextFieldView = EmeraldRegexTextFieldView()
//This is how you set a regex
emeraldRegexTextFieldView.set(regex: .custom("^[0-9]{0,5}$"))
```



# EmeraldSelectorFieldView

## Examples

<img src="/Resources/Images/EmeraldSelectorFieldView.png" />

## Usage

EmeraldSelectorFieldView is a subclass of EmeraldTextFieldView, this emerald component has the same public methods as the EmeraldSelectorField.

### Typical use

#### Swift
```swift
let emeraldSelectorFieldView = EmeraldSelectorFieldView()

emeraldSelectorFieldView.set(data: [
            State(name: "Antioquia", cities: ["Medellin", "Envigado"]),
            State(name: "Cundinamarca", cities: ["Chia", "Bogota"])])
emeraldSelectorFieldView.set(notifiable: self)
```