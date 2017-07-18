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

    // MARK: position tests

    func test_position_0_returns0() {
        subject = .create(position: 0)
        XCTAssertEqual(0, subject.position)
    }

    func test_position_5_returns5() {
        subject = .create(position: 5)
        XCTAssertEqual(5, subject.position)
    }

    // MARK: equals tests

    var lhs: Note!
    var rhs: Note!

    func test_equals_propertiesMatch_true() {
        (lhs, rhs) = (.create(), .create())
        Assert.symmetricEquality(lhs, rhs)
    }

    func test_equals_pitchesDiffer_false() {
        (lhs, rhs) = (.create(pitch: 5), .create())
        Assert.symmetricNonEquality(lhs, rhs)
    }

    func test_equals_lengthsDiffer_false() {
        (lhs, rhs) = (.create(length: 12), .create())
        Assert.symmetricNonEquality(lhs, rhs)
    }

    func test_equals_positionsDiffer_false() {
        (lhs, rhs) = (.create(position: 9), .create())
        Assert.symmetricNonEquality(lhs, rhs)
    }

    // MARK: hasOverlap tests

    var other: Note!

    func test_hasOverlap_sameNote_true() {
        (subject, other) = (.create(), .create())
        XCTAssertTrue(subject.hasOverlap(with: other))
    }

    func test_hasOverlap_pitchesDiffer_false() {
        (subject, other) = (.create(pitch: 120), .create())
        XCTAssertFalse(subject.hasOverlap(with: other))
    }

    func test_hasOverlap_lengthsDiffer_true() {
        (subject, other) = (.create(length: 5), .create())
        XCTAssertTrue(subject.hasOverlap(with: other))
    }

    func test_hasOverlap_sameNoteButNoOverlap_false() {
        (subject, other) = (.create(), .create(position: 50))
        XCTAssertFalse(subject.hasOverlap(with: other))
    }

    func test_hasOverlap_distanceLessThanLength_true() {
        (subject, other) = (.create(length: 3), .create(position: 2))
        XCTAssertTrue(subject.hasOverlap(with: other))
    }

    func test_hasOverlap_farFromOriginWithOverlap_true() {
        (subject, other) = (.create(length: 2, position: 30), .create(position: 31))
        XCTAssertTrue(subject.hasOverlap(with: other))
    }

    func test_hasOverlap_subjectFirstNoOverlap_false() {
        (subject, other) = (.create(), .create(position: 5))
        XCTAssertFalse(subject.hasOverlap(with: other))
    }
}

extension Note {
    static func create(
        pitch: Int = 0,
        length: Int = 1,
        position: Int = 0
    ) -> Note {
        return Note(
            pitch: pitch,
            length: length,
            position: position
        )
    }
}
