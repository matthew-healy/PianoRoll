import XCTest
@testable import PianoRollLib

class PianoRollViewModelTests: XCTestCase {
    
    func test_pitchCount_exists() {
        let subject = PianoRollViewModel(pitchCount: 128)
        XCTAssertEqual(128, subject.pitchCount)
    }
    
    func test_pitchCount_notHardcoded() {
        let subject = PianoRollViewModel(pitchCount: 15)
        XCTAssertEqual(15, subject.pitchCount)
    }
    
}
