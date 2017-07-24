import XCTest
@testable import PianoRollLib

class PianoRollCoordinateTests: XCTestCase {
    
    var subject: PianoRollCoordinate!

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
        Assert.symmetricEquality(1, subject.time)
    }

    func test_timeIsNotHardcoded() {
        subject = .create(time: 4)
        XCTAssertEqual(4, subject.time)
    }

}

extension PianoRollCoordinate {
    static func create(
        pitch: Int = 0,
        time: Int = 1
    ) -> PianoRollCoordinate {
        return PianoRollCoordinate(
            pitch: pitch,
            time: time
        )
    }
}
