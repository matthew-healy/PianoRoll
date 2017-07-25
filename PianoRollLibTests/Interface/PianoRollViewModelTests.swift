import XCTest
@testable import PianoRollLib

class PianoRollViewModelTests: XCTestCase {
    
    var subject: PianoRollViewModel!

    // MARK: property tests

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

    // MARK: equals tests

    var lhs, rhs: PianoRollViewModel!

    func test_equals_propertiesMatch_true() {
        (lhs, rhs) = (.create(), .create())
        Assert.symmetricEquality(lhs, rhs)
    }

    func test_dimensionsDiffer_false() {
        (lhs, rhs) = (.create(pitchCount: 55), .create())
        Assert.symmetricNonEquality(lhs, rhs)
    }

    func test_itemsDiffer_false() {
        (lhs, rhs) = (.create(items: [(0, 1)]), .create())
        Assert.symmetricNonEquality(lhs, rhs)
    }

    // MARK: item(at:) tests

    func test_itemAt_noItem_false() {
        subject = .create()
        let result = subject.item(at: IndexPath(item: 0, section: 0))
        XCTAssertFalse(result)
    }

    func test_itemAt_item1section3_itemThere_true() {
        subject = .create(items: [(1, 3)])
        let result = subject.item(at: IndexPath(pitch: 1, time: 3))
        XCTAssertTrue(result)
    }

    func test_itemAt_item4section2_itemThere_true() {
        subject = .create(items: [(4, 2)])
        let result = subject.item(at: IndexPath(pitch: 4, time: 2))
        XCTAssertTrue(result)
    }

    func test_itemAt_itemIsNotFirstInArray_true() {
        subject = .create(items: [(1, 1), (0, 9), (2, 2)])
        let result = subject.item(at: IndexPath(pitch: 2, time: 2))
        XCTAssertTrue(result)
    }

}

extension PianoRollViewModel {
    static func create(
        pitchCount: Int = 0,
        timeStepCount: Int = 0,
        items: [(Int, Int)] = []
    ) -> PianoRollViewModel {
        return PianoRollViewModel(
            dimension: .create(pitches: pitchCount, timeSteps: timeStepCount),
            items: items
        )
    }
}
