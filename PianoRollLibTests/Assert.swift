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
}
