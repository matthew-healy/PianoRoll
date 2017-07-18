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

    // MARK: addNote tests

    func test_addNote_pitchMinus1_throwsError() {
        XCTAssertThrowsError(try subject.addNote(pitch: -1, length: 1))
    }

    func test_addNote_pitchMinus5_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.addNote(pitch: -5, length: 1)
        )
    }
    
    func test_addNote_pitch128_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.addNote(pitch: 128, length: 1)
        )
    }
    
    func test_addNote_pitch144_throwsPitchOutOfRangeError() {
        Assert.error(
            PianoRollError.pitchOutOfRange,
            isThrownIn: try subject.addNote(pitch: 144, length: 1)
        )
    }
    
    func test_addNote_lengthMinus1_throwsError() {
        XCTAssertThrowsError(try subject.addNote(pitch: 0, length: -1))
    }
    
    func test_addNote_lengthMinus5_throwsInvalidLengthError() {
        Assert.error(
            PianoRollError.invalidLength,
            isThrownIn: try subject.addNote(pitch: 0, length: -5)
        )
    }
    
    func test_addNote_length0_throwsInvalidLengthError() {
        Assert.error(
            PianoRollError.invalidLength,
            isThrownIn: try subject.addNote(pitch: 0, length: 0))
    }
    
    func test_addNote_pitch0Length2_isRendered() throws {
        try subject.addNote(pitch: 0, length: 2)
        subject.render(with: mockRenderer)
        XCTAssertEqual([Note(pitch: 0, length: 2)], mockRenderer.spyRenderedNotes)
    }

    func test_addNote_pitch100Length4_isRendered() throws {
        try subject.addNote(pitch: 100, length: 4)
        subject.render(with: mockRenderer)
        XCTAssertEqual([Note(pitch: 100, length: 4)], mockRenderer.spyRenderedNotes)
    }

}
