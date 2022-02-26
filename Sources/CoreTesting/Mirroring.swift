//
//  Mirroring.swift
//  
//
//  Created by Manu Herrera on 24/02/2022.
//

import Foundation
import XCTest

/// This protocol is used as the base for accessing private properties of objects.
///
/// Usage:
/// - Create a new class for the object you want to test that implements `Mirroring`.
/// - Add the properties using the same name as in the original implementation.
///
/// Example:
/// - Checkout `MockViewControllerMirror` for an example in the test target.
public protocol Mirroring: AnyObject {
    var mirror: Mirror { get set }

    func extract<Class>(variableName: StaticString) -> Class
}

public extension Mirroring {
    func extract<Class>(variableName: StaticString = #function) -> Class {
        extract(variableName: variableName, mirror: mirror)
    }

    private func extract<Class>(variableName: StaticString, mirror: Mirror) -> Class {
        guard let descendant = mirror.descendant("\(variableName)") as? Class else {
            guard let superclassMirror = mirror.superclassMirror else {
                fatalError("Expected Mirror for superclass")
            }
            return extract(variableName: variableName, mirror: superclassMirror)
        }
        guard let result: Class = try? XCTUnwrap(descendant) else {
            fatalError("Expected unwrapped result")
        }
        return result
    }
}
