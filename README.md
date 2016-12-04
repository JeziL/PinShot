# PinShot

*Capture the screen and pin it for temporary usage.*

![Platform](https://img.shields.io/badge/platform-macOS-orange.svg)&nbsp;&nbsp;&nbsp;![SDK](https://img.shields.io/badge/SDK-10.12-lightgrey.svg)&nbsp;&nbsp;&nbsp;[![GitHub license](https://img.shields.io/badge/license-GPLv2-blue.svg)](https://raw.githubusercontent.com/JeziL/IPASearch/master/LICENSE)

<a href="https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1181709028&mt=12"><img src="Assets/mas.png" height="40" /></a>

For the situation where you cannot copy or don't need to copy something. Like coding referring to a snippet of code on a webpage, or typing some text in a picture someone sent to you.

Inspired by the jailbreak tweak [Snapper 2](http://moreinfo.thebigboss.org/moreinfo/depiction.php?file=snapper2Dp) on iOS.

![gif](Assets/pinshot.gif)

The global shortcut is `Shift + Option + Command + 4`, which can be customized in the preference window.

Although it's not designed to do that but you can still right click to save the screenshot.

## Build

The pods directory is not included in the repo so you need to run `pod install` manually:

```
git clone https://github.com/JeziL/PinShot.git
cd PinShot
pod install
open PinShot.xcworkspace
```

If you don't have [CocoaPods](https://cocoapods.org/) installed, [install it](https://guides.cocoapods.org/using/getting-started.html#installation).

