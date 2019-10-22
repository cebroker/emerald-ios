<p align="center"><img src="/Resources/Images/Header.png" /></p>

# Bar Charts
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">Simple color chart</li>
  <li class="icon-list-item icon-list-item--spec">Multiple color chart</li>
</ul>

## Examples
<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/chartImage.png" /></p>

## Usage

Both have the same initializer: `EmeraldChart(...)`

```
public init(type: ChartType = .simpleBarColor, data: EmeraldChartDataEntry, and options: EmeraldChartOptions = EmeraldChartOptions()) 
```

The *ONLY* params that is always required is: `data: EmeraldChartDataEntry`

```
    public init(with multipleValueData: [EmeraldChartMultipleValueDataEntry]) {
        self.multipleValueDataEntries = multipleValueData
    }
```

### Typical use for Simple Color Chart.

If you want to create a simple color chart, you might call the init without the `type` params bacause it is setting by default.

EX:
```
let barChart = EmeraldChart(data: simpleData)
```

BUT, How can I create the `simpleData`?

...

Data must be create as a `EmeraldChartDataEntry` that can be initialized in two ways according to the Chart type. for this, you must create an array of `EmeraldChartSimpleDataEntry`

EX: 

```
var dataEntries = [EmeraldChartSimpleDataEntry]()
dataEntries.append(EmeraldChartSimpleDataEntry(
            color: EmeraldTheme.yellowColor,
            value: 2,
            title: "First Data",
            subtitle: nil,
            hasAction: false))
```

Once you have the data created, you must create: 

```
`let simpleData = EmeraldChartDataEntry(with: dataEntries)`
```

And this last one is the `data` that you going pass to the `EmeraldChart` component, and that is all. 


### Typical use for Multiple Color Chart.

If you want to create a multiple color chart you must specify the `type` and the `data`:

EX:
```
let barChart = EmeraldChart(type: .multipleBarColor, data: multipleValueData)
```

BUT, How can I create the `multipleValueData`?

...

Data must be create as a `EmeraldChartDataEntry` that can be initialized in two ways according to the Chart type. for this, you must create an array of `EmeraldChartMultipleValueDataEntry`

EX: 
```
let multipleVaueDataEntries = [
                EmeraldChartMultipleValueDataEntry(value: [1, 2, 3], title: "Jun"),
                EmeraldChartMultipleValueDataEntry(value: [0, 5, 0], title: "Jul"),
                EmeraldChartMultipleValueDataEntry(value: [0, 2, 3], title: "Aug"),
                EmeraldChartMultipleValueDataEntry(value: [10, 2, 0], title: "Sep"),
                EmeraldChartMultipleValueDataEntry(value: [4, 2, 2], title: "Nov"),
                EmeraldChartMultipleValueDataEntry(value: [1, 2, 22], title: "Oct")
                ]
                
let multipleValueData = EmeraldChartDataEntry(with: multipleVaueDataEntries)
```

The `EmeraldChartMultipleValueDataEntry` have two properties: `value` and `title`
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">value</li>
  <p>Is an array where the user specify how the color will be distributed through the bar.</p>
  <li class="icon-list-item icon-list-item--spec">Multiple color chart</li>
  <p>This is the bar title in the x axis (label title).</p>
</ul>

And this last one is the `data` that you going pass to the `EmeraldChart` component, and that is all. 

### Customizing theme
At last we also can customize the bar chart through the initilizer params: `and options: EmeraldChartOptions = EmeraldChartOptions()`

Remeber that the `init` is: 

```
EmeraldChart(type: ChartType = .simpleBarColor, data: EmeraldChartDataEntry, and options: EmeraldChartOptions = EmeraldChartOptions())
```

To add options you must create an instance of: `EmeraldChartOptions()` that have values by default. Check it for more information. 

EX: 

```
let chartOptions = EmeraldChartOptions(
            cornerRadius: 5,
            barWidthPercentage: 0.3,
            barReachesTop: true,
            showSubtitle: true)
            
let emeraldSimpleBarChart = EmeraldChart(data: simpleData, and: chartOptions)
let emeraldMultipleBarChart = EmeraldChart(type: .multipleBarColor, data: simpleData, and: chartOptions)
```

#### Swift

## Usage from storyboard
There is not created to use by StoryBoard.


#### Swift
```swift
    case simpleBarColor
    case multipleBarColor
```

`simpleBarColor` is setted by default, if you wanna draw the `multipleBarColor` you must set it inside the constructor.
