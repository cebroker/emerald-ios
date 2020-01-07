<p align="center"><img src="/Resources/Images/Header.png" /></p>

# Chips
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldChipView</li>
  <li class="icon-list-item icon-list-item--spec">EmeraldChipCollectionView</li>
</ul>

## Examples
#### EmeraldChipView:
<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/SimpleChip.png" /></p>

#### EmeraldChipCollectionView: 
![Chip Collection example](https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/ChipCollection.gif) 

## Usage
### EmeraldChipView typical use.

`EmeraldChipView` shows a simple box with a background color and text.

#### Swift
```swift
var chip: EmeraldChipView = EmeraldChipView()
chip.setText("Example test")
chip.setType(.warning)
```

#### Avatar types
```swift
enum EmeraldChipStyle
    case success //(Green background)
    case warning //(Yellow background)
    case error //(Red background)
    case simple //(Light gray background)
    case dismissable //(Light gray background with an action button, usually is implemented in the collection chips)
    case license //(Is like a dark green/gray color)
```

### EmeraldChipCollectionView typical use.

`EmeraldChipCollectionView` shows severals `EmeraldChipView` in a CollectionView.

#### Swift
```swift
var collectionChips = EmeraldChipsCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
```
To add new elements you must create a `ChipViewModel` as follow:
```swift
let viewModel = ChipViewModel(text: "Text required", type: .dismissable)
collectionChips.addNewChip(with: viewModel)
```

- Where type is any of the `EmeraldChipStyle` defined above.
- If is `dismissable` type, the chip has a close action to remove it from the collection view. 

## Uses:
You can use it from `xib` or by `code`










