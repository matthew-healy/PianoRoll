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
}


extension GridDimension {
    static func create(pitches: Int = 0, timeSteps: Int = 0) -> GridDimension {
        return GridDimension(pitches: pitches, timeSteps: timeSteps)
    }
}
