import XCTest
@testable import PianoRollLib

class PianoRollCoordinateTests: XCTestCase {
    
    var subject: PianoRollCoordinate!

    // MARK: property tests

    func test_canGetPitch() {
        subject = .create()
        Assert.symmetricEquality(0, subject.pitch)
    }
    
    func test_pitchIsNotHardcoded() {
        subject = .create(pitch: 5)
        Assert.symmetricEquality(5, subject.pitch)
    }
    
    func test_canGetTime() {
        subject = .create()
        Assert.symmetricEquality(0, subject.time)
    }

    func test_timeIsNotHardcoded() {
        subject = .create(time: 4)
        XCTAssertEqual(4, subject.time)
    }

    // MARK: equals tests

    var lhs, rhs: PianoRollCoordinate!

    func test_equals_propertiesMatch_true() {
        (lhs, rhs) = (.create(), .create())
        Assert.symmetricEquality(lhs, rhs)
    }

    func test_equals_pitchesDiffer_false() {
        (lhs, rhs) = (.create(), .create(pitch: 5))
        Assert.symmetricNonEquality(lhs, rhs)
    }

    func test_equals_timesDiffer_false() {
        (lhs, rhs) = (.create(), .create(time: 3))
        Assert.symmetricNonEquality(lhs, rhs)
    }

}

extension PianoRollCoordinate {
    static func create(
        pitch: Int = 0,
        time: Int = 0
    ) -> PianoRollCoordinate {
        return PianoRollCoordinate(
            pitch: pitch,
            time: time
        )
    }
}
