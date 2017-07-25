import XCTest
@testable import PianoRollLib

class IndexPathPianoRollTests: XCTestCase {
    
    func test_pitch_exists() {
        let subject = IndexPath(pitch: 0, time: 0)
        XCTAssertEqual(0, subject.pitch)
    }
    
    func test_pitch_notHardcoded() {
        let subject = IndexPath(pitch: 5, time: 0)
        XCTAssertEqual(5, subject.pitch)
    }
    
    func test_time_exists() {
        let subject = IndexPath(pitch: 0, time: 0)
        XCTAssertEqual(0, subject.time)
    }
    
    func test_time_notHardcoded() {
        let subject = IndexPath(pitch: 0, time: 66)
        XCTAssertEqual(66, subject.time)
    }
    
}
