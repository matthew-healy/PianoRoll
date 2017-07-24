import XCTest
@testable import PianoRollLib

class PianoRollCoordinateTests: XCTestCase {
    
    func test_canGetPitch() {
        let subject = PianoRollCoordinate(pitch: 1)
        Assert.symmetricEquality(1, subject.pitch)
    }
    
    func test_pitchIsNotHardcoded() {
        let subject = PianoRollCoordinate(pitch: 5)
        Assert.symmetricEquality(5, subject.pitch)
    }
    
}
