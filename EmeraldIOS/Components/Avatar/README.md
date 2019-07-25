<p align="center"><img src="/Resources/Images/Header.png" /></p>

# Avatar
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec">EmeraldAvatar</li>
</ul>

## Examples
<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/EmeraldAvatar.png" /></p>

## Usage
### Typical use

`EmeraldAvatar` shows the initials of the user and changes its background color according to said initials.

#### Swift
```swift
let avatar = EmeraldAvatar()
avatar.size = EmeraldAvatarStyle.xs
avatar.setTitle(with: "Gensesis", lastName: "Sanguino")
```

#### Avatar sizes
```swift
enum EmeraldAvatarStyle
    case xs
    case md
    case lg
```

## Usage from storyboard
<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/Resources/Images/AvatarSizeFromStoryBoard.png" /></p>

You only need add a UIView and configure it with the `EmeraldAvatar`, after you go to the attributes inspector and set the 
`Size` that you want as a String. 

#### REMEMBER
1. You always need set title by code: ie, call this method: `avatar.setTitle(with: "Gensesis", lastName: "Sanguino")`
2. The color are loaded ramdom, you can't customize it. 
3. Size is `md` by default. 









