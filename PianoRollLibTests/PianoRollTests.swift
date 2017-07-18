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
        try subject.add(expected[0], atPosition: 0)
        try subject.add(expected[1], atPosition: 0)
        subject.render(with: mockRenderer)
        XCTAssertEqual(expected, mockRenderer.spyRenderedNotes)
    }

    // MARK: add(_:atPosition:) tests

    func test_addAtPosition_pitchMinus1_throwsError() {
        XCTAssertThrowsError(try subject.add(.create(pitch: -1), atPosition: 0))
    }

    func test_addAtPosition_pitchMinus5_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.add(.create(pitch: -5), atPosition: 0)
        )
    }
    
    func test_addAtPosition_pitch128_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.add(.create(pitch: 128), atPosition: 0)
        )
    }
    
    func test_addAtPosition_pitch144_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.add(.create(pitch: 144), atPosition: 0)
        )
    }
    
    func test_addAtPosition_lengthMinus1_throwsError() {
        XCTAssertThrowsError(try subject.add(.create(length: -1), atPosition: 0))
    }
    
    func test_addAtPosition_lengthMinus5_throwsInvalidLengthError() {
        Assert.error(
            PianoRollError.invalidLength,
            isThrownIn: try subject.add(.create(length: -5), atPosition: 0)
        )
    }
    
    func test_addAtPosition_length0_throwsInvalidLengthError() {
        Assert.error(
            PianoRollError.invalidLength,
            isThrownIn: try subject.add(.create(length: 0), atPosition: 0)
        )
    }
    
    func test_addAtPosition_pitch0Length2_isRendered() throws {
        let expected: Note = .create(length: 2)
        try subject.add(expected, atPosition: 0)
        subject.render(with: mockRenderer)
        XCTAssertEqual([expected], mockRenderer.spyRenderedNotes)
    }

    func test_addAtPosition_pitch100Length4_isRendered() throws {
        let expected: Note = .create(pitch: 100, length: 4)
        try subject.add(expected, atPosition: 0)
        subject.render(with: mockRenderer)
        XCTAssertEqual([expected], mockRenderer.spyRenderedNotes)
    }

    func test_addAtPosition_positionIsNegative_throwsInvalidPositionError() {
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.add(.create(), atPosition: -1)
        )
    }

    func test_addAtPosition_minus10_throwsInvalidPositionError() {
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.add(.create(), atPosition: -10)
        )
    }

    func test_addAtPosition_10_timeStepCountIs10_throwsInvalidPositionError() {
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.add(.create(), atPosition: 10)
        )
    }

    func test_addAtPosition_9_timeStepCount8_throwsInvalidPositionError() {
        var subject = PianoRoll(timeStepCount: 8)
        Assert.error(
            PianoRollError.invalidPosition,
            isThrownIn: try subject.add(.create(), atPosition: 9)
        )
    }

}
