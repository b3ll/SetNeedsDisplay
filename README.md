# LayoutInvalidating

![Tests](https://github.com/b3ll/LayoutInvalidating/workflows/Tests/badge.svg)

This package provides a property wrapper that can be used on properties for any `NSView` or `UIView` to invalidate the layout whenever the value of said property is changed.

**Note**: This code contains some private Swift API stuff that powers `@Published` so there's a strong likelyhood this will break in the future.

- [Introduction](#layoutinvalidating)
- [Usage](#usage)
- [Installation](#installation)
  - [Requirements](#requirements)
  - [Swift Package Manager](#swift-package-manager)
- [License](#license)
- [Thanks](#thanks)
- [Contact Info](#contact-info)

# Usage

Annotate your property of a type that conforms to `Equatable` like so:

```swift
class MyView: UIView {

    // Anytime someCustomProperty is changed, `-setNeedsLayout` will be called.
    @LayoutInvaldating var someCustomProperty: CGFloat = 0.0

}
```

# Installation

## Requirements

- iOS 13+, macOS 10.15+
- Swift 5.0 or higher

Currently LayoutInvalidating supports Swift Package Manager (or manually adding `LayoutInvalidating.swift` to your project).

## Swift Package Manager

Add the following to your `Package.swift` (or add it via Xcode's GUI):

```swift
.package(url: "https://github.com/b3ll/LayoutInvalidating", from: "0.0.1")
```

# License

LayoutInvalidating is licensed under the [BSD 2-clause license](https://github.com/b3ll/LayoutInvalidating/blob/master/LICENSE).

# Thanks

Thanks to [@harlanhaskins](https://twitter.com/harlanhaskins) and [@hollyborla](https://twitter.com/hollyborla) for helping point me in the right direction and explain the complexity that this sort of solution entails.

More info [here](https://forums.swift.org/t/property-wrappers-access-to-both-enclosing-self-and-wrapper-instance/32526).

# Contact Info

Feel free to follow me on twitter: [@b3ll](https://www.twitter.com/b3ll)!
