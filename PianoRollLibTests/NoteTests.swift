import XCTest
@testable import PianoRollLib

class NoteTests: XCTestCase {
    
    func test_pitch_0_returns0() {
        let subject = Note(pitch: 0)
        XCTAssertEqual(0, subject.pitch)
    }
    
    func test_pitch_127_returns127() {
        let subject = Note(pitch: 127)
        XCTAssertEqual(127, subject.pitch)
    }
    
}
