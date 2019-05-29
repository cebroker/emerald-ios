
<p align="center"><img src="/Resources/Images/Header.png" /></p>

# Label
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldSegmentedBar</li>
</ul>

# Example
<img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/SegmentedBar.png" />

## Usage

`EmeraldSegmentedBar` is a custom segmented bar where you can add titles with  badge numbers.

### Typical use

You can use it by storyboard or programatically. 

#### Swift
```swift
let segmentedBar = EmeraldSegmentedBar(titles: ["One", "Two"])
```

### Delegation

To know when a segmented item was tapped, just define a class that conforms `EmeraldSegmentedBarActionable` protocol and add it to `EmeraldSegmentedBar` as follow:

```swift
class CustomClass: EmeraldSegmentedBarActionable {
	func segmentedBar(_ bar: EmeraldSegmentedBar, didTapItemAt index: Int, with title: String) {
		print("title: \(title) at index: \(index) was tapped")
	}
}

let customDelegate = CustomClass()
segmentedBar.delegate = customDelegate 
```

### Customizing theme

The theme of a EmeraldSegmentedBar can be changed for a given control state using `.themeStyle`.

Currently only there is one style available, the `primary` style. Feel free to send a PR with your custom style theme.
#### Swift
```swift
segmentedBar?.themeStyle = EmeralSegmentedBarStyle.primary.rawValue
```
## Usage from storyboard
<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/SegmentedBarFromStoryboard.png" /></p>

To set the segmented titles, just add the titles separating by break lines  in `Segments` property as appears at the screenshot above.

To set a theme style, you only need to set the `Theme Style` for the style you want. All the `EmeralSegmentedBarStyle` are:

#### Swift
```swift
    case primary
```

If you want custom `Theme Style` you need to set `Theme Color`, `Theme FontSize` and `Theme FontWeight`
