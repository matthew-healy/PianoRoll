import XCTest
@testable import PianoRollLib

class PianoRollInteractorTests: XCTestCase {
    
    var mockNoteEditing: MockNoteEditing!
    var subject: PianoRollInteractor!

    override func setUp() {
        mockNoteEditing = MockNoteEditing()
        subject = PianoRollInteractor(noteEditor: mockNoteEditing)
    }

    func test_tapReceived_noNoteAtCoordinate_addsNote() {
        subject.tapReceived(at: .create())
        XCTAssertTrue(mockNoteEditing.didAddNote)
    }

    func test_tapReceived_noteExistsAtCoordinate_removesNote() {
        mockNoteEditing.stubHasNote = true
        subject.tapReceived(at: .create())
        XCTAssertTrue(mockNoteEditing.didRemoveNote)
    }

    func test_tapReceived_noNoteAtCoordinate_doesNotRemoveNote() {
        subject.tapReceived(at: .create())
        XCTAssertFalse(mockNoteEditing.didRemoveNote)
    }

    func test_tapReceived_noteExistsAtCoordinate_doesNotAddNote() {
        mockNoteEditing.stubHasNote = true
        subject.tapReceived(at: .create())
        XCTAssertFalse(mockNoteEditing.didAddNote)
    }

}
