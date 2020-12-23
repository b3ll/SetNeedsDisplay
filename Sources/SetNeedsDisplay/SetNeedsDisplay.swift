#if os(macOS)
import AppKit
#else
import UIKit
#endif

public struct InvalidationOptions: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    /// Will call `-setNeedsDisplay` (depending on platform) on property value changes.
    public static let display = InvalidationOptions(rawValue: 1 << 0)

    /// Will call `-setNeedsLayout` (depending on platform) on property value changes.
    public static let layout = InvalidationOptions(rawValue: 1 << 1)
}

/**
 A property wrapper for `UIView` or `NSView` (depending on platform) that will invalidate aspects of the view (i.e. will call `-setNeedsDisplay`, or `-setNeedsLayout`, etc. on the view) when the property's value is changed to something new.

 ```
 class SomeView: UIView {

    @SetNeeds(.layout) var subviewPadding: CGFloat = 0.0

 }
 ```
 */
@propertyWrapper
public final class SetNeeds<Value> where Value: Equatable {

    #if os(macOS)
    public typealias ViewType = NSView
    #else
    public typealias ViewType = UIView
    #endif

    private var stored: Value
    private let invalidationOptions: InvalidationOptions

    // Heavily inspired by the work done by ebg here: https://forums.swift.org/t/property-wrappers-access-to-both-enclosing-self-and-wrapper-instance/32526
    public static subscript<EnclosingSelf>(
      _enclosingInstance observed: EnclosingSelf,
      wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
      storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, SetNeeds>
    ) -> Value where EnclosingSelf: ViewType {
      get {
        return observed[keyPath: storageKeyPath].stored
      }
      set {
        let oldValue = observed[keyPath: storageKeyPath].stored

        if newValue != oldValue {
            observed[keyPath: storageKeyPath].stored = newValue

            let invalidationOptions = observed[keyPath: storageKeyPath].invalidationOptions

            if invalidationOptions.contains(.display) {
                #if os(macOS)
                observed.setNeedsDisplay(observed.bounds)
                #else
                observed.setNeedsDisplay()
                #endif
            }

            if invalidationOptions.contains(.layout) {
                #if os(macOS)
                observed.needsLayout = true
                #else
                observed.setNeedsLayout()
                #endif
            }
        }
      }
    }

    public var wrappedValue: Value {
      get { fatalError("called wrappedValue getter") }
      set { fatalError("called wrappedValue setter") }
    }

    // IMO @SetNeeds(.display, .layout) looks nicer than @SetNeeds([.display, .layout])
    public init(wrappedValue: Value, _ invalidationOptions: InvalidationOptions...) {
        self.stored = wrappedValue
        self.invalidationOptions = invalidationOptions.reduce(into: []) { $0.insert($1) }
    }

    public init(wrappedValue: Value, _ invalidationOptions: InvalidationOptions) {
        self.stored = wrappedValue
        self.invalidationOptions = invalidationOptions
    }

}
