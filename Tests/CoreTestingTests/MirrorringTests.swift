@testable import CoreTesting
import UIKit
import XCTest

final class MirroringTests: XCTestCase {
    func testMirrorAccess() {
        // Given
        let vc = MockViewController()
        let vcMirror = MockViewControllerMirror(reflecting: vc)
        let label = vcMirror.label
        let expectedText = "This is the new value"
        XCTAssertNil(label.text)

        // When
        vc.changeLabelText(expectedText)

        // Then
        XCTAssertEqual(label.text, expectedText)
    }
}

final class MockViewController: UIViewController {
    private var label: UILabel! = UILabel()

    func changeLabelText(_ text: String) {
        label.text = text
    }
}

final class MockViewControllerMirror: Mirroring {
    var mirror: Mirror

    init(reflecting: MockViewController) {
        mirror = Mirror(reflecting: reflecting)
    }

    var label: UILabel { extract() }
}
