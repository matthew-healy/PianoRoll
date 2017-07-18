import XCTest

struct Assert {
    static func symmetricEquality<T: Equatable>(_ lhs: T, _ rhs: T, file: StaticString = #file, line: UInt = #line) {
        XCTAssert(lhs == rhs, file: file, line: line)
        XCTAssert(rhs == lhs, file: file, line: line)
    }

    static func symmetricNonEquality<T: Equatable>(_ lhs: T, _ rhs: T, file: StaticString = #file, line: UInt = #line) {
        XCTAssert(lhs != rhs, file: file, line: line)
        XCTAssert(rhs != lhs, file: file, line: line)
    }

    static func error<T: Error & Equatable>(
        _ error: T,
        isThrownIn expression: @autoclosure () throws -> (),
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertThrowsError(try expression(), "", file: file, line: line) {
            XCTAssertEqual(error, $0 as? T, file: file, line: line)
        }
    }
}
