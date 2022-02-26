# CoreTesting

This package contains useful resources to be shared for unit testing.

## Memory Leaks Checks

This is a method to be used at the end of the unit tests to determine that the instance gets deallocated from memory correctly; ie: no memory leaks 😄. Way faster than using the memory graph 😉.

It leverages the `addTeardownBlock` method on `XCTest`:

`* Teardown blocks are executed after the current test method has returned but before tearDown is invoked.`

`func assertNoMemoryLeaks(_ instance: AnyObject)`

### Usage

```swift
func testCheckMemoryLeaks() {
    let presenter = MockMemoryPresenter()
    let vc = MockMemoryViewController(presenter: presenter)

    assertNoMemoryLeaks(presenter)
    assertNoMemoryLeaks(vc)
}
```

In the case that there were a retail cycle between presenter and vc, the test would fail!

## Mirroring

By conforming any class to the `Mirroring` protocol, we gain the `reflection` ability on it. We can have access on the unit tests target to the private properties of the class. This is very useful to assert things over private UI elements of a UIViewController for example.

### Usage

```swift
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
```

## UIControl+SimulateTap

This is just a small extension on UIControl to simulate `touchUpInside` behavior on the unit tests.

### Usage
```swift
button.simulateTouchUpInside()
```

## XCTestCase+PerformGestureRecognizer

This is a kind of tricky extension to add the ability to perform gesture recognizers on views on the unit tests using selectors.

### Usage
```swift
performGestureRecognizer(of: UITapGestureRecognizer.self, on: customLabel)
```
