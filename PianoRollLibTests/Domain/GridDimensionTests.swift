import XCTest
@testable import PianoRollLib

class GridDimensionTests: XCTestCase {
    
    var subject: GridDimension!
    
    func test_pitches_exists() {
        subject = .create()
        XCTAssertEqual(0, subject.pitches)
    }
    
    func test_pitches_notHardcoded() {
        subject = .create(pitches: 45)
        XCTAssertEqual(45, subject.pitches)
    }
    
    func test_timeSteps_exists() {
        subject = .create()
        XCTAssertEqual(0, subject.timeSteps)
    }
    
    func test_timeSteps_notHardcoded() {
        subject = .create(timeSteps: 100)
        XCTAssertEqual(100, subject.timeSteps)
    }

    // MARK: equals tests

    var lhs, rhs: GridDimension!

    func test_equals_propertiesMatch_true() {
        (lhs, rhs) = (.create(), .create())
        Assert.symmetricEquality(lhs, rhs)
    }

    func test_equals_pitchesDiffer_false() {
        (lhs, rhs) = (.create(pitches: 5), .create())
        Assert.symmetricNonEquality(lhs, rhs)
    }

    func test_equals_timeStepsDiffer_false() {
        (lhs, rhs) = (.create(timeSteps: 100), .create())
        Assert.symmetricNonEquality(lhs, rhs)
    }
}


extension GridDimension {
    static func create(pitches: Int = 0, timeSteps: Int = 0) -> GridDimension {
        return GridDimension(pitches: pitches, timeSteps: timeSteps)
    }
}
