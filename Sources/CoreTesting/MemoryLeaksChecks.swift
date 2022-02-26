//
//  MemoryLeaksChecks.swift
//  
//
//  Created by Manu Herrera on 24/02/2022.
//

import Foundation
import XCTest

public extension XCTestCase {
    func assertNoMemoryLeaks(
        _ instance: AnyObject,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "Instance should have been deallocated. Potential memory leak!",
                file: file,
                line: line
            )
        }
    }
}
