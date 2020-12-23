#if os(macOS)
import AppKit
#else
import UIKit
#endif

// Heavily inspired by the work done by ebg here: https://forums.swift.org/t/property-wrappers-access-to-both-enclosing-self-and-wrapper-instance/32526

/// A property wrapper for `UIView` or `NSView` (depending on platform) that will invalidate the layout of the view when the property's value is changed to something new.
@propertyWrapper
public final class SetNeedsDisplay<Value> where Value: Equatable {

    #if os(macOS)
    public typealias ViewType = NSView
    #else
    public typealias ViewType = UIView
    #endif

    public static subscript<EnclosingSelf>(
      _enclosingInstance observed: EnclosingSelf,
      wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
      storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, SetNeedsDisplay>
    ) -> Value where EnclosingSelf: ViewType {
      get {
        return observed[keyPath: storageKeyPath].stored
      }
      set {
        let oldValue = observed[keyPath: storageKeyPath].stored
        observed[keyPath: storageKeyPath].stored = newValue

        if newValue != oldValue {
            #if os(macOS)
            observed.needsLayout = true
            #else
            observed.setNeedsLayout()
            #endif
        }
      }
    }

    public var wrappedValue: Value {
      get { fatalError("called wrappedValue getter") }
      set { fatalError("called wrappedValue setter") }
    }

    public init(wrappedValue: Value) {
        self.stored = wrappedValue
    }

    // MARK: - Private

    private var stored: Value

}
