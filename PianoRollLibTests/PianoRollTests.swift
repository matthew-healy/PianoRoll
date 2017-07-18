import XCTest
@testable import PianoRollLib

class PianoRollTests: XCTestCase {
    
    var subject: PianoRoll!
    var mockRenderer: MockNoteRendering!

    override func setUp() {
        mockRenderer = MockNoteRendering()
        subject = PianoRoll()
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

    // MARK: addNote tests

    func test_addNote_pitchMinus1_throwsError() {
        XCTAssertThrowsError(try subject.add(.create(pitch: -1)))
    }

    func test_addNote_pitchMinus5_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.add(.create(pitch: -5))
        )
    }
    
    func test_addNote_pitch128_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.add(.create(pitch: 128))
        )
    }
    
    func test_addNote_pitch144_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.add(.create(pitch: 144))
        )
    }
    
    func test_addNote_lengthMinus1_throwsError() {
        XCTAssertThrowsError(try subject.add(.create(length: -1)))
    }
    
    func test_addNote_lengthMinus5_throwsInvalidLengthError() {
        Assert.error(
            PianoRollError.invalidLength,
            isThrownIn: try subject.add(.create(length: -5))
        )
    }
    
    func test_addNote_length0_throwsInvalidLengthError() {
        Assert.error(
            PianoRollError.invalidLength,
            isThrownIn: try subject.add(.create(length: 0))
        )
    }
    
    func test_addNote_pitch0Length2_isRendered() throws {
        let expected: Note = .create(length: 2)
        try subject.add(expected)
        subject.render(with: mockRenderer)
        XCTAssertEqual([expected], mockRenderer.spyRenderedNotes)
    }

    func test_addNote_pitch100Length4_isRendered() throws {
        let expected: Note = .create(pitch: 100, length: 4)
        try subject.add(expected)
        subject.render(with: mockRenderer)
        XCTAssertEqual([expected], mockRenderer.spyRenderedNotes)
    }

}
