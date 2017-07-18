import XCTest
@testable import PianoRollLib

class NoteTests: XCTestCase {
    
    var subject: Note!

    // MARK: pitch tests

    func test_pitch_0_returns0() {
        subject = .create()
        XCTAssertEqual(0, subject.pitch)
    }
    
    func test_pitch_127_returns127() {
        subject = .create(pitch: 127)
        XCTAssertEqual(127, subject.pitch)
    }
    
    // MARK: length tests

    func test_length_1_returns1() {
        subject = .create()
        XCTAssertEqual(1, subject.length)
    }

    func test_length_5_returns5() {
        subject = .create(length: 5)
        XCTAssertEqual(5, subject.length)
    }
}

extension Note {
    static func create(
        pitch: Int = 0,
        length: Int = 1
    ) -> Note {
        return Note(
            pitch: pitch,
            length: length
        )
    }
}
