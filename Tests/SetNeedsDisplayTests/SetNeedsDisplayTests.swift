import XCTest
@testable import SetNeedsDisplay

#if os(macOS)
import AppKit

class TestView: NSView {

    @SetNeedsDisplay var testSetNeedsDisplay: CGFloat = 0.0

    @SetNeedsLayout var testSetNeedsLayout: CGFloat = 0.0

    @SetNeedsDisplayAndLayout var testSetNeedsDisplayAndLayout: CGFloat = 0.0

    var layoutWasInvalidated: Bool = false

    var displayWasInvalidated: Bool = false

    override var needsLayout: Bool {
        didSet {
            if needsLayout {
                self.layoutWasInvalidated = true
            }
        }
    }

    override func setNeedsDisplay(_ invalidRect: NSRect) {
        super.setNeedsDisplay(invalidRect)

        self.displayWasInvalidated = true
    }

    override func layout() {
        super.layout()

        self.layoutWasInvalidated = false
    }

}
#else
import UIKit

class TestView: UIView {

    @SetNeedsDisplay var testSetNeedsDisplay: CGFloat = 0.0

    @SetNeedsLayout var testSetNeedsLayout: CGFloat = 0.0

    @SetNeedsDisplayAndLayout var testSetNeedsDisplayAndLayout: CGFloat = 0.0

    var layoutWasInvalidated: Bool = false

    var displayWasInvalidated: Bool = false

    override func setNeedsLayout() {
        super.setNeedsLayout()

        self.layoutWasInvalidated = true
    }

    override func setNeedsDisplay() {
        super.setNeedsDisplay()

        self.displayWasInvalidated = true
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

        view.layoutWasInvalidated = false

        view.testSetNeedsLayout = 50.0

        XCTAssertTrue(view.layoutWasInvalidated)
    }

    func testDisplayInvalidation() {
        let view = TestView(frame: .zero)

        view.displayWasInvalidated = false

        view.testSetNeedsDisplay = 50.0

        XCTAssertTrue(view.displayWasInvalidated)
    }

    func testDisplayAndLayoutInvalidation() {
        let view = TestView(frame: .zero)

        view.layoutWasInvalidated = false
        view.displayWasInvalidated = false

        view.testSetNeedsDisplayAndLayout = 50.0

        XCTAssertTrue(view.displayWasInvalidated && view.layoutWasInvalidated)
    }

    static var allTests = [
        ("testLayoutInvalidation", testLayoutInvalidation),
    ]
}
