import XCTest
@testable import PianoRollLib

class PianoRollTests: XCTestCase {
    
    var subject: PianoRoll!
    var mockRenderer: MockNoteRendering!

    override func setUp() {
        mockRenderer = MockNoteRendering()
        subject = PianoRoll(timeStepCount: 10)
    }

    // MARK: numberOfPitches tests

    func test_numberOfPitches_128() {
        XCTAssertEqual(128, subject.numberOfPitches)
    }

    // MARK: numberOfTimeSteps tests

    func test_numberOfTimeSteps_timeStepCountIs10_10() {
        XCTAssertEqual(10, subject.numberOfTimeSteps)
    }

    func test_numberOfTimeSteps_timeStepCountIs25_25() {
        subject = PianoRoll(timeStepCount: 25)
        XCTAssertEqual(25, subject.numberOfTimeSteps)
    }

    // MARK: render tests

    func test_render_callsRenderOnRenderer() {
        subject.render(with: mockRenderer)
        XCTAssertTrue(mockRenderer.didRender)
    }
    
    func test_render_noNotesAdded_passesEmptyNotesArrayToRenderer() {
        subject.render(with: mockRenderer)
        XCTAssertEqual([], mockRenderer.spyRenderedNotes)
    }

    func test_render_multipleValidNotesAdded_passesAllNotesToRenderer() throws {
        let expected: [Note] = [.create(), .create(pitch: 4)]
        try subject.addNote(at: .create())
        try subject.addNote(at: .create(pitch: 4))
        subject.render(with: mockRenderer)
        XCTAssertEqual(expected, mockRenderer.spyRenderedNotes)
    }

    // MARK: addNote(at:) tests

    func test_add_pitchMinus1_throwsError() {
        XCTAssertThrowsError(try subject.addNote(at: .create(pitch: -1)))
    }

    func test_add_pitchMinus5_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.addNote(at: .create(pitch: -5))
        )
    }
    
    func test_add_pitch128_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.addNote(at: .create(pitch: 128))
        )
    }
    
    func test_add_pitch144_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.addNote(at: .create(pitch: 144))
        )
    }
    
    func test_add_pitch0_isRendered() throws {
        try subject.addNote(at: .create())
        subject.render(with: mockRenderer)
        XCTAssertEqual([.create()], mockRenderer.spyRenderedNotes)
    }

    func test_add_pitch100_isRendered() throws {
        try subject.addNote(at: .create(pitch: 100))
        subject.render(with: mockRenderer)
        XCTAssertEqual([.create(pitch: 100)], mockRenderer.spyRenderedNotes)
    }

    func test_add_timeIsNegative_throwsInvalidPositionError() {
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.addNote(at: .create(time: -1))
        )
    }

    func test_add_minus10_throwsInvalidPositionError() {
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.addNote(at: .create(time: -10))
        )
    }

    func test_add_10_timeStepCountIs10_throwsInvalidPositionError() {
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.addNote(at: .create(time: 10))
        )
    }

    func test_add_9_timeStepCount8_throwsInvalidPositionError() {
        subject = PianoRoll(timeStepCount: 8)
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.addNote(at: .create(time: 9))
        )
    }

    func test_add_positionOccupiedByIdenticalNote_throwsInvalidPositionError() throws {
        try subject.addNote(at: .create())
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.addNote(at: .create())
        )
    }

    // MARK: removeNote(at:) tests

    func test_remove_pitchOutOfRange_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.removeNote(at: .create(pitch: -1))
        )
    }

    func test_remove_timeOutOfRange_throwsInvalidPosition() {
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.removeNote(at: .create(time: 500))
        )
    }

    func test_remove_noteIsThere_removesIt() throws {
        try addNote()
        try subject.removeNote(at: .create())
        subject.render(with: mockRenderer)
        XCTAssertTrue(mockRenderer.spyRenderedNotes.isEmpty)
    }

    private func addNote(pitch: Int = 0, time: Int = 0) throws {
        let coordinate: PianoRollCoordinate = .create(pitch: pitch, time: time)
        try subject.addNote(at: coordinate)
    }

    func test_remove_noteIsNotThere_nothingIsRemoved() throws {
        try addNote()
        try subject.removeNote(at: .create(pitch: 1, time: 1))
        subject.render(with: mockRenderer)
        XCTAssertFalse(mockRenderer.spyRenderedNotes.isEmpty)
    }

    func test_remove_noteIsNotFirstInArray_stillRemoves() throws {
        try addNote()
        try addNote(pitch: 3)
        try subject.removeNote(at: .create(pitch: 3))
        subject.render(with: mockRenderer)
        XCTAssertEqual([.create()], mockRenderer.spyRenderedNotes)
    }

    // MARK: hasNote(at:) tests

    func test_hasNote_pitchNegative_false() {
        let result = subject.hasNote(at: .create(pitch: -1))
        XCTAssertFalse(result)
    }

    func test_hasNote_pitchAndTimeMatch_true() throws {
        try addNote()
        let result = subject.hasNote(at: .create())
        XCTAssertTrue(result)
    }

    func test_hasNote_timeNegative_false() {
        let result = subject.hasNote(at: .create(time: -1))
        XCTAssertFalse(result)
    }

    func test_hasNote_differentPitchAndTimeMatch_true() throws {
        try addNote(pitch: 5, time: 3)
        let result = subject.hasNote(at: .create(pitch: 5, time: 3))
        XCTAssertTrue(result)
    }

}
