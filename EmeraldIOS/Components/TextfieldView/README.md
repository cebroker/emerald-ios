<p align="center"><img src="/Resources/Images/Header.png" /></p>



# EmeraldTextFieldView
## Examples
<img src="/Resources/Images/textfieldview.png" />

## Usage

EmeraldTextFieldView is a subclass of UIView, that contains an EmeraldTextField and an EmeraldLabel. Now, the textField has an animation which displays the error below the field. EmeraldTextFieldView has the same public methods as the EmeraldTextField.

Emerald TextField View inherits from BaseInputView, where it shares common animation methods for the textfield and error label. For example:

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

//This is how you can get the text form textfield.
  public var text: String? {
        set {
            self.textField.text = newValue
        }
        get {
            return self.textField.text
        }
    }
```