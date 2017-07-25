import XCTest
@testable import PianoRollLib

class PianoRollViewModelTests: XCTestCase {
    
    var subject: PianoRollViewModel!

    func test_pitchCount_exists() {
        subject = .create()
        XCTAssertEqual(0, subject.pitchCount)
    }
    
    func test_pitchCount_notHardcoded() {
        subject = .create(pitchCount: 15)
        XCTAssertEqual(15, subject.pitchCount)
    }
    
    func test_timeStepCount_exists() {
        subject = .create()
        XCTAssertEqual(0, subject.timeStepCount)
    }

    func test_timeStepCount_notHardcoded() {
        subject = .create(timeStepCount: 55)
        XCTAssertEqual(55, subject.timeStepCount)
    }

}

extension PianoRollViewModel {
    static func create(pitchCount: Int = 0, timeStepCount: Int = 0) -> PianoRollViewModel {
        return PianoRollViewModel(
            pitchCount: pitchCount,
            timeStepCount: timeStepCount
        )
    }
}
