<p align="center"><img src="/Resources/Images/Header.png" /></p>

# Alert
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldAlert</li>
</ul>

## Examples
<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/alert_failure.PNG" /></p>

<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/alert_success.PNG" /></p>

## Usage
### Typical use

`EmeraldAlert` is an extension of UIViewController , created to show a message in bottom screen
#### Swift
```swift
self.showToast(message: "Not good. Not good at all. Let's get this fixed.", status: .failure, duration: .lenghtShort)
```

#### Params

**message:** The text to show inside the view.
**status:**  There are 2 status supported, success and failure each one show different configurations like background color and icon.
**duration:** It defines the time in screen could be lenghtShort or lenghtLong
