import XCTest
@testable import PianoRollLib

class PianoRollTests: XCTestCase {
    
    var subject: PianoRoll!
    var mockRenderer: MockNoteRendering!

    override func setUp() {
        mockRenderer = MockNoteRendering()
        subject = PianoRoll(timeStepCount: 10)
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
        let expected: [Note] = [.create(), .create(pitch: 4, length: 2)]
        try subject.add(expected[0])
        try subject.add(expected[1])
        subject.render(with: mockRenderer)
        XCTAssertEqual(expected, mockRenderer.spyRenderedNotes)
    }

    // MARK: add tests

    func test_add_pitchMinus1_throwsError() {
        XCTAssertThrowsError(try subject.add(.create(pitch: -1)))
    }

    func test_add_pitchMinus5_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.add(.create(pitch: -5))
        )
    }
    
    func test_add_pitch128_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.add(.create(pitch: 128))
        )
    }
    
    func test_add_pitch144_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.add(.create(pitch: 144))
        )
    }
    
    func test_add_lengthMinus1_throwsError() {
        XCTAssertThrowsError(try subject.add(.create(length: -1)))
    }
    
    func test_add_lengthMinus5_throwsInvalidLengthError() {
        Assert.error(
            PianoRollError.invalidLength,
            isThrownIn: try subject.add(.create(length: -5))
        )
    }
    
    func test_add_length0_throwsInvalidLengthError() {
        Assert.error(
            PianoRollError.invalidLength,
            isThrownIn: try subject.add(.create(length: 0))
        )
    }
    
    func test_add_pitch0Length2_isRendered() throws {
        let expected: Note = .create(length: 2)
        try subject.add(expected)
        subject.render(with: mockRenderer)
        XCTAssertEqual([expected], mockRenderer.spyRenderedNotes)
    }

    func test_add_pitch100Length4_isRendered() throws {
        let expected: Note = .create(pitch: 100, length: 4)
        try subject.add(expected)
        subject.render(with: mockRenderer)
        XCTAssertEqual([expected], mockRenderer.spyRenderedNotes)
    }

    func test_add_positionIsNegative_throwsInvalidPositionError() {
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.add(.create(position: -1))
        )
    }

    func test_add_minus10_throwsInvalidPositionError() {
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.add(.create(position: -10))
        )
    }

    func test_add_10_timeStepCountIs10_throwsInvalidPositionError() {
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.add(.create(position: 10))
        )
    }

    func test_add_9_timeStepCount8_throwsInvalidPositionError() {
        var subject = PianoRoll(timeStepCount: 8)
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.add(.create(position: 9))
        )
    }

    func test_add_positionOccupiedByIdenticalNote_throwsInvalidPositionError() throws {
        let note: Note = .create()
        try subject.add(note)
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.add(note)
        )
    }

    func test_add_positionOccupiedBySamePitchDifferentLength_throwsInvalidPositionError() throws {
        try subject.add(.create(length: 1))
        Assert.error(
            PianoRollError.invalidPosition
            , isThrownIn: try subject.add(.create(length: 2))
        )
    }

    func test_add_positionOverlapsExistingNoteSlightly_throwsInvalidPositionError() throws {
        try subject.add(.create(length: 8))
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.add(.create(position: 7))
        )
    }

}
