<p align="center"><img src="https://github.com/cebroker/emerald-ios/blob/develop/emerald.svg" align="middle" width="25%" /></p>

# Emerald iOS 
[![Build Status](https://travis-ci.com/cebroker/emerald-ios.svg?branch=develop)](https://travis-ci.com/cebroker/emerald-ios)
![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)
![Swift version](https://img.shields.io/badge/Swift-4.0%2B-orange.svg)
[![Cocoapods compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org)

Emerald UI for iOS Apps



### Requirements

- iOS 11.0+ / macOS 10.10+

- Xcode 9.0+

- Swift 4.0+

### Documentation
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://github.com/cebroker/emerald-ios/tree/develop/EmeraldIOS/Theme">Theme palettes & typography</a></li>
 </ul>
<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://github.com/cebroker/emerald-ios/tree/develop/EmeraldIOS/UIModels/Button">Buttons</a></li>
  </ul>
 <ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://github.com/cebroker/emerald-ios/tree/develop/EmeraldIOS/UIModels/Label">Label</a></li>
  </ul>

### CocoaPods

 [CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ sudo gem install cocoapods
```

To integrate EmeraldIOS into your Xcode project using CocoaPods you need to create a `Podfile`.

For iOS platforms, this is the content

```ruby
platform :ios, '11.0'
use_frameworks!

target 'MyApp' do
  pod 'EmeraldIOS'
end
```

Now, you just need to run:

```bash
$ pod install
```

## Contribute
- If you've __found a bug__, open an issue;
- If you have a __feature request__, open an issue;
- If you __want to contribute__, submit a pull request;
