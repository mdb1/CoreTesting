@testable import CoreTesting
import UIKit
import XCTest

final class UIControl_SimulateTapTests: XCTestCase {
    func testTouchUpInside() {
        // Given
        let button = UIButton()
        let label = UILabel()
        let expectedText = "New text after tap"
        XCTAssertEqual(label.text, nil)
        button.addAction(
            .init(handler: { _ in
                label.text = expectedText
            }),
            for: .touchUpInside
        )

        // When
        button.simulateTouchUpInside()

        // Then
        XCTAssertEqual(label.text, expectedText)

        // Finally
        assertNoMemoryLeaks(button)
        assertNoMemoryLeaks(label)
    }
}
