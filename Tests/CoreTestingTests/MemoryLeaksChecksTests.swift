@testable import CoreTesting
import UIKit
import XCTest

final class MemoryLeaksChecksTests: XCTestCase {
    func testCheckMemoryLeaks() {
        let presenter = MockMemoryPresenter()
        let vc = MockMemoryViewController(presenter: presenter)

        assertNoMemoryLeaks(presenter)
        assertNoMemoryLeaks(vc)
    }

    func testRealMemoryLeakIsDetected() {
        // We will expect a memory leak to be found here
        XCTExpectFailure("The presenter in this case have a strong reference to the vc.")

        let presenter = MockMemoryPresenterWithMemoryLeak()
        let vc = MockMemoryViewController(presenter: presenter)

        assertNoMemoryLeaks(presenter)
        assertNoMemoryLeaks(vc)
    }
}

final class MockMemoryViewController: UIViewController {
    private var presenter: MockMemoryPresenting!

    init(presenter: MockMemoryPresenting) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
        self.presenter.set(delegate: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol MockMemoryPresenting {
    func set(delegate: MockMemoryViewController)
}

final class MockMemoryPresenter: MockMemoryPresenting {
    weak var delegate: MockMemoryViewController?

    func set(delegate: MockMemoryViewController) {
        self.delegate = delegate
    }
}

final class MockMemoryPresenterWithMemoryLeak: MockMemoryPresenting {
    var delegate: MockMemoryViewController?

    func set(delegate: MockMemoryViewController) {
        self.delegate = delegate
    }
}
