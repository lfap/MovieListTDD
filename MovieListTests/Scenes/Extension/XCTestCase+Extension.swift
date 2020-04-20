//
//  XCTestCase+Extension.swift
//  MovieListTDDTests
//
//  Created by Luiz F. A. Pio on 15/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import XCTest

extension XCTestCase {
    func assert<T, U: Error & Equatable>(_ expression: @autoclosure () throws -> T, toThrow error: U, file: StaticString = #file, line: UInt = #line) {
        var receivedError: U!
        XCTAssertThrowsError(try expression(), file: file, line: line) {
            receivedError = $0 as? U
        }
        XCTAssertEqual(receivedError, error, file: file, line: line)
    }
}
