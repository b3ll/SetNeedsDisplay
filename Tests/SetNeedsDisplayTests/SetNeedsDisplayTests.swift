import XCTest
@testable import SetNeedsDisplay

#if os(macOS)
import AppKit

class TestView: NSView {

    @SetNeedsDisplay var testPadding: CGFloat = 0.0

    var layoutWasInvalidated: Bool = false

    override var needsLayout: Bool {
        didSet {
            if needsLayout {
                self.layoutWasInvalidated = true
            }
        }
    }

    override func layout() {
        super.layout()

        self.layoutWasInvalidated = false
    }

}
#else
import UIKit

class TestView: UIView {

    @SetNeedsDisplay var testPadding: CGFloat = 0.0

    var layoutWasInvalidated: Bool = false

    override func setNeedsLayout() {
        super.setNeedsLayout()

        self.layoutWasInvalidated = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layoutWasInvalidated = false
    }

}
#endif

final class SetNeedsDisplayTests: XCTestCase {

    func testLayoutInvalidation() {
        let view = TestView(frame: .zero)

        #if os(macOS)
        view.layoutSubtreeIfNeeded()
        #else
        view.layoutIfNeeded()
        #endif

        view.testPadding = 50.0

        XCTAssertTrue(view.layoutWasInvalidated)
    }

    static var allTests = [
        ("testLayoutInvalidation", testLayoutInvalidation),
    ]
}
