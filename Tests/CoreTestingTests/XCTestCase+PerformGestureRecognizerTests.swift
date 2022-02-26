@testable import CoreTesting
import UIKit
import XCTest

final class XCTestCase_PerformGestureRecognizerTests: XCTestCase {
    private let expectedText = "New text after tap"

    func testPerformTapGestureRecognizer() {
        // Given
        let vc = MockLabelTapViewController()
        vc.setUp(expectedText: expectedText)
        XCTAssertEqual(vc.label.text, nil)

        // When
        performGestureRecognizer(of: UITapGestureRecognizer.self, on: vc.label, performer: vc)

        // Then
        XCTAssertEqual(vc.label.text, expectedText)

        // Finally
        assertNoMemoryLeaks(vc)
    }
}

final class MockLabelTapViewController: UIViewController {
    var label: UILabel!
    var expectedText: String?

    func setUp(expectedText: String) {
        self.expectedText = expectedText
        label = UILabel()
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLabel)))
    }

    @objc
    private func didTapLabel() {
        label.text = expectedText
    }
}
