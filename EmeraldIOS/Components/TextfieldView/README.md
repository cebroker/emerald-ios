<p align="center"><img src="/Resources/Images/Header.png" /></p>



# EmeraldTextFieldView
## Examples
<img src="/Resources/Images/EmeraldDatePickerAlert.png" />

## Usage

EmeraldTextFieldView is a subclass of UIView, that contains a EmeraldTextField and a EmeraldLabel, it´s change the way for show error with a bottom animation, EmeraldTextFieldView has public methods for accesibility to all actions of the EmeraldTextField, also Emerald TextField View inherit from Base InputView where has common methods about textfield and error label animation. For example:

#### Swift
```swift
let datePicker = EmeraldTextFieldView()
//This is how you set a placeholder
public func set(placeholder: String) {
    self.textField.prepareForInterfaceBuilder()
    textField.set(placeholder: placeholder)
 }

//This is how you set a hint
 public func set(hint: String?) {
      self.textField.set(hint: hint)
  }

//This is how you can get text form textfield.
  public var text: String? {
        set {
            self.textField.text = newValue
        }
        get {
            return self.textField.text
        }
    }
```