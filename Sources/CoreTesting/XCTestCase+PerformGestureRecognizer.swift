//
//  XCTestCase+PerformGestureRecognizer.swift
//  
//
//  Created by Manu Herrera on 26/02/2022.
//

import XCTest

extension XCTestCase {
    /// Performs a gesture recognizer of type `type`
    /// - Parameters:
    ///    - type: The gesture recognizer
    ///    - view: the view on which to perform the gesture
    ///    - performer: responder that needs to execute the action (`nil` if the performer is the `view` parameter)
    func performGestureRecognizer<GestureRecognizer: UIGestureRecognizer>(
        of type: GestureRecognizer.Type,
        on view: UIView,
        performer: UIResponder? = nil
    ) {
        guard let selector = view.extractGestureSelector(of: type) else { return }

        let performer: UIResponder = performer ?? view
        performer.perform(selector)
    }
}

private extension UIView {
    func extractGestureSelector<GestureRecognizer: UIGestureRecognizer>(of type: GestureRecognizer.Type) -> Selector? {
        guard let gesture = gestureRecognizers?.first(where: { $0 is GestureRecognizer }),
            let target = gesture.firstTarget()
        else { return nil }

        let selectorString = String(describing: target).unwrapSelectorDescription()
        return Selector(selectorString)
    }
}

private extension UIGestureRecognizer {
    private enum Constants {
        static let targetsKeyPath = "_targets"
    }

    func firstTarget() -> NSObject? {
        (value(forKey: Constants.targetsKeyPath) as? [NSObject])?.first
    }
}

private extension String {
    func unwrapSelectorDescription() -> String {
        self.components(separatedBy: ", ")
            .first?
            .replacingOccurrences(of: "(action=", with: "")
            .replacingOccurrences(of: "Optional(", with: "")
        ?? ""
    }
}
