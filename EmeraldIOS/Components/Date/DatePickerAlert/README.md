<p align="center"><img src="/Resources/Images/Header.png" /></p>

# DatePickerAlert
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldDatePickerAlert</li>
</ul>

## Examples
<img src="/Resources/Images/EmeraldDatePickerAlert.png" />

## Usage

`EmeraldDatePickerAlert` is a subclass of UIView, but with a `EmeraldDatePickerAlertType` protocol where you can set minimumDate, maximumDate and currentDateValue to the picker. This components is already integrated inside the `EmeraldDateField` so it can be editable and also pickable from the calendar icon. All the date fields have their own validation method, for example:

#### Swift
```swift
let datePicker = EmeraldDatePickerAlert()
//This is how you set a minimum date value for the picker
if let minimumDate = self.minimumDate {
    datePicker.set(minimumDate: minimumDate)
}

//This is how you set a maximum date value for the picker
if let maximumDate = self.maximumDate {
   datePicker.set(maximumDate: maximumDate)
}

//This is how you can open the picker with a previously selected date
if let currentDate = self.getDate(from: "04/24/1992") {
   datePicker.set(currentDateValue: currentDate)
}

datePicker.show(self.placeHolder ?? Constants.Values.empty) { [unowned self] date in
  //Handle for date returned or cancel
}
```
